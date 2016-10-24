#' Make a bounding box from a polygon
#'
#' Takes a polygon \code{\link{data-Polygon}} and returns a bbox
#'
#' @export
#' @param x a FeatureCollection of \code{\link{data-Polygon}} features
#' @template lint
#' @family measurements
#' @return a bounding box
#' @examples
#' bbox <- c(0, 0, 10, 10)
#' lawn_bbox(lawn_bbox_polygon(bbox))
lawn_bbox <- function(x, lint = FALSE) {
  lawnlint(x, lint)
  ct$eval(sprintf("var bbp = turf.bbox(%s);", convert(x)))
  ct$get("bbp")
}
