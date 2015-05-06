#' Calculate a Planepoint
#'
#' Takes a triangular plane as a \code{\link{data-Polygon}} and a
#' \code{\link{data-Point}} within that triangle and returns the
#' z-value at that point
#'
#' @export
#' @param pt the Point for which a z-value will be calculated
#' @param triangle a Polygon feature with three vertices
#' @template lint
#' @family interpolation
#' @return the z-value for pt (numeric)
#' @details The Polygon needs to have properties a, b, and c that define
#' the values at its three corners.
#' @examples
#' pt <- lawn_point(c(-75.3221, 39.529))
#' triangle <- '{
#'   "type": "Feature",
#'   "properties": {
#'     "a": 11,
#'     "b": 122,
#'     "c": 44
#'   },
#'   "geometry": {
#'     "type": "Polygon",
#'     "coordinates": [[
#'       [-75.1221, 39.57],
#'       [-75.58, 39.18],
#'       [-75.97, 39.86],
#'       [-75.1221, 39.57]
#'     ]]
#'   }
#' }'
#' lawn_planepoint(pt, triangle)
lawn_planepoint <- function(pt, triangle, lint = FALSE) {
  pt <- convert(pt)
  triangle <- convert(triangle)
  lawnlint(list(pt, triangle), lint)
  ct$eval(sprintf("var planept = turf.planepoint(%s, %s);", pt, triangle))
  ct$get("planept")
}
