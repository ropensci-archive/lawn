#' Get closest point on linestring to reference point
#'
#' Takes a line, a start [data-Point], and a stop point and returns
#' the line in between those points
#'
#' @export
#' @param line [data-Feature]<([data-LineString])> to snap to
#' @param point [data-Feature]<([data-Point])> to snap from
#' @template lint
#' @return A [data-Feature]<([data-Point])>
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
#' lawn_point_on_line(line, pt)
#'
#' # lint input objects
#' lawn_point_on_line(line, pt, TRUE)
#' @examples \dontrun{
#' line %>% view
#' pt %>% view
#' lawn_point_on_line(line, pt) %>% view
#' }
lawn_point_on_line <- function(line, point, lint = FALSE) {
  line <- convert(line)
  point <- convert(point)
  lawnlint(list(line, point), lint)
  if (lint) {
    is_type(line, type_top = "Feature", type_lower = "LineString")
    is_type(point, type_top = "Feature", type_lower = "Point")
  }
  ct$eval(sprintf("var exp = turf.pointOnLine(%s, %s);", line, point))
  structure(ct$get("exp"), class = "point")
}
