#' Translate a GeoJSON feature
#'
#' Moves any geojson Feature or Geometry of a specified distance along a
#' Rhumb Line on the provided direction angle.
#'
#' @export
#' @param x a feature
#' @param distance (integer/numeric) length of the motion; negative values
#' determine motion in opposite direction
#' @param direction (integer/numeric) of the motion; angle from North in
#' decimal degrees, positive clockwise
#' @param units (character) in which distance will be express; miles,
#' kilometers, degrees, or radians (optional, default kilometers)
#' @param zTranslation (integer/numeric) length of the vertical motion,
#' same unit of distance (optional, default 0)
#' @param mutate (logical) allows GeoJSON input to be mutated (significant
#' performance increase if true) (optional). Default: `FALSE`
#' @template lint
#' @return a changed [data-Feature]
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
#' lawn_transform_translate(x, distance = 100, direction = 35)
#'
#' lawn_transform_translate(x, distance = 100, direction = 24)
#' lawn_transform_translate(x, distance = 100, direction = 24, mutate = TRUE)
#'
#' \dontrun{
#' view(lawn_featurecollection(x))
#' view(lawn_featurecollection(
#'   lawn_transform_translate(x, distance = 130, direction = 35,
#'    units = "kilometers")
#' ))
#' view(lawn_featurecollection(
#'   lawn_transform_translate(x, distance = 130, direction = -35,
#'    units = "kilometers")
#' ))
#' view(lawn_featurecollection(
#'   lawn_transform_translate(x, distance = 130, direction = 35,
#'    units = "kilometers", zTranslation = 10)
#' ))
#' view(lawn_featurecollection(
#'   lawn_transform_translate(x, distance = 130, direction = 35,
#'    units = "kilometers", mutate = TRUE)
#' ))
#' }
lawn_transform_translate <- function(x, distance, direction,
  units = "kilometers", zTranslation = 0, mutate = FALSE, lint = FALSE) {

  x <- convert(x)
  lawnlint(x, lint)
  assert(distance, c('numeric', 'integer'))
  assert(direction, c('numeric', 'integer'))
  assert(units, 'character')
  assert(zTranslation, c('numeric', 'integer'))
  assert(mutate, 'logical')
  ct$eval(sprintf("var tt = turf.transformTranslate(%s, %s, %s, {units:'%s', zTranslation:%s, mutate:%s});",
    x, distance, direction, units, zTranslation, toj(mutate)))
  as.f(ct$get("tt"))
}
