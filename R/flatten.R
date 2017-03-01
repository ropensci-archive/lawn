#' Flatten
#'
#' Flattens any GeoJSON to a FeatureCollection
#'
#' @export
#' @param x any valid GeoJSON with multi-geometry Feature's
#' @template lint
#' @family misc
#' @return a [data-FeatureCollection]
#' @examples
#' x <- '{
#' "type": "MultiPolygon",
#' "coordinates": [
#'     [[[102.0, 2.0], [103.0, 2.0], [103.0, 3.0], [102.0, 3.0], [102.0, 2.0]]],
#'     [[[100.0, 0.0], [101.0, 0.0], [101.0, 1.0], [100.0, 1.0], [100.0, 0.0]],
#'     [[100.2, 0.2], [100.8, 0.2], [100.8, 0.8], [100.2, 0.8], [100.2, 0.2]]]
#'   ]
#' }'
#' lawn_flatten(x)
lawn_flatten <- function(x, lint = FALSE) {
  lawnlint(x, lint)
  ct$eval(sprintf('var out = turf.flatten(%s);', convert(x)))
  ct$get("out")
}
