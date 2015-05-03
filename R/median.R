#' Median
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
#' median(poly, pt, 'population', 'median')
#' @examples \dontrun{
#' median(poly, pt, 'population', 'median') %>% view
#' }
median <- function(polygons, points, in_field, out_field, lint = FALSE) {
  lawnlint(list(polygons, points), lint)
  py <- convert(polygons)
  pt <- convert(points)
  ct$eval(sprintf("var med = turf.median(%s, %s, '%s', '%s');", py, pt, in_field, out_field))
  ct$get("med")
}
