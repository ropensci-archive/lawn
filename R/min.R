#' Minimum value of a field among points within polygons
#'
#' Calculates the minimum value of a field for a set of \code{\link{data-Point}}'s
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
#' lawn_min(poly, pt, 'population', 'min')
#' @examples \dontrun{
#' lawn_min(poly, pt, 'population', 'min') %>% view
#' }
lawn_min <- function(polygons, points, in_field, out_field, lint = FALSE) {
  lawnlint(list(polygons, points), lint)
  py <- convert(polygons)
  pt <- convert(points)
  ct$eval(sprintf("var min = turf.min(%s, %s, '%s', '%s');", py, pt, in_field, out_field))
  as.fc(ct$get("min"))
}
