#' Get all coordinates from any GeoJSON object, returning an array
#' of coordinate arrays.
#'
#' Takes any [data-GeoJSON] and returns an array of
#' coordinate arrays
#'
#' @export
#' @param x any [data-GeoJSON] object
#' @template lint
#' @return matrix of coordinates, where each row in the matrix is a
#' coordinate pair
#' @examples
#' lawn_point(c(-74.5, 40)) %>% lawn_coordall()
#'
#' rings <- list(list(
#'    c(-2.275543, 53.464547),
#'    c(-2.275543, 53.489271),
#'    c(-2.215118, 53.489271),
#'    c(-2.215118, 53.464547),
#'    c(-2.275543, 53.464547)
#' ))
#' lawn_polygon(rings) %>% lawn_coordall()
lawn_coordall <- function(x, lint = FALSE) {
  lawnlint(x, lint)
  ct$eval(sprintf("var cdall = turfmeta.coordAll(%s);", convert(x)))
  ct$get("cdall")
}
