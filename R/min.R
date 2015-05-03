#' Minimum
#'
#' @export
#' @template math
#' @template lint
#' @return A FeatureCollection of \code{\link{data-Polygon}} features with
#' properties listed as \code{out_field}
#' @details Calculates the variance value of a field for \code{\link{data-Point}}
#' features within a set of \code{\link{data-Polygon}} features.
#' @examples
#' poly <- lawn_data$polygons_average
#' pt <- lawn_data$points_average
#' min(poly, pt, 'population', 'min')
#' @examples \dontrun{
#' min(poly, pt, 'population', 'min') %>% view
#' }
min <- function(polygons, points, in_field, out_field, lint = FALSE) {
  lawnlint(list(polygons, points), lint)
  py <- convert(polygons)
  pt <- convert(points)
  ct$eval(sprintf("var min = turf.min(%s, %s, '%s', '%s');", py, pt, in_field, out_field))
  ct$get("min")
}
