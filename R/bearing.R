#' Get geographic bearing between two points
#'
#' Takes two \code{\link{data-Point}}'s and finds the geographic bearing
#' between them
#'
#' @export
#' @param start starting \code{\link{data-Point}}
#' @param end ending \code{\link{data-Point}}
#' @template lint
#' @family measurements
#' @return bearing (numeric) in decimal degrees
#' @examples
#' start <- '{
#'  "type": "Feature",
#'  "properties": {
#'    "marker-color": "#f00"
#'  },
#'  "geometry": {
#'    "type": "Point",
#'    "coordinates": [-75.343, 39.984]
#'  }
#' }'
#'
#' end <- '{
#'   "type": "Feature",
#'   "properties": {
#'     "marker-color": "#0f0"
#'   },
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [-75.534, 39.123]
#'   }
#' }'
#' lawn_bearing(start, end)
lawn_bearing <- function(start, end, lint = FALSE) {
  start <- convert(start)
  end <- convert(end)
  lawnlint(list(start, end), lint)
  ct$eval(sprintf("var bear = turf.bearing(%s, %s);", start, end))
  ct$get("bear")
}
