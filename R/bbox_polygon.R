#' Make a polygon from a bounding box
#'
#' Takes a bbox and returns an equivalent polygon \code{\link{data-Polygon}}
#'
#' @export
#' @param bbox an Array of bounding box coordinates in the form:
#' [xLow, yLow, xHigh, yHigh]
#' @family measurements
#' @return a \code{\link{data-Polygon}} representation of the bounding box
#' @examples
#' bbox <- c(0, 0, 10, 10)
#' lawn_bbox_polygon(bbox)
#' @examples \dontrun{
#' lawn_bbox_polygon(bbox) %>% view
#' lawn_bbox_polygon(c(1, 3, 5, 50)) %>% view
#' }
lawn_bbox_polygon <- function(bbox) {
  all_numeric(bbox)
  ct$eval(sprintf("var bbp = turf.bboxPolygon(%s);", convert(bbox)))
  structure(ct$get("bbp"), class = "polygon")
}

all_numeric <- function(x) {
  if (!all(vapply(x, is.numeric, logical(1)))) {
    stop("All values must be numeric", call. = FALSE)
  }
}
