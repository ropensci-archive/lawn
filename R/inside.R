#' Does a point reside inside a polygon
#'
#' Takes a \code{\link{data-Point}} and a \code{\link{data-Polygon}} or
#' \code{\link{data-MultiPolygon}} and determines if the point
#' resides inside the polygon
#'
#' @export
#'
#' @param point Input point
#' @param polygon Input polygon or multipolygon
#' @template lint
#' @family joins
#' @return \code{TRUE} if the Point IS inside the Polygon, \code{FALSE} if
#' the Point IS NOT inside the Polygon
#' @details The polygon can be convex or concave. The function accounts for holes
#' @examples
#' point1 <- '{
#'   "type": "Feature",
#'   "properties": {
#'     "marker-color": "#f00"
#'   },
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [-111.467285, 40.75766]
#'   }
#' }'
#' point2 <- '{
#'   "type": "Feature",
#'   "properties": {
#'     "marker-color": "#0f0"
#'   },
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [-111.873779, 40.647303]
#'   }
#' }'
#' poly <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Polygon",
#'     "coordinates": [[
#'       [-112.074279, 40.52215],
#'       [-112.074279, 40.853293],
#'       [-111.610107, 40.853293],
#'       [-111.610107, 40.52215],
#'       [-112.074279, 40.52215]
#'       ]]
#'   }
#' }'
#' lawn_inside(point1, poly)
#' lawn_inside(point2, poly)
lawn_inside <- function(point, polygon, lint = FALSE) {
  point <- convert(point)
  polygon <- convert(polygon)
  lawnlint(list(point, polygon), lint)
  ct$eval(sprintf("var ins = turf.inside(%s, %s);", point, polygon))
  ct$get("ins")
}
