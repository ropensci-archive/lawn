#' Offset a linestring
#'
#' Takes a [data-LineString] and returns a [data-LineString] at offset by
#' the specified distance.
#'
#' @export
#' @param line Line to measure, a [data-LineString].
#' @param distance (integer/numeric) Distance along the line.
#' @param units Can be degrees, radians, miles, kilometers, inches,
#' yards, meters
#' @template lint
#' @return a [data-LineString]
#' @examples
#' line <- '{
#'   "type": "Feature",
#'   "properties": {
#'     "stroke": "#F00"
#'   },
#'   "geometry": {
#'     "type": "LineString",
#'     "coordinates": [[-83, 30], [-84, 36], [-78, 41]]
#'   }
#' }'
#' lawn_line_offset(line, 2, 'miles')
#' lawn_line_offset(line, 200, 'miles')
#' lawn_line_offset(line, 0.5, 'radians')
#' lawn_line_offset(line, 4, 'yards')
lawn_line_offset <- function(line, distance, units, lint = FALSE) {
  line <- convert(line)
  lawnlint(line, lint)
  ct$eval(sprintf("var off = turf.lineOffset(%s, %s, '%s');",
                  line, distance, units))
  as.f(ct$get("off"))
}
