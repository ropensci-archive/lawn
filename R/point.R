#' Create a point
#'
#' @export
#' @param x A pair of points, of the form \code{c(longitude,latitude)}
#' @param properties A list of properties
#' @examples
#' point(c(40, -74.50))
#' point(c(40, -74.50), properties = list(name = 'poly1', population = 400))

point <- function(x, properties = NULL) {
  ct$eval(sprintf("var pt = turf.point(%s, %s);", toj(x), toj(properties)))
  ct$get("pt")
}
