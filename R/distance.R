#' Calculate the distance between two points
#'
#' @export
#'
#' @param from Origin point
#' @param to Destination point
#' @param units (character) Can be degrees, radians, miles, or kilometers
#' @template lint
#' @details Calculates the distance between two points in degress, radians, miles, or kilometers.
#' Uses the Haversine formula to account for global curvature.
#' @examples
#' from <- '{
#'  "type": "Feature",
#'  "properties": {},
#'  "geometry": {
#'    "type": "Point",
#'    "coordinates": [-75.343, 39.984]
#'  }
#' }'
#' to <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [-75.534, 39.123]
#'   }
#' }'
#' lawn_distance(from, to)
lawn_distance <- function(from, to, units = 'kilometers', lint = FALSE) {
  from <- convert(from)
  to <- convert(to)
  lawnlint(list(from, to), lint)
  ct$eval(sprintf('var point1 = %s;', from))
  ct$eval(sprintf('var point2 = %s;', to))
  ct$eval(sprintf("var avg = turf.distance(point1, point2, '%s');", units))
  ct$get("avg")
}
