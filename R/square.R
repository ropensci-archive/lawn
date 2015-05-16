#' Calculate a square bounding box
#'
#' Takes a bounding box and calculates the minimum square bounding
#' box that would contain the input.
#'
#' @export
#' @param bbox A bounding box
#' @family measurements
#' @return A square surrounding bbox, numeric vector of length four
#' @examples
#' bbox <- c(-20, -20, -15, 0)
#' lawn_square(bbox)
#' @examples \dontrun{
#' sq <- lawn_square(bbox)
#' lawn_featurecollection(list(lawn_bbox_polygon(bbox), lawn_bbox_polygon(sq))) %>% view
#' }
lawn_square <- function(bbox) {
  ct$eval(sprintf("var sq = turf.square(%s);", convert(bbox)))
  ct$get("sq")
}
