#' Merge
#'
#' @export
#' @param fc input polygons, as \code{\link{data-FeatureCollection}}
#' @template lint
#' @return merged \code{\link{data-Polygon}} or multipolygon
#' \code{\link{data-MultiPolygon}}
#' @details Takes a set of \code{\link{data-Polygon}} and returns a single
#' merged polygon feature. If the input polygon features are not contiguous,
#' this function returns a \code{\link{data-MultiPolygon}} feature.
#' @examples
#' polygons <- '{
#'   "type": "FeatureCollection",
#'   "features": [
#'     {
#'       "type": "Feature",
#'       "properties": {
#'         "fill": "#0f0"
#'       },
#'       "geometry": {
#'         "type": "Polygon",
#'         "coordinates": [[
#'           [9.994812, 53.549487],
#'           [10.046997, 53.598209],
#'           [10.117721, 53.531737],
#'           [9.994812, 53.549487]
#'         ]]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {
#'         "fill": "#00f"
#'       },
#'       "geometry": {
#'         "type": "Polygon",
#'         "coordinates": [[
#'           [10.000991, 53.50418],
#'           [10.03807, 53.562539],
#'           [9.926834, 53.551731],
#'           [10.000991, 53.50418]
#'         ]]
#'       }
#'     }
#'   ]
#' }'
#' merge(polygons)
#' @examples \dontrun{
#' featurecollection(polygons) %>% view
#' merge(polygons) %>% view
#' }
merge <- function(fc, lint = FALSE) {
  fc <- convert(fc)
  lawnlint(fc, lint)
  ct$eval(sprintf("var mrg = turf.merge(%s);", fc))
  structure(ct$get("mrg"), class = "polygon")
}
