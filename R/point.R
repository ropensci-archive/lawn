#' Create a point
#'
#' @export
#' @param x A pair of points, of the form \code{c(longitude,latitude)}
#' @examples
#' point(c(40,-74.50))

point <- function(x) {
  ct$eval(sprintf("var pt = turf.point(%s);", jsonlite::toJSON(x)))
  ct$get("pt")
}
