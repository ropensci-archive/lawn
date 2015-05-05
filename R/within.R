#' Return points that fall within polygons
#'
#' @export
#' @param polygons FeatureCollection of polygons
#' @param points FeatureCollection of points
#' @template lint
#' @examples
#' cat(lawn_data$points_within)
#' cat(lawn_data$polygons_within)
#' lawn_within(lawn_data$points_within, lawn_data$polygons_within)
lawn_within <- function(points, polygons, lint = FALSE) {
  points <- convert(points)
  polygons <- convert(polygons)
  lawnlint(list(points, polygons))
  ct$eval(sprintf("var pts = turf.within(%s, %s);", points, polygons))
  ct$get("pts")
}
