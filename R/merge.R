#' Merge polygons
#'
#' Takes a set of [data-Polygon]'s and returns a single
#' merged polygon feature. If the input polygon features are not contiguous,
#' returns a [data-MultiPolygon] feature.
#'
#' @export
#' @param fc Input polygons, as [data-FeatureCollection].
#' @template lint
#' @family transformations
#' @seealso [lawn_union]
#' @return Merged [data-Polygon] or multipolygon
#' [data-MultiPolygon].
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
  ct$eval('
    mg = function merge(polys) {
      var merged = clone(polys.features[0]), features = polys.features;
      for (var i = 0, len = features.length; i < len; i++) {
        var poly = features[i];
        if (poly.geometry) merged = turf.union(merged, poly);
      }
      return merged;
    }
  ')
  ct$eval(sprintf("var mrg = mg(%s);", fc))
  structure(ct$get("mrg"), class = "polygon")
}
