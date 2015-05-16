#' Get a point midway between two points
#'
#' Takes two \code{\link{data-Point}}'s and returns a point midway
#' between them
#'
#' @export
#' @param pt1 First point
#' @param pt2 Second point
#' @template lint
#' @family measurements
#' @return A \code{\link{data-Point}} midway between pt1 and pt2
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
#'   lawn_point(fromJSON(pt1)$geometry$coordinates),
#'   lawn_point(fromJSON(pt2)$geometry$coordinates),
#'   structure(lawn_midpoint(pt1, pt2), class = "point")
#' )) %>% view
#' }
lawn_midpoint <- function(pt1, pt2, lint = FALSE) {
  pt1 <- convert(pt1)
  pt2 <- convert(pt2)
  lawnlint(list(pt1, pt2), lint)
  ct$eval(sprintf("var md = turf.midpoint(%s, %s);", pt1, pt2))
  structure(ct$get("md"), class = "point")
}
