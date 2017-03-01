#' Unwrap a coordinate from a Feature with a Point geometry,
#' or a single coordinate.
#'
#' @export
#' @param x any [data-GeoJSON] object
#' @template lint
#' @return matrix of coordinates, where each row in the matrix is a
#' coordinate pair
#' @examples
#' x <- "{ type: 'Point', coordinates: [10, 50] }"
#' lawn_getcoord(x)
#'
#' library(jsonlite)
#' x <- fromJSON(lawn_data$points_count, FALSE)$features
#' lawn_getcoord(x[[1]])
#' lawn_getcoord(x[[2]])
#' lawn_getcoord(x[[1]]$geometry)
#' lawn_getcoord(x[[1]]$geometry$coordinates)
#'
#' # fails
#' # lawn_getcoord(x[[1]]$geometry$coordinates[[1]])

lawn_getcoord <- function(x, lint = FALSE) {
  lawnlint(x, lint)
  ct$eval(sprintf("var coord = turfinvariant.getCoord(%s);", convert(x)))
  ct$get("coord")
}
