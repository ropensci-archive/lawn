#' Buffer a feature
#'
#' Calculates a buffer for input features for a given radius.
#'
#' @export
#' @param input A [data-Feature] or [data-FeatureCollection]
#' @param dist (integer/numeric) Distance used to buffer the input.
#' @param units (character) Units of the `dist` argument.  Can be miles, feet,
#' kilometers (default), meters, or degrees.
#' @template lint
#' @family transformations
#' @author Jeff Hollister \email{hollister.jeff@@epa.gov}
#' @examples
#' # From a Point
#' pt <- '{
#'  "type": "Feature",
#'  "properties": {},
#'  "geometry": {
#'     "type": "Point",
#'     "coordinates": [-90.548630, 14.616599]
#'   }
#' }'
#' lawn_buffer(pt, 5)
#'
#' # From a FeatureCollection
#' dat <- lawn_random(n = 100)
#' lawn_buffer(dat, 100)
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
#' lawn_buffer(dat, 1, "miles")
#'
#' # buffer a point
#' lawn_buffer(lawn_point(c(-74.50,40)), 100, "meters")
#'
lawn_buffer <- function(input, dist, units = "kilometers", lint = FALSE) {
  # This code has been contributed by Jeff Hollister, US EPA
  # Please read the following disclaimer:
  # \url{https://www.epa.gov/home/github-contribution-disclaimer}

  input <- convert(input)
  lawnlint(input, lint)
  is_type(input, type_top = c("Feature", "FeatureCollection"))
  units <- match.arg(units, c("meters", "feet", "kilometers",
                              "miles", "degrees"))
  ct$eval(sprintf("var units = '%s';", units))
  ct$eval(sprintf('var dist = %s;', dist))
  ct$eval(sprintf("var buff = turf.buffer(%s, dist, units);", input))
  output <- ct$get("buff")
  if (output$type == "Feature") {
    return(as.f(output))
  } else if (output$type == "FeatureCollection") {
    return(as.fc(output))
  }
}
