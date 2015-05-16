#' Calculate envelope around features
#'
#' Takes any number of features and returns a rectangular
#' \code{\link{data-Polygon}} that encompasses all vertices.
#'
#' @export
#' @param fc \code{\link{data-FeatureCollection}}
#' @template lint
#' @family measurements
#' @return a rectangular \code{\link{data-Polygon}} feature that
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
  ct$eval(sprintf("var env = turf.envelope(%s);", fc))
  structure(ct$get("env"), class = "polygon")
}
