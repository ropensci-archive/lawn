#' Buffer a feature
#'
#' @export
#' @param input A Feature or FeatureCollection
#' @param dist distance used to buffer the input
#' @param units (character) Can be miles, feet, kilometers, meters, or degrees
#' @details Calculates and returns a buffered feature.
#' @author Jeff Hollister \email{hollister.jeff@@epa.gov}
#' @examples
#' # From a FeatureCollection
#' dat <- random(100)
#' buffer(dat, 100)
#'
#' # From a Feature
#' dat <- '{
#'  "type": "Feature",
#'  "properties": {},
#'  "geometry": {
#'      "type": "Polygon",
#'      "coordinates": [[
#'        [-112.072391,46.586591],
#'        [-112.072391,46.61761],
#'        [-112.028102,46.61761],
#'        [-112.028102,46.586591],
#'        [-112.072391,46.586591]
#'      ]]
#'    }
#' }'
#' buffer(dat, 1, "miles")
#'
#' # buffer a point
#' buffer(point(c(-74.50,40)), 100, "meters")
#'

buffer <- function(input, dist, units = c("meters", "feet", "kilometers", "miles", "degrees")) {
  input <- convert(input)
  units <- match.arg(units)
  ct$eval(sprintf("var units = '%s';", units))
  ct$eval(sprintf('var dist = %s;', dist))
  ct$eval(sprintf("var buff = turf.buffer(%s, dist, units);", input))
  ct$get("buff")
}
