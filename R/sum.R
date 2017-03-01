#' Sum of a field among points within polygons
#'
#' Calculates the sum of a field for a set of [data-Point]'s
#' within a set of [data-Polygon]'s.
#'
#' @export
#' @template math
#' @template lint
#' @family aggregations
#' @return A FeatureCollection of [data-Polygon] features with
#' properties listed as `out_field`.
#' @examples \dontrun{
#' poly <- lawn_data$polygons_average
#' pt <- lawn_data$points_average
#' lawn_sum(poly, pt, 'population')
#' }
lawn_sum <- function(polygons, points, in_field, out_field = "sum",
                     lint = FALSE) {

  lawnlint(list(polygons, points), lint)
  calc_math("sum", convert(polygons), convert(points), in_field, out_field)
}
