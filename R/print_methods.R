#' Lawn print methods to provide summary view
#'
#' @name print-methods
#' @param x input
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
NULL

# print functions -------------------------
#' @export
#' @noRd
print.point <- function(x, ...) {
  cat("<Point>", sep = "\n")
  cat(sprintf("  Bounding box: %s", cat_bbox(x)), sep = "\n")
  pt <- x$geometry$coordinates
  cat(sprintf("  Coordinates: %s", sprintf("%.1f %.1f", pt[1], pt[2])), sep = "\n")
  if (length(x$properties) != 0) {
    cat("  Properties: ", sep = "\n")
    for (i in seq_along(x$properties)) {
      cat(sprintf("     %s: %s", names(x$properties[i]), x$properties[[i]]), sep = "\n")
    }
  } else {
    props_null()
  }
}

#' @export
#' @noRd
print.polygon <- function(x, ...) {
  cat("<Polygon>", sep = "\n")
  cat(sprintf("  Bounding box: %s", cat_bbox(x)), sep = "\n")
  cat(sprintf("  No. points: %s", length(x$geometry$coordinates[,,1])), sep = "\n")
  if (length(x$properties) != 0) {
    cat("  Properties: ", sep = "\n")
    for (i in seq_along(x$properties)) {
      cat(sprintf("     %s: %s", names(x$properties[i]), x$properties[[i]]), sep = "\n")
    }
  } else {
    props_null()
  }
}

#' @export
#' @noRd
print.linestring <- function(x, ...) {
  cat("<LineString>", sep = "\n")
  cat(sprintf("  Bounding box: %s", cat_bbox(x)), sep = "\n")
  cat(sprintf("  No. points: %s", NROW(x$geometry$coordinates)), sep = "\n")
  if (length(x$properties) != 0) {
    cat("  Properties: ", sep = "\n")
    for (i in seq_along(x$properties)) {
      cat(sprintf("     %s: %s", names(x$properties[i]), x$properties[[i]]), sep = "\n")
    }
  } else {
    props_null()
  }
}

#' @export
#' @noRd
print.featurecollection <- function(x, n = 10, ...) {
  cat("<FeatureCollection>", sep = "\n")
  cat(sprintf("  Bounding box: %s", cat_bbox(x)), sep = "\n")
  cat(sprintf("  No. features: %s", length(x$features$geometry$coordinates)), sep = "\n")
  cat(sprintf("  No. points: %s", length(unlist(x$features$geometry$coordinates, recursive = TRUE))), sep = "\n")
  if (length(x$features$properties) != 0) {
    cat("  Properties: ", sep = "\n")
    if (is(x$features$properties, "data.frame")) {
      trunc_mat(x$features$properties, n = n)
    }
  } else {
    props_null()
  }
}

# helper print functions -------------------------
cat_bbox <- function(x) {
  b <- lawn_extent(x)
  sprintf("%.1f %.1f %.1f %.1f", b[1], b[2], b[3], b[4])
}

# cat_nopts <- function(x) {
#   length(x$geometry$coordinates[,,1])
# }

props_null <- function() {
  cat("  Properties: NULL", sep = "\n")
}
