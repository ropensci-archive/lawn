#' Truncate
#'
#' Takes a GeoJSON Feature or FeatureCollection and truncates the precision
#' of the geometry.
#'
#' @export
#' @param x any [data-Feature] or [data-FeatureCollection]
#' @param precision (integer) coordinate decimal precision. default: 6
#' @param coordinates (integer) maximum number of coordinates (primarily used
#' to remove z coordinates). default: 2
#' @param mutate (logical) allows GeoJSON input to be mutated (significant
#' performance increase if true) Default: `FALSE`
#' @template lint
#' @family misc
#' @return a [data-Feature] or [data-FeatureCollection] with truncated geometry
#' @examples
#' cat(lawn_data$filter_features)
#' lawn_coordall(lawn_data$filter_features)
#' lawn_truncate(lawn_data$filter_features, 4) %>% lawn_coordall
#' lawn_truncate(lawn_data$filter_features, 2) %>% lawn_coordall
#' lawn_truncate(lawn_data$filter_features, 4, 1) %>% lawn_coordall
lawn_truncate <- function(x, precision = 6, coordinates = 2, mutate = FALSE,
  lint = FALSE) {

  lawnlint(x, lint)
  assert(precision, c('numeric', 'integer'))
  assert(coordinates, c('numeric', 'integer'))
  assert(mutate, "logical")
  ct$eval(sprintf(
    'var out = turf.truncate(%s, {precision:%s, coordinates:%s, mutate:%s});',
    x, precision, coordinates, tolower(mutate)))
  as.fc(ct$get("out"))
}
