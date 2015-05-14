context("lawn_featurecollection")

# points
features <- list(
  lawn_point(c(-75.343, 39.984), properties = list(name = 'Location A')),
  lawn_point(c(-75.833, 39.284), properties = list(name = 'Location B')),
  lawn_point(c(-75.534, 39.123), properties = list(name = 'Location C'))
)
a <- lawn_featurecollection(features)

pt1 <- lawn_point(c(-75.343, 39.984), properties = list(name = 'Location A'))
a_pt <- lawn_featurecollection(pt1)

test_that("lawn_featurecollection works - points", {
  expect_is(a, "featurecollection")
  expect_is(unclass(a), "list")
  expect_is(a$type, "character")
  expect_equal(a$type, "FeatureCollection")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates[[1]], "numeric")
  expect_equal(a$features$properties$name[1], "Location A")

  expect_is(a_pt, "featurecollection")
  expect_equal(a$type, "FeatureCollection")
  expect_is(a$features, "data.frame")
})

# polygons
rings <- list(list(
   c(-2.275543, 53.464547),
   c(-2.275543, 53.489271),
   c(-2.215118, 53.489271),
   c(-2.215118, 53.464547),
   c(-2.275543, 53.464547)
))
rings2 <- list(list(
   c(-2.775543, 54.464547),
   c(-2.775543, 54.489271),
   c(-2.245118, 54.489271),
   c(-2.245118, 54.464547),
   c(-2.775543, 54.464547)
))
features <- list(
  lawn_polygon(rings, properties = list(name = 'poly1', population = 400)),
  lawn_polygon(rings2, properties = list(name = 'poly2', population = 5000))
)
b <- lawn_featurecollection(features)
b_poly <- lawn_featurecollection(lawn_polygon(rings2))

test_that("lawn_featurecollection works - polygons", {
  expect_is(b, "featurecollection")
  expect_is(unclass(b), "list")
  expect_is(b$type, "character")
  expect_is(b$features, "data.frame")
  expect_is(b$features$geometry$type, "character")
  expect_is(b$features$geometry$coordinates[[1]], "array")
  expect_equal(b$features$properties$population[1], 400)

  expect_is(b_poly, "featurecollection")
  expect_equal(b_poly$type, "FeatureCollection")
  expect_is(b_poly$features, "data.frame")
})

# linestrings
pts1 <- list(
   c(-2.364416, 53.448203),
   c(-2.356176, 53.441316),
   c(-2.33901, 53.435924),
   c(-2.327337, 53.436673)
)
pts2 <- rapply(pts1, function(x) x + 0.1, how = "list")
features <- list(
  lawn_linestring(pts1, properties = list(name = 'line1', distance = 145)),
  lawn_linestring(pts2, properties = list(name = 'line2', distance = 145))
)
c <- lawn_featurecollection(features)
c_line <- lawn_featurecollection(lawn_linestring(pts1))

test_that("lawn_featurecollection works - linestrings", {
  expect_is(c, "featurecollection")
  expect_is(unclass(c), "list")
  expect_is(c$type, "character")
  expect_is(c$features, "data.frame")
  expect_is(c$features$geometry$type, "character")
  expect_is(c$features$geometry$coordinates[[1]], "matrix")
  expect_equal(c$features$properties$distance[1], 145)

  expect_is(c_line, "featurecollection")
  expect_equal(c_line$type, "FeatureCollection")
  expect_is(c_line$features, "data.frame")
})

# Return self if a featurecollection class passed
tmp_self <- lawn_featurecollection(features)
self1 <- lawn_featurecollection(tmp_self)

test_that("lawn_featurecollection works - self", {
  expect_is(tmp_self, "featurecollection")
  expect_is(self1, "featurecollection")
  expect_equal(tmp_self, self1)
})

# json featurecollection passed in
suppressPackageStartupMessages(library("jsonlite", quietly = TRUE))
str <- jsonlite::toJSON(unclass(self1))
json1 <- lawn_featurecollection(str)

test_that("lawn_featurecollection works - json", {
  expect_is(json1, "featurecollection")
  expect_is(unclass(json1), "list")
  expect_is(json1$features, "data.frame")
  expect_equal(json1, self1)
})

# from a centroid object
poly <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Polygon",
    "coordinates": [[
      [105.818939,21.004714],
      [105.818939,21.061754],
      [105.890007,21.061754],
      [105.890007,21.004714],
      [105.818939,21.004714]
     ]]
  }
}'
centroid <- lawn_centroid(poly)
cent1 <- lawn_featurecollection(centroid)

test_that("lawn_featurecollection works - centroid", {
  expect_is(cent1, "featurecollection")
  expect_is(cent1$type, "character")
  expect_is(cent1$features, "data.frame")
})

# fails well ----------------------------
test_that("lawn_featurecollection fails correctly", {
  expect_error(lawn_featurecollection(), "no applicable method")
  expect_error(lawn_featurecollection(5), "applied to an object of class")
  expect_error(lawn_featurecollection(rings), "applied to an object of class \"list\"")
})
