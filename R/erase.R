#' Erase one polygon from another
#'
#' Finds the difference between two \code{\link{data-Polygon}}'s by clipping
#' the second polygon from the first.
#'
#' @export
#' @param poly1 input Polygon feaure
#' @param poly2 Polygon feature to erase from poly1
#' @template lint
#' @family transformations
#' @return a \code{\link{data-Polygon}} feature showing the area of poly1 excluding
#' the area of poly2
#' @examples
#' poly1 <- '{
#'  "type": "Feature",
#'   "properties": {
#'     "fill": "#0f0"
#'   },
#'   "geometry": {
#'     "type": "Polygon",
#'     "coordinates": [[
#'       [-46.738586, -23.596711],
#'       [-46.738586, -23.458207],
#'       [-46.560058, -23.458207],
#'       [-46.560058, -23.596711],
#'       [-46.738586, -23.596711]
#'     ]]
#'   }
#' }'
#'
#' poly2 <- '{
#'   "type": "Feature",
#'   "properties": {
#'     "fill": "#00f"
#'   },
#'   "geometry": {
#'     "type": "Polygon",
#'     "coordinates": [[
#'       [-46.650009, -23.631314],
#'       [-46.650009, -23.5237],
#'       [-46.509246, -23.5237],
#'       [-46.509246, -23.631314],
#'       [-46.650009, -23.631314]
#'     ]]
#'   }
#' }'
#' lawn_erase(poly1, poly2)
#' @examples \dontrun{
#' lawn_featurecollection(list(poly1, poly2)) %>% view
#' lawn_erase(poly1, poly2) %>% view
#' fc <- lawn_featurecollection(list(
#'    lawn_polygon(fromJSON(poly1)$geometry$coordinates),
#'    lawn_polygon(fromJSON(poly2)$geometry$coordinates)
#' ))
#' view(fc)
#' }
lawn_erase <- function(poly1, poly2, lint = FALSE) {
  poly1 <- convert(poly1)
  poly2 <- convert(poly2)
  lawnlint(list(poly1, poly2), lint)
  ct$eval(sprintf("var er = turf.erase(%s, %s);", poly1, poly2))
  structure(ct$get("er"), class = "polygon")
}
