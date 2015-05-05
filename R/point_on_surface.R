#' Point on surface
#'
#' @export
#' @param x any \code{\link{data-GeoJSON}} object
#' @return A point on the surface of \code{x}
#' @template lint
#'
#' @details Finds a \code{\link{data-Point}} guaranteed to be on the surface of
#' \code{\link{GeoJSON}} object.
#'
#' @examples
#' # polygon
#' x <- random("polygon")
#' point_on_surface(x)
#' # point
#' x <- random("point")
#' point_on_surface(x)
#' # linestring
#' linestring <- '[
#'    [-21.929054, 64.127985],
#'    [-21.912918, 64.134726],
#'    [-21.916007, 64.141016],
#'    [-21.930084, 64.14446]
#' ]'
#' point_on_surface(linestring(linestring))

point_on_surface <- function(x, lint = FALSE) {
  x <- convert(x)
  lawnlint(x, lint)
  ct$eval(sprintf("var psf = turf.pointOnSurface(%s);", x))
  structure(ct$get("psf"), class = "point")
}
