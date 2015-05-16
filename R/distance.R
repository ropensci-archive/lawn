#' Distance between two points
#'
#' Calculates the distance between two \code{\link{data-Point}}'s in degress,
#' radians, miles, or kilometers. Uses the
#' \href{http://en.wikipedia.org/wiki/Haversine_formula}{Haversine formula}
#' to account for global curvature.
#'
#' @export
#'
#' @param from Origin point
#' @param to Destination point
#' @param units (character) Can be degrees, radians, miles, or kilometers
#' @template lint
#' @family measurements
#' @return Single numeric value
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
