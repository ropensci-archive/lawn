#' Create a PointGrid
#'
#' Takes a bounding box and a cell depth and returns a set of
#' [data-Point]'s in a grid
#'
#' @export
#'
#' @param extent (numeric) Extent in `[minX, minY, maxX, maxY]` order.
#' @param cellWidth (integer) Width of each cell.
#' @param units (character) Units to use for cellWidth, one of 'miles' or
#' 'kilometers'.
#' @family interpolation
#' @return [data-FeatureCollection] grid of points.
#' @examples
#' lawn_point_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 30, 'miles')
#' lawn_point_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 10, 'miles')
#' lawn_point_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 3, 'miles')
lawn_point_grid <- function(extent, cellWidth, units) {
  ct$eval(sprintf("var pg = turf.pointGrid(%s, %s, '%s');", toj(extent),
                  cellWidth, units))
  as.fc(ct$get("pg"))
}
