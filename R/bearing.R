#' Bearing
#'
#' @export
#' @param start starting \code{\link{data-Point}}
#' @param end ending \code{\link{data-Point}}
#' @template lint
#' @return bearing (numeric) in decimal degrees
#' @details Takes two points and finds the geographic bearing between them
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
#' bearing(start, end)
bearing <- function(start, end, lint = FALSE) {
  start <- convert(start)
  end <- convert(end)
  lawnlint(list(start, end), lint)
  ct$eval(sprintf("var bear = turf.bearing(%s, %s);", start, end))
  ct$get("bear")
}
