#' Flatten
#'
#' Flattens any GeoJSON to a FeatureCollection
#'
#' @export
#' @param x any valid GeoJSON with multi-geometry [data-Feature]'s
#' @template lint
#' @family misc
#' @return a [data-FeatureCollection]
#' @examples
#' x <- '{"type":"MultiPolygon","coordinates":[
#'   [[[102,2],[103,2],[103,3],[102,3],[102,2]]],
#'   [[[100,0],[101,0],[101,1],[100,1],[100,0]],
#'   [[100.2,0.2],[100.2,0.8],[100.8,0.8],[100.8,0.2],[100.2,0.2]]]
#'  ]
#' }'
#' lawn_flatten(x)
#' lawn_flatten(x, TRUE)
lawn_flatten <- function(x, lint = FALSE) {
  lawnlint(x, lint)
  ct$eval(sprintf('var out = turf.flatten(%s);', convert(x)))
  ct$get("out")
}
