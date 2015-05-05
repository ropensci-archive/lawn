#' Square
#'
#' @export
#' @param bbox A bounding box
#' @template lint
#' @return A square surrounding bbox
#' @details Takes a bounding box and calculates the minimum square bounding
#' box that would contain the input.
#' @examples
#' bbox <- c(-20, -20, -15, 0)
#' lawn_square(bbox)
#' lawn_square(bbox, TRUE)
#' sq <- lawn_square(bbox)
#' @examples \dontrun{
#' lawn_featurecollection(list(lawn_bbox_polygon(bbox), lawn_bbox_polygon(sq))) %>% view
#' }
lawn_square <- function(bbox, lint = FALSE) {
  ct$eval(sprintf("var sq = turf.square(%s);", convert(bbox)))
  ct$get("sq")
}
