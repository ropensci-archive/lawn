#' Variance
#'
#' @export
#' @template math
#' @return a FeatureCollection of \code{\link{data-Polygon}} features with
#' properties listed as \code{out_field}
#' @template lint
#' @return A FeatureCollection of \code{\link{data-Polygon}} features with
#' properties listed as \code{out_field}
#' @details Calculates the variance value of a field for \code{\link{data-Point}}
#' features within a set of \code{\link{data-Polygon}} features.
#' @examples
#' poly <- lawn_data$polygons_average
#' pt <- lawn_data$points_average
#' lawn_variance(poly, pt, 'population', 'variance')
#' @examples \dontrun{
#' lawn_variance(poly, pt, 'population', 'variance') %>% view
#' }
lawn_variance <- function(polygons, points, in_field, out_field, lint = FALSE) {
  lawnlint(list(polygons, points), lint)
  py <- convert(polygons)
  pt <- convert(points)
  ct$eval(sprintf("var variance = turf.variance(%s, %s, '%s', '%s');", py, pt, in_field, out_field))
  ct$get("variance")
}
