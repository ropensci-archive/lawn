#' Centroid
#'
#' Takes one or more features and calculates the centroid using the arithmetic
#' mean of all vertices. This lessens the effect of small islands and artifacts
#' when calculating the centroid of a set of polygons.
#'
#' @export
#'
#' @param features Input features, as a [data-Feature] or
#' [data-FeatureCollection]
#' @param properties A list of properties. Default: `NULL`
#' @template lint
#' @family measurements
#' @return a [data-Feature]<([data-Point])> - centroid of the input features
#' @examples
#' poly <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Polygon",
#'     "coordinates": [[
#'       [105.818939,21.004714],
#'       [105.818939,21.061754],
#'       [105.890007,21.061754],
#'       [105.890007,21.004714],
#'       [105.818939,21.004714]
#'      ]]
#'   }
#' }'
#' lawn_centroid(features = poly)
#' lawn_centroid(features = poly, properties = list(foo = "bar"))
lawn_centroid <- function(features, properties = NULL, lint = FALSE) {
  fts <- convert(features)
  lawnlint(fts, lint)
  is_type(features, type_top = c("Feature", "FeatureCollection"))
  ct$eval(sprintf("var ctr = turf.centroid(%s, %s);", fts, toj(properties)))
  structure(ct$get("ctr"), class = "point")
}
