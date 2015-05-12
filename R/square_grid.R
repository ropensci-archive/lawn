#' Create a SquareGrid
#'
#' Takes a bounding box and a cell depth and returns a set of square
#' \code{\link{data-Polygon}}'s in a grid
#'
#' @export
#'
#' @param extent (numeric) extent in [minX, minY, maxX, maxY] order
#' @param cellWidth (integer) width of each cell
#' @param units (character) units to use for cellWidth, one of 'miles' or
#' 'kilometers'
#' @family interpolation
#' @return \code{\link{data-FeatureCollection}} grid of polygons
#' @examples
#' lawn_square_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 30, 'miles')
#' lawn_square_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 10, 'miles')
#' lawn_square_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 3, 'miles')
lawn_square_grid <- function(extent, cellWidth, units) {
  ct$eval(sprintf("var sg = turf.squareGrid(%s, %s, '%s');", toj(extent), cellWidth, units))
  as.fc(ct$get("sg"))
}
