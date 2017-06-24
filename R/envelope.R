#' Calculate envelope around features
#'
#' Takes any number of features and returns a rectangular
#' [data-Polygon] that encompasses all vertices.
#'
#' @export
#' @param fc A [data-Feature] or [data-FeatureCollection]
#' @template lint
#' @family measurements
#' @return a rectangular [data-Feature]<([data-Polygon])> that
#' encompasses all vertices
#' @examples
#' fc <- '{
#'   "type": "FeatureCollection",
#'   "features": [
#'     {
#'       "type": "Feature",
#'       "properties": {
#'         "name": "Location A"
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-75.343, 39.984]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {
#'         "name": "Location B"
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-75.833, 39.284]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {
#'         "name": "Location C"
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-75.534, 39.123]
#'       }
#'     }
#'   ]
#' }'
#' lawn_envelope(fc)
#' @examples \dontrun{
#' fc %>% view
#' lawn_envelope(fc) %>% view
#' }
lawn_envelope <- function(fc, lint = FALSE) {
  fc <- convert(fc)
  lawnlint(fc, lint)
  is_type(fc, c("Feature", "FeatureCollection"))
  ct$eval(sprintf("var env = turf.envelope(%s);", fc))
  structure(ct$get("env"), class = "polygon")
}
