#' Measure a linestring
#'
#' Takes a [data-LineString] and measures its length in
#' the specified units.
#'
#' @export
#' @param line Line to measure, a [data-Feature]<([data-LineString])>,
#' or [data-FeatureCollection]<([data-LineString])>
#' @param units Can be degrees, radians, miles, or kilometers.
#' @template lint
#' @family measurements
#' @return Length of the input line (numeric).
#' @examples
#' line <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "LineString",
#'     "coordinates": [
#'       [-77.031669, 38.878605],
#'       [-77.029609, 38.881946],
#'       [-77.020339, 38.884084],
#'       [-77.025661, 38.885821],
#'       [-77.021884, 38.889563],
#'       [-77.019824, 38.892368]
#'     ]
#'   }
#' }'
#' lawn_line_distance(line, 'kilometers')
#' lawn_line_distance(line, 'miles')
#' lawn_line_distance(line, 'radians')
#' lawn_line_distance(line, 'degrees')
lawn_line_distance <- function(line, units, lint = FALSE) {
  line <- convert(line)
  lawnlint(line, lint)
  assert(units, "character")
  if (lint) is_type(line, type_top = c("Feature", "FeatureCollection"))
  ct$eval(sprintf("var env = turf.lineDistance(%s, '%s');", line, units))
  ct$get("env")
}
