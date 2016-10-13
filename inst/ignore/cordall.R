#' Get all coordinates from any GeoJSON object, returning an array
#' of coordinate arrays.
#'
#' Takes any \code{\link{data-GeoJSON}} and returns an array of
#' coordinate arrays
#'
#' @export
#' @param x any \code{\link{data-GeoJSON}} object
#' @template lint
#' @return vector of coordinates
#' @examples
#' lawn_point(x=c(-74.5, 40)) %>% lawn_coordall()
lawn_coordall <- function(x, lint = FALSE) {
  lawnlint(x, lint)
  ct$eval(sprintf("var cdall = turf.coordAll(%s);", convert(x)))
  ct$get("cdall")
}
