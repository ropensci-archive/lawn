#' Return points that fall within polygons
#'
#' Takes a set of \code{\link{data-Point}}'s and a set of
#' \code{\link{data-Polygon}}'s and returns points that fall within
#' the polygons
#'
#' @export
#' @param points \code{\link{data-FeatureCollection}} of points
#' @param polygons \code{\link{data-FeatureCollection}} of polygons
#' @template lint
#' @family joins
#' @return points that land within at least one polygon, as a
#' \code{\link{data-FeatureCollection}}
#' @examples
#' cat(lawn_data$points_within)
#' cat(lawn_data$polygons_within)
#' lawn_within(lawn_data$points_within, lawn_data$polygons_within)
lawn_within <- function(points, polygons, lint = FALSE) {
  points <- convert(points)
  polygons <- convert(polygons)
  lawnlint(list(points, polygons), lint)
  ct$eval(sprintf("var pts = turf.within(%s, %s);", points, polygons))
  as.fc(ct$get("pts"))
}
