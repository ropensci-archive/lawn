#' Merge polygons
#'
#' Takes a set of \code{\link{data-Polygon}}'s and returns a single
#' merged polygon feature. If the input polygon features are not contiguous,
#' returns a \code{\link{data-MultiPolygon}} feature.
#'
#' @export
#' @param fc input polygons, as \code{\link{data-FeatureCollection}}
#' @template lint
#' @family transformations
#' @seealso \code{\link{lawn_union}}
#' @return merged \code{\link{data-Polygon}} or multipolygon
#' \code{\link{data-MultiPolygon}}
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
#' lawn_merge(polygons)
#' @examples \dontrun{
#' lawn_featurecollection(polygons) %>% view
#' lawn_merge(polygons) %>% view
#' }
lawn_merge <- function(fc, lint = FALSE) {
  fc <- convert(fc)
  lawnlint(fc, lint)
  ct$eval(sprintf("var mrg = turf.merge(%s);", fc))
  structure(ct$get("mrg"), class = "polygon")
}
