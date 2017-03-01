## master...origin/master
 M R/featurecollection.R
 M R/hex_grid.R
 M R/zzz.R
?? GADM_2.8_LKA_adm0.rds
➜  lawn git:(master) ✗ git diff R/zzz.R
➜  lawn git:(master) ✗ git diff R/hex_grid.R
➜  lawn git:(master) ✗ git diff R/featurecollection.R
➜  lawn git:(master) ✗

diff --git a/R/featurecollection.R b/R/featurecollection.R
index 44bb832..6baa571 100644
--- a/R/featurecollection.R
+++ b/R/featurecollection.R
@@ -119,19 +119,29 @@ lawn_featurecollection.list <- function(features) {
   if (!is.null(names(features))) {
     lawn_featurecollection(jsonlite::toJSON(features))
   } else {
-    do_fc(lapply(features, function(z){
+    tmp <- lapply(features, function(z){
       if (inherits(z, "character")) {
-        lawn_featurecollection(z)
+        list(lawn_featurecollection(z))
       } else if (inherits(z, "featurecollection")) {
-        type <- tolower(z$features$geometry$type)
-        switch(type,
-               polygon = lawn_polygon(z$features$geometry$coordinates[[1]]),
-               point = lawn_point(z$features$geometry$coordinates[[1]]),
-               linestring = lawn_linestring(z$features$geometry$coordinates[[1]]))
+        type <- tolower(z$features$geometry$type)[1]
+        switch(
+          type,
+          #polygon = lawn_polygon(z$features$geometry$coordinates[[1]]),
+          polygon = lapply(z$features$geometry$coordinates, lawn_polygon),
+          #multipolygon = lawn_multipolygon(z$features$geometry$coordinates[[1]]),
+          multipolygon = lapply(z$features$geometry$coordinates, lawn_multipolygon),
+          #point = lawn_point(z$features$geometry$coordinates[[1]]),
+          point = lapply(z$features$geometry$coordinates, lawn_point),
+          #linestring = lawn_linestring(z$features$geometry$coordinates[[1]]),
+          linestring = lapply(z$features$geometry$coordinates, lawn_linestring),
+          featurecollection = list(z)
+        )
       } else {
-        z
+        list(z)
       }
-    }))
+    })
+
+    do_fc(do.call(c, tmp))
   }
 }

diff --git a/R/hex_grid.R b/R/hex_grid.R
index 9e1f35a..d7b55bd 100644
--- a/R/hex_grid.R
+++ b/R/hex_grid.R
@@ -20,4 +20,5 @@
 lawn_hex_grid <- function(extent, cellWidth, units) {
   ct$eval(sprintf("var hg = turf.hexGrid(%s, %s, '%s');", toj(extent), cellWidth, units))
   as.fc(ct$get("hg"))
+  #as.fc(ct$get("hg", simplifyDataFrame = FALSE, simplifyMatrix = FALSE))
 }
diff --git a/R/zzz.R b/R/zzz.R
index b11f3fd..d24fca3 100644
--- a/R/zzz.R
+++ b/R/zzz.R
@@ -3,6 +3,13 @@ convert <- function(x) {
   if (is.character(x)) {
     x
   } else {
+    x1 <- tryCatch(x[[1]], error = function(e) e)
+    if (!inherits(x1, "error")) {
+      if (inherits(x[[1]], "array")) {
+        x <- x[[1]]
+        x <- lapply(apply(unname(data.frame(x[,,])), 1, as.list), unlist, recursive = FALSE)
+      }
+    }
     jsonlite::toJSON(unclass(x), auto_unbox = TRUE, digits = 22)
   }
 }
