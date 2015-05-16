#' Concave hull polygon
#'
#' Takes a set of \code{\link{data-Point}}'s and returns a concave hull polygon.
#' Internally, this implements a Monotone chain algorithm
#'
#' @export
#' @param points input points in a \code{\link{data-FeatureCollection}}
#' @param maxEdge the size of an edge necessary for part of the hull to
#' become concave (in miles)
#' @param units	used for maxEdge distance (miles [default] or kilometers)
#' @template lint
#' @family transformations
#' @return \code{\link{data-Polygon}} a concave hull
#' @examples
#' points <- '{
#'   "type": "FeatureCollection",
#'   "features": [
#'     {
#'       "type": "Feature",
#'       "properties": {},
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-63.601226, 44.642643]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {},
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-63.591442, 44.651436]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {},
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-63.580799, 44.648749]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {},
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-63.573589, 44.641788]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {},
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-63.587665, 44.64533]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {},
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-63.595218, 44.64765]
#'       }
#'     }
#'     ]
#' }'
#' lawn_concave(points, 1)
#' @examples \dontrun{
#' lawn_concave(points) %>% view
#' }
lawn_concave <- function(points, maxEdge = 1, units = "miles", lint = FALSE) {
  points <- convert(points)
  lawnlint(points, lint)
  ct$eval(sprintf("var cv = turf.concave(%s, %s, '%s');", points, maxEdge, units))
  structure(ct$get("cv"), class = "linestring")
}
