#' Inside
#'
#' Takes a Point and a Polygon or MultiPolygon and determines if the point
#' resides inside the polygon. The polygon can be convex or concave. The
#' function accounts for holes
#'
#' @export
#'
#' @param point Input point
#' @param polygon Input polygon or multipolygon
#' @return \code{TRUE} if the Point IS inside the Polygon, \code{FALSE} if
#' the Point IS NOT inside the Polygon
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
lawn_inside <- function(point, polygon) {
  point <- convert(point)
  polygon <- convert(polygon)
  ct$eval(sprintf("var ins = turf.inside(%s, %s);", point, polygon))
  ct$get("ins")
}
