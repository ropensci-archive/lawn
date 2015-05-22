#' Lawn print methods to provide summary view
#'
#' @name print-methods
#' @param x input
#' @param n (integer) Number of rows to print, when properties is large object
#' @param ... print options
#' @examples
#' # point
#' lawn_point(c(-74.5, 40))
#'
#' # polygon
#' rings <- list(list(
#'    c(-2.275543, 53.464547),
#'    c(-2.275543, 53.489271),
#'    c(-2.215118, 53.489271),
#'    c(-2.215118, 53.464547),
#'    c(-2.275543, 53.464547)
#' ))
#' lawn_polygon(rings, properties = list(name = 'poly1', population = 400))
#'
#' # linestring
#' linestring1 <- '[
#'    [-21.964416, 64.148203],
#'    [-21.956176, 64.141316],
#'    [-21.93901, 64.135924],
#'    [-21.927337, 64.136673]
#' ]'
#' lawn_linestring(linestring1)
#' lawn_linestring(linestring1, properties = list(name = 'line1', distance = 145))
#'
#' # featurecollection
#' lawn_featurecollection(lawn_data$featurecollection_eg1)
#'
#' # feature
#' serbia <- '{
#'   "type": "Feature",
#'   "properties": {"color": "red"},
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [20.566406, 43.421008]
#'    }
#' }'
#' lawn_flip(serbia)
#'
#' # multipoint
#' mpt <- '{
#'  "type": "FeatureCollection",
#'  "features": [
#'    {
#'      "type": "Feature",
#'      "properties": {},
#'      "geometry": {
#'        "type": "Point",
#'        "coordinates": [19.026432, 47.49134]
#'      }
#'    }, {
#'      "type": "Feature",
#'      "properties": {},
#'      "geometry": {
#'        "type": "Point",
#'        "coordinates": [19.074497, 47.509548]
#'      }
#'    }
#'  ]
#' }'
#' x <- lawn_combine(mpt)
#' x$properties <- data.frame(color = c("red", "green"),
#'                            size = c("small", "large"),
#'                            popultion = c(5000, 10000L))
#' x
#'
#' # multilinestring
#' mlstring <- '{
#'  "type": "FeatureCollection",
#'  "features": [
#'    {
#'      "type": "Feature",
#'      "properties": {},
#'      "geometry": {
#'        "type": "LineString",
#'        "coordinates": [
#'          [-21.964416, 64.148203],
#'          [-21.956176, 64.141316],
#'          [-21.93901, 64.135924],
#'          [-21.927337, 64.136673]
#'        ]
#'      }
#'    }, {
#'      "type": "Feature",
#'      "properties": {},
#'      "geometry": {
#'        "type": "LineString",
#'        "coordinates": [
#'          [-21.929054, 64.127985],
#'          [-21.912918, 64.134726],
#'          [-21.916007, 64.141016],
#'          [-21.930084, 64.14446]
#'        ]
#'      }
#'    }
#'  ]
#' }'
#' x <- lawn_combine(mlstring)
#' x$properties <- data.frame(color = c("red", "green"),
#'                            size = c("small", "large"),
#'                            popultion = c(5000, 10000L))
#' x
NULL

# print functions -------------------------
#' @export
#' @noRd
print.point <- function(x, ...) {
  cat("<Point>", sep = "\n")
  cat(sprintf("  Bounding box: %s", cat_bbox(x)), sep = "\n")
  pt <- x$geometry$coordinates
  cat(sprintf("  Coordinates: %s", sprintf("%.1f %.1f", pt[1], pt[2])), sep = "\n")
  cat_props(x)
}

#' @export
#' @noRd
print.multipoint <- function(x, n = 10, ...) {
  cat("<MultiPoint>", sep = "\n")
  cat(sprintf("  Bounding box: %s", cat_bbox(x)), sep = "\n")
  cat(sprintf("  No. points: %s", NROW(x$geometry$coordinates)), sep = "\n")
  cat_props_df(x, n)
}

#' @export
#' @noRd
print.polygon <- function(x, ...) {
  cat("<Polygon>", sep = "\n")
  cat(sprintf("  Bounding box: %s", cat_bbox(x)), sep = "\n")
  cat(sprintf("  No. points: %s", length(x$geometry$coordinates[,,1])), sep = "\n")
  cat_props(x)
}

#' @export
#' @noRd
print.multipolygon <- function(x, n = 10, ...) {
  cat("<MultiPolygon>", sep = "\n")
  cat(sprintf("  Bounding box: %s", cat_bbox(x)), sep = "\n")
  cat(sprintf("  No. polygons: %s", length(x$coordinates)), sep = "\n")
  cat(sprintf("  No. points: %s", length(unlist(x$coordinates))), sep = "\n")
  cat_props_df(x, n)
}

#' @export
#' @noRd
print.linestring <- function(x, ...) {
  cat("<LineString>", sep = "\n")
  cat(sprintf("  Bounding box: %s", cat_bbox(x)), sep = "\n")
  cat(sprintf("  No. points: %s", length(x$geometry$coordinates)), sep = "\n")
  cat_props(x)
}

#' @export
#' @noRd
print.multilinestring <- function(x, n = 10, ...) {
  cat("<MultiLineString>", sep = "\n")
  cat(sprintf("  Bounding box: %s", cat_bbox(x)), sep = "\n")
  cat(sprintf("  No. lines: %s", NROW(x$geometry$coordinates)), sep = "\n")
  cat(sprintf("  No. points: %s", length(x$geometry$coordinates)), sep = "\n")
  cat_props_df(x, n)
}

#' @export
#' @noRd
print.featurecollection <- function(x, n = 10, ...) {
  cat("<FeatureCollection>", sep = "\n")
  cat(sprintf("  Bounding box: %s", cat_bbox(x)), sep = "\n")
  cat(sprintf("  No. features: %s", length(x$features$geometry$coordinates)), sep = "\n")
  cat(sprintf("  No. points: %s", length(unlist(x$features$geometry$coordinates, recursive = TRUE))), sep = "\n")
  cat_props_df(x, n)
}

#' @export
#' @noRd
print.feature <- function(x, n = 10, ...) {
  cat("<Feature>", sep = "\n")
  cat(sprintf("  Type: %s", x$geometry$type), sep = "\n")
  cat(sprintf("  Bounding box: %s", cat_bbox(x)), sep = "\n")
  cat(sprintf("  No. points: %s", length(unlist(x$geometry$coordinates, recursive = TRUE))), sep = "\n")
  cat_props(x)
}

# helper print functions -------------------------
cat_props <- function(x) {
  if (length(x$properties) != 0) {
    cat("  Properties: ", sep = "\n")
    for (i in seq_along(x$properties)) {
      cat(sprintf("     %s: %s", names(x$properties[i]), x$properties[[i]]), sep = "\n")
    }
  } else {
    props_null()
  }
}

cat_props_df <- function(x, n) {
  if (length(x$properties) != 0) {
    cat("  Properties: ", sep = "\n")
    if (is(x$properties, "data.frame")) {
      trunc_mat(x$properties, n = n)
    } else {
      for (i in seq_along(x$properties)) {
        cat(sprintf("     %s: %s", names(x$properties[i]), x$properties[[i]]), sep = "\n")
      }
    }
  } else {
    props_null()
  }
}

cat_bbox <- function(x) {
  b <- lawn_extent(x)
  sprintf("%.1f %.1f %.1f %.1f", b[1], b[2], b[3], b[4])
}

props_null <- function() {
  cat("  Properties: NULL", sep = "\n")
}
