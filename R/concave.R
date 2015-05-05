#' Concave
#'
#' @export
#' @param points input points in a \code{\link{data-FeatureCollection}}
#' @param maxEdge the size of an edge necessary for part of the hull to
#' become concave (in miles)
#' @param units	used for maxEdge distance (miles [default] or kilometers)
#' @template lint
#' @return \code{\link{data-Polygon}} a concave hull
#' @details Takes a set of \code{\link{data-Point}} and returns a concave
#' hull polygon. Internally, this implements a
#' \href{http://en.wikibooks.org/wiki/Algorithm_Implementation/Geometry/Convex_hull/Monotone_chain#JavaScript}{Monotone chain algorithm}
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
#' concave(points, 1)
#' @examples \dontrun{
#' concave(points) %>% view
#' }
concave <- function(points, maxEdge = 1, units = "miles", lint = FALSE) {
  points <- convert(points)
  lawnlint(points, lint)
  ct$eval(sprintf("var cv = turf.concave(%s, %s, '%s');", points, maxEdge, units))
  structure(ct$get("cv"), class = "linestring")
}
