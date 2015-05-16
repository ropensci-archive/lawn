#' Maximum value of a field among points within polygons
#'
#' Calculates the maximum value of a field for a set of \code{\link{data-Point}}'s
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
#' lawn_max(poly, pt, 'population', 'max')
#' @examples \dontrun{
#' lawn_max(poly, pt, 'population', 'max') %>% view
#' }
lawn_max <- function(polygons, points, in_field, out_field, lint = FALSE) {
  lawnlint(list(polygons, points), lint)
  py <- convert(polygons)
  pt <- convert(points)
  ct$eval(sprintf("var max = turf.max(%s, %s, '%s', '%s');", py, pt, in_field, out_field))
  as.fc(ct$get("max"))
}
