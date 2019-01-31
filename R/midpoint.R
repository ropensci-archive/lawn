#' Get a point midway between two points
#'
#' Takes two [data-Point]'s and returns a point midway
#' between them
#'
#' @export
#' @param pt1 First [data-Feature]<([data-Point])>
#' @param pt2 Second [data-Feature]<([data-Point])>
#' @template lint
#' @family measurements
#' @return A [data-Feature]<([data-Point])> midway between pt1 and pt2
#' @examples
#' pt1 <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [144.834823, -37.771257]
#'   }
#' }'
#' pt2 <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [145.14244, -37.830937]
#'   }
#' }'
#' lawn_midpoint(pt1, pt2)
#' @examples \dontrun{
#' lawn_midpoint(pt1, pt2) %>% view
#' lawn_featurecollection(list(
#'   lawn_point(jsonlite::fromJSON(pt1)$geometry$coordinates),
#'   lawn_point(jsonlite::fromJSON(pt2)$geometry$coordinates),
#'   structure(lawn_midpoint(pt1, pt2), class = "point")
#' )) %>% view
#' }
lawn_midpoint <- function(pt1, pt2, lint = FALSE) {
  pt1 <- convert(pt1)
  pt2 <- convert(pt2)
  lawnlint(list(pt1, pt2), lint)
  if (lint) {
    is_type(pt1, type_top = "Feature", type_lower = "Point")
    is_type(pt2, type_top = "Feature", type_lower = "Point")
  }
  ct$eval(sprintf("var md = turf.midpoint(%s, %s);", pt1, pt2))
  structure(ct$get("md"), class = "point")
}
