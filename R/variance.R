#' Variance of a field among points within polygons
#'
#' Calculates the variance value of a field for a set of \code{\link{data-Point}}'s
#' within a set of \code{\link{data-Polygon}}'s
#'
#' @export
#' @template math
#' @family aggregations
#' @return a FeatureCollection of \code{\link{data-Polygon}} features with
#' properties listed as \code{out_field}
#' @template lint
#' @return A FeatureCollection of \code{\link{data-Polygon}} features with
#' properties listed as \code{out_field}
#' @examples \dontrun{
#' poly <- lawn_data$polygons_average
#' pt <- lawn_data$points_average
#' lawn_variance(poly, pt, 'population')
#' }
lawn_variance <- function(polygons, points, in_field, out_field = "variance", lint = FALSE) {
  lawnlint(list(polygons, points), lint)
  calc_math("variance", convert(polygons), convert(points), in_field, out_field)
}
