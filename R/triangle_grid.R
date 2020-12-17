#' Create a TriangleGrid
#'
#' Takes a bounding box and a cell depth and returns a set of triangular
#' [data-Polygon]'s in a grid.
#'
#' @export
#'
#' @param extent (numeric) Extent in `[minX, minY, maxX, maxY]` order.
#' @param cellSide (integer) dimension of each cell.
#' @param units (character) Units to use for cellSide, one of miles,
#' kilometers, degrees, radians
#' @family interpolation
#' @return [data-FeatureCollection] grid of [data-Polygon]'s
#' @examples
#' lawn_triangle_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 30, 'miles')
#' lawn_triangle_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 10, 'miles')
#' lawn_triangle_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 3, 'miles')
lawn_triangle_grid <- function(extent, cellSide, units = "kilometers",
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
  ct$eval(sprintf("var tg = turf.triangleGrid(%s, %s, options);",
    toj(extent), cellSide))
  as.fc(ct$get("tg"))
}
