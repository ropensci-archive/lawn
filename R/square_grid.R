#' Create a SquareGrid
#'
#' Takes a bounding box and a cell depth and returns a set of square
#' [data-Polygon]'s in a grid.
#'
#' @export
#'
#' @param extent (numeric) Extent in `[minX, minY, maxX, maxY]` order.
#' @param cellSide (integer) dimension of each cell.
#' @param units (character) Units to use for cellSide, one of 'miles' or
#' 'kilometers'.
#' @family interpolation
#' @return [data-FeatureCollection] grid of polygons.
#' @examples
#' lawn_square_grid(c(-95, 30 ,-85, 40), 30, 'miles')
#' lawn_square_grid(c(-95, 30 ,-85, 40), 10, 'miles')
#' lawn_square_grid(c(-95, 30 ,-85, 40), 3, 'miles')
lawn_square_grid <- function(extent, cellSide, units = "kilometers",
  mask = NULL) {

  assert(extent, c('numeric', 'integer'))
  assert(cellSide, c('numeric', 'integer'))
  assert(units, 'character')
  if (!is.null(mask)) {
    ct$eval(sprintf("var options = {units:'%s', mask:%s};", units,
      convert(mask)))
  } else {
    ct$eval(sprintf("var options = {units:'%s'};", units))
  }
  ct$eval(sprintf("var sg = turf.squareGrid(%s, %s, options);",
    toj(extent), cellSide))
  as.fc(ct$get("sg"))
}
