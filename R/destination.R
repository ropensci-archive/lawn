#' Destination
#'
#' @export
#' @param start	starting point \code{\link{data-Point}}
#' @param distance distance from the starting point
#' @param bearing	ranging from -180 to 180
#' @param units	miles, kilometers, degrees, or radians
#' @template lint
#' @return destination \code{\link{data-Point}}
#' @details Takes a \code{\link{data-Point}} and calculates the location of a
#' destination point given a distance in degrees, radians, miles, or kilometers; and
#' bearing in degrees. This uses the
#' \href{http://en.wikipedia.org/wiki/Haversine_formula}{Haversine} formula to account
#' for global curvature.
#' @examples
#' pt <- '{
#'   "type": "Feature",
#'   "properties": {
#'     "marker-color": "#0f0"
#'   },
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [-75.343, 39.984]
#'   }
#' }'
#' lawn_destination(pt, 50, 90, "miles")
#' lawn_destination(pt, 100, 90, "miles")
#' lawn_destination(pt, 2, 45, "kilometers")
#' lawn_destination(pt, 2, 30, "degrees")
#' @examples \dontrun{
#' pt %>% view
#' lawn_destination(pt, 200, 90, "miles") %>% view
#' }
lawn_destination <- function(start, distance, bearing, units, lint = FALSE) {
  start <- convert(start)
  lawnlint(start, lint)
  ct$eval(sprintf("var dest = turf.destination(%s, %s, %s, '%s');", start, distance, bearing, units))
  ct$get("dest")
}
