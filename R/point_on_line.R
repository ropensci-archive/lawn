#' Line slice
#'
#' Takes a line, a start Point, and a stop point and returns the line in
#' between those points
#'
#' @export
#' @param line line to snap to
#' @param point point to snap from
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
#' pt <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [-77.037076, 38.884017]
#'   }
#' }'
#' point_on_line(line, pt)
#' @examples \dontrun{
#' line %>% view
#' pt %>% view
#' point_on_line(line, pt) %>% view
#' }

point_on_line <- function(line, point) {
  line <- convert(line)
  point <- convert(point)
  ct$eval(sprintf("var exp = turf.pointOnLine(%s, %s);", line, point))
  ct$get("exp")
}