#' PointGrid
#'
#' Takes a bounding box and a cell depth and returns a set of points in a grid
#'
#' @export
#'
#' @param extent (numeric) extent in [minX, minY, maxX, maxY] order
#' @param cellWidth (integer) width of each cell
#' @param units (character) units to use for cellWidth, one of 'miles', xxxx
#' @return FeatureCollection grid of points
#' @examples
#' lawn_point_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 30, 'miles')
#' lawn_point_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 10, 'miles')
#' lawn_point_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 3, 'miles')
lawn_point_grid <- function(extent, cellWidth, units) {
  ct$eval(sprintf("var pg = turf.pointGrid(%s, %s, '%s');", toj(extent), cellWidth, units))
  ct$get("pg")
}
