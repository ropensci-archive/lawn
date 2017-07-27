#' Average of a field among points within polygons
#'
#' Calculate the average value of a field for a set of [data-Point]s
#' within a set of [data-Polygon]s
#'
#' @export
#'
#' @param polygons A [data-FeatureCollection] of [data-Polygon]'s
#' @param points A [data-FeatureCollection] of [data-Point]'s
#' @param in_field (character) The field in the points feature from which to
#' pull values to average.
#' @param out_field (character) The field in polygons to put results of the
#' averages.
#' @template lint
#' @family aggregations
#' @return Polygons with the value of out_field set to the calculated averages
#' @examples \dontrun{
#' # using data in the package
#' cat(lawn_data$points_average)
#' cat(lawn_data$polygons_average)
#' lawn_average(polygons = lawn_data$polygons_average,
#'              points = lawn_data$points_average, 'population')
#' }
lawn_average <- function(polygons, points, in_field, out_field = 'average',
                         lint = FALSE) {

  lawnlint(list(polygons, points), lint)
  if (lint) {
    is_type(polygons, type_top = "FeatureCollection")
    is_type(points, type_top = "FeatureCollection")
  }
  calc_math("mean", convert(polygons), convert(points), in_field, out_field)
}
