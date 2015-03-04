#' Return points that fall within polygons
#'
#' @export
#' @param polygons FeatureCollection of polygons
#' @param points FeatureCollection of points
#' @examples
#' within(points_within, polygon_within)
within <- function(points, polygons) {
  ct$eval(sprintf("var pts = turf.within(%s, %s);", points, polygons))
  ct$get("pts")
}
