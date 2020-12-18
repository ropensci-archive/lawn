#' Rotate a GeoJSON feature
#'
#' Rotates any geojson Feature or Geometry of a specified angle, around its
#' centroid or a given pivot point
#'
#' @export
#' @param x a feature
#' @param angle (integer/numeric) number of rotation (along the vertical axis),
#' from North in decimal degrees, negative clockwise
#' @param pivot (integer/numeric) point around which the rotation will be
#' performed (optional, default `centroid`)
#' @param mutate (logical) allows GeoJSON input to be mutated (significant
#' performance increase if true) (optional). Default: `FALSE`
#' @template lint
#' @return a rotated [data-Feature]
#' @note all rotations follow the right-hand rule
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
#' lawn_transform_rotate(x, angle = 100, pivot = c(15, 15))
#'
#' lawn_transform_rotate(x, angle = 100)
#' lawn_transform_rotate(x, angle = 100, mutate = TRUE)
#'
#' \dontrun{
#' view(lawn_featurecollection(x))
#' view(lawn_featurecollection(lawn_transform_rotate(x, angle = 100)))
#' view(lawn_featurecollection(
#'   lawn_transform_rotate(x, angle = 100, pivot = c(15, 15))
#' ))
#' view(lawn_featurecollection(
#'   lawn_transform_rotate(x, angle = 150, pivot = c(15, 15))
#' ))
#' view(lawn_featurecollection(
#'   lawn_transform_rotate(x, angle = 300, pivot = c(0, 4))
#' ))
#' }
lawn_transform_rotate <- function(x, angle, pivot = c(0, 0),
                                  mutate = FALSE, lint = FALSE) {
  x <- convert(x)
  lawnlint(x, lint)
  assert(angle, c('numeric', 'integer'))
  assert(pivot, c('numeric', 'integer'))
  assert(mutate, 'logical')
  ct$eval(sprintf("var rot = turf.transformRotate(%s, %s, {pivot:%s, mutate:%s});",
    x, angle, toj(pivot), toj(mutate)))
  as.f(ct$get("rot"))
}
