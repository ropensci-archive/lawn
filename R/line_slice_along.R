#' Slice a line given two points
#'
#' Takes a line, a specified distance along the line to a start Point, and
#' a specified distance along the line to a stop point and returns a
#' subsection of the line in-between those points. This can be useful for
#' extracting only the part of a route between two distances.
#'
#' @export
#' @param startDist (numeric/integer) distance along the line to starting point
#' @param stopDist (numeric/integer) distance along the line to ending point
#' @param line Line to slice, a [data-Feature]<([data-LineString])>
#' @param units can be degrees, radians, miles, or kilometers (default)
#' @template lint
#' @return A [data-LineString], the sliced line
#' @examples
#' line <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "LineString",
#'     "coordinates": [
#'       [ 7.66845703125, 45.058001435398296 ],
#'       [ 9.20654296875, 45.460130637921004 ],
#'       [ 11.348876953125, 44.48866833139467 ],
#'       [ 12.1728515625, 45.43700828867389 ],
#'       [ 12.535400390625, 43.98491011404692 ],
#'       [ 12.425537109375, 41.86956082699455 ],
#'       [ 14.2437744140625, 40.83874913796459 ],
#'       [ 14.765625, 40.681679458715635 ]
#'     ]
#'   }
#' }'
#' lawn_line_slice_along(12.5, 25, line)
#' @examples \dontrun{
#' line %>% view
#' lawn_line_slice_along(12.5, 25, line) %>% view
#' }
lawn_line_slice_along <- function(startDist, stopDist, line,
                                  units = "kilometers", lint = FALSE) {

  assert(startDist, c('numeric', 'integer'))
  assert(stopDist, c('numeric', 'integer'))
  assert(units, 'character')
  lawnlint(line, lint)
  if (lint) is_type(line, type_top = "Feature", type_lower = "LineString")
  ct$eval(sprintf("var exp = turf.lineSliceAlong(%s, %s, %s, '%s');",
                  convert(line), startDist, stopDist, units))
  structure(ct$get("exp"), class = "linestring")
}
