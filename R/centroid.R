#' Centroid
#'
#' Takes one or more features and calculates the centroid using the arithmetic
#' mean of all vertices. This lessens the effect of small islands and artifacts
#' when calculating the centroid of a set of polygons.
#'
#' @export
#'
#' @param features Input features
#' @template lint
#' @family measurements
#' @return Feature - centroid of the input features
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
lawn_centroid <- function(features, lint = FALSE) {
  fts <- convert(features)
  lawnlint(fts, lint)
  ct$eval(sprintf("var ctr = turf.centroid(%s);", fts))
  structure(ct$get("ctr"), class = "point")
}
