#' Get a point on the surface of a feature
#'
#' Finds a [data-Point] guaranteed to be on the surface of
#' [data-GeoJSON] object.
#'
#' @export
#' @param x Any [data-GeoJSON] object
#' @return A [data-Feature]<([data-Point])> on the surface of `x`
#' @template lint
#' @family measurements
#' @details What will be returned?
#' \itemize{
#'  \item Given a [data-Polygon], the point will be in the area
#'  of the polygon
#'  \item Given a [data-LineString], the point will be along
#'  the string
#'  \item Given a [data-Point], the point will be the same as
#'  the input
#' }
#'
#' @examples
#' # polygon
#' x <- lawn_random("polygon")
#' lawn_point_on_feature(x)
#' # point
#' x <- lawn_random("point")
#' lawn_point_on_feature(x)
#' # linestring
#' linestring <- '[
#'    [-21.929054, 64.127985],
#'    [-21.912918, 64.134726],
#'    [-21.916007, 64.141016],
#'    [-21.930084, 64.14446]
#' ]'
#' lawn_point_on_feature(lawn_linestring(linestring))
lawn_point_on_feature <- function(x, lint = FALSE) {
  x <- convert(x)
  lawnlint(x, lint)
  is_type(x, type_top = c("Feature", "FeatureCollection"))
  ct$eval(sprintf("var psf = turf.pointOnFeature(%s);", x))
  structure(ct$get("psf"), class = "point")
}
lawn_point_on_surface <- lawn_point_on_feature
