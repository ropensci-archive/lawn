#' Slice a line given two points
#'
#' Takes a line, a start Point, and a stop point and returns the line in
#' between those points
#'
#' @export
#' @param point1 Starting [data-Feature]<([data-Point])>
#' @param point2 Stopping [data-Feature]<([data-Point])>
#' @param line Line to slice, a [data-Feature]<([data-LineString])>
#' @template lint
#' @return A [data-Feature]<([data-LineString])>
#' @examples
#' start <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [-77.029609, 38.881946]
#'   }
#' }'
#' stop <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [-77.021884, 38.889563]
#'   }
#' }'
#' line <- '{
#'  "type": "Feature",
#'  "properties": {},
#'  "geometry": {
#'    "type": "LineString",
#'    "coordinates": [
#'      [-77.031669, 38.878605],
#'      [-77.029609, 38.881946],
#'      [-77.020339, 38.884084],
#'      [-77.025661, 38.885821],
#'      [-77.021884, 38.889563],
#'      [-77.019824, 38.892368]
#'     ]
#'   }
#' }'
#' lawn_line_slice(start, stop, line)
#'
#' # lint input objects
#' lawn_line_slice(start, stop, line, TRUE)
#' @examples \dontrun{
#' line %>% view
#' lawn_line_slice(point1 = start, point2 = stop, line) %>% view
#' }
lawn_line_slice <- function(point1, point2, line, lint = FALSE) {
  lawnlint(list(point1, point2, line), lint)
  point1 <- convert(point1)
  point2 <- convert(point2)
  line <- convert(line)
  if (lint) {
    is_type(point1, type_top = "Feature", type_lower = "Point")
    is_type(point2, type_top = "Feature", type_lower = "Point")
    is_type(line, type_top = "Feature", type_lower = "LineString")
  }
  ct$eval(sprintf("var exp = turf.lineSlice(%s, %s, %s);", point1,
                  point2, line))
  structure(ct$get("exp"), class = "linestring")
}
