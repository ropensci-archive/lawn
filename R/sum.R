#' Sum of a field among points within polygons
#'
#' Calculates the sum of a field for a set of \code{\link{data-Point}}'s
#' within a set of \code{\link{data-Polygon}}'s
#'
#' @export
#' @template math
#' @template lint
#' @family aggregations
#' @return A FeatureCollection of \code{\link{data-Polygon}} features with
#' properties listed as \code{out_field}
#' @examples
#' poly <- lawn_data$polygons_average
#' pt <- lawn_data$points_average
#' lawn_sum(poly, pt, 'population', 'sum')
#' @examples \dontrun{
#' lawn_sum(poly, pt, 'population', 'sum') %>% view
#' }
lawn_sum <- function(polygons, points, in_field, out_field, lint = FALSE) {
  py <- convert(polygons)
  pt <- convert(points)
  lawnlint(list(polygons, points), lint)
  ct$eval(sprintf("var sumed = turf.sum(%s, %s, '%s', '%s');", py, pt, in_field, out_field))
  as.fc(ct$get("sumed"))
}
