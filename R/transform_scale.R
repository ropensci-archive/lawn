#' Scale a GeoJSON feature
#'
#' Scale a GeoJSON from a given point by a factor of scaling (ex: factor=2
#' would make the GeoJSON 200% larger). If a FeatureCollection is provided,
#' the origin point will be calculated based on each individual Feature.
#'
#' @export
#' @param x a feature
#' @param factor (integer/numeric) of scaling, positive or negative values
#' greater than 0
#' @param origin (integer/numeric) Point from which the scaling will occur
#' (string options: sw/se/nw/ne/center/centroid) (optional, default "centroid")
#' @param mutate (logical) allows GeoJSON input to be mutated (significant
#' performance increase if true) (optional). Default: `FALSE`
#' @template lint
#' @return a scaled [data-Feature]
#' @examples
#' x <- '{
#'  "type": "Feature",
#'  "properties": {},
#'  "geometry": {
#'    "type": "Polygon",
#'    "coordinates": [
#'     [
#'       [ 0, 29 ], [ 3.5, 29 ], [ 2.5, 32 ], [ 0, 29 ]
#'     ]
#'   ]
#'  }
#' }'
#' lawn_transform_scale(x, factor = 3)
#'
#' lawn_transform_scale(x, factor = 100)
#' lawn_transform_scale(x, factor = 100, mutate = TRUE)
#'
#' \dontrun{
#' view(lawn_featurecollection(x))
#' view(lawn_featurecollection(
#'   lawn_transform_scale(x, factor = 2)
#' ))
#' view(lawn_featurecollection(
#'   lawn_transform_scale(x, factor = 3)
#' ))
#' view(lawn_featurecollection(
#'   lawn_transform_scale(x, factor = 2, origin = "sw")
#' ))
#' view(lawn_featurecollection(
#'   lawn_transform_scale(x, factor = 2, origin = "ne")
#' ))
#' }
lawn_transform_scale <- function(x, factor, origin = "centroid",
                                 mutate = FALSE, lint = FALSE) {
  x <- convert(x)
  lawnlint(x, lint)
  assert(origin, 'character')
  assert(mutate, 'logical')
  ct$eval(sprintf("var sc = turf.transformScale(%s, %s, '%s', %s);",
                  x, factor, origin, toj(mutate)))
  as.f(ct$get("sc"))
}
