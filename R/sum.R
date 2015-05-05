#' Sum
#'
#' @export
#' @template math
#' @template lint
#' @return A FeatureCollection of \code{\link{data-Polygon}} features with
#' properties listed as \code{out_field}
#' @details Calculates the sum of a field for \code{\link{data-Point}} features
#' within a set of \code{\link{data-Polygon}} features.
#' @examples
#' poly <- lawn_data$polygons_average
#' pt <- lawn_data$points_average
#' lawn_sum(poly, pt, 'population', 'sum')
#' @examples \dontrun{
#' lawn_sum(poly, pt, 'population', 'sum') %>% view
#' }
lawn_sum <- function(polygons, points, in_field, out_field, lint = FALSE) {
  lawnlint(list(polygons, points), lint)
  py <- convert(polygons)
  pt <- convert(points)
  ct$eval(sprintf("var sumed = turf.sum(%s, %s, '%s', '%s');", py, pt, in_field, out_field))
  ct$get("sumed")
}
