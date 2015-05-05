#' Bbox polygon
#'
#' @export
#' @param bbox an Array of bounding box coordinates in the form:
#' [xLow, yLow, xHigh, yHigh]
#' @return a \code{\link{data-Polygon}} representation of the bounding box
#' @details Takes a bbox and returns an equivalent polygon \code{\link{data-Polygon}}
#' @examples
#' bbox <- c(0, 0, 10, 10)
#' bbox_polygon(bbox)
#' @examples \dontrun{
#' bbox_polygon(bbox) %>% view
#' bbox_polygon(c(1, 3, 5, 50)) %>% view
#' }
bbox_polygon <- function(bbox) {
  ct$eval(sprintf("var bbp = turf.bboxPolygon(%s);", convert(bbox)))
  structure(ct$get("bbp"), class = "polygon")
}
