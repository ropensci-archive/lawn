#' Create a point
#'
#' @export
#' @param x A pair of points, of the form \code{c(longitude,latitude)}
#' @param properties A list of properties
#' @examples
#' point(c(-74.5, 40))
#' point(c(-74.5, 40), properties = list(name = 'poly1', population = 400))
#'
#' # Make a FeatureCollection
#' featurecollection(point(c(-74.5, 40)))

point <- function(x, properties = NULL) {
  ct$eval(sprintf("var pt = turf.point(%s, %s);", toj(x), toj(properties)))
  structure(ct$get("pt"), class = "point")
}
