#' Line slice
#'
#' Takes a line, a start Point, and a stop point and returns the line in
#' between those points
#'
#' @export
#' @param point1 Starting point
#' @param point2 Stopping point
#' @param line Line to slice
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
#' line_slice(point1 = start, point2 = stop, line)
#' @examples \dontrun{
#' line %>% view
#' line_slice(point1 = start, point2 = stop, line) %>% view
#' }

line_slice <- function(point1, point2, line) {
  point1 <- convert(point1)
  point2 <- convert(point2)
  line <- convert(line)
  ct$eval(sprintf("var exp = turf.lineSlice(%s, %s, %s);", point1, point2, line))
  ct$get("exp")
}