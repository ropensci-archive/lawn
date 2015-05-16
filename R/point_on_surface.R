#' Get a point on the surface of a feature
#'
#' Finds a \code{\link{data-Point}} guaranteed to be on the surface of
#' \code{\link{data-GeoJSON}} object.
#'
#' @export
#' @param x any \code{\link{data-GeoJSON}} object
#' @return A point on the surface of \code{x}
#' @template lint
#' @family measurements
#' @details What will be returned?
#' \itemize{
#'  \item Given a \code{\link{data-Polygon}}, the point will be in the area
#'  of the polygon
#'  \item Given a \code{\link{data-LineString}}, the point will be along
#'  the string
#'  \item Given a \code{\link{data-Point}}, the point will the same as
#'  the input
#' }
#'
#' @examples
#' # polygon
#' x <- lawn_random("polygon")
#' lawn_point_on_surface(x)
#' # point
#' x <- lawn_random("point")
#' lawn_point_on_surface(x)
#' # linestring
#' linestring <- '[
#'    [-21.929054, 64.127985],
#'    [-21.912918, 64.134726],
#'    [-21.916007, 64.141016],
#'    [-21.930084, 64.14446]
#' ]'
#' lawn_point_on_surface(lawn_linestring(linestring))
lawn_point_on_surface <- function(x, lint = FALSE) {
  x <- convert(x)
  lawnlint(x, lint)
  ct$eval(sprintf("var psf = turf.pointOnSurface(%s);", x))
  structure(ct$get("psf"), class = "point")
}
