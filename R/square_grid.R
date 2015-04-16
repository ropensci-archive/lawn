#' SquareGrid
#'
#' Takes a bounding box and a cell depth and returns a set of square polygons in a grid
#'
#' @export
#'
#' @param extent (numeric) extent in [minX, minY, maxX, maxY] order
#' @param cellWidth (integer) width of each cell
#' @param units (character) units to use for cellWidth, one of 'miles', xxxx
#' @return FeatureCollection grid of polygons
#' @examples
#' square_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 30, 'miles')
#' square_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 10, 'miles')
#' square_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 3, 'miles')
square_grid <- function(extent, cellWidth, units) {
  ct$eval(sprintf("var sg = turf.squareGrid(%s, %s, '%s');", toj(extent), cellWidth, units))
  ct$get("sg")
}