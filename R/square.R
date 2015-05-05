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
#' square(bbox)
#' square(bbox, TRUE)
#' sq <- square(bbox)
#' @examples \dontrun{
#' featurecollection(list(bbox_polygon(bbox), bbox_polygon(sq))) %>% view
#' }
square <- function(bbox, lint = FALSE) {
  ct$eval(sprintf("var sq = turf.square(%s);", convert(bbox)))
  ct$get("sq")
}
