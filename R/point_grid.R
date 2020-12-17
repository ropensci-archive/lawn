#' Create a PointGrid
#'
#' Takes a bounding box and a cell depth and returns a set of
#' [data-Point]'s in a grid
#'
#' @export
#'
#' @param extent (numeric) Extent in `[minX, minY, maxX, maxY]` order.
#' @param cellSide (integer) the distance between points
#' @param units (character) Units to use for cellWidth, one of 'miles' or
#' 'kilometers' (default).
#' @param mask (logical) if passed a Polygon or MultiPolygon, the grid
#' Points will be created only inside it
#' @family interpolation
#' @return [data-FeatureCollection] grid of points.
#' @note parameters `centered` and `bboxIsMask` removed
#' @examples
#' lawn_point_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 30, 'miles')
#' lawn_point_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 10, 'miles')
#' lawn_point_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 3, 'miles')
lawn_point_grid <- function(extent, cellSide, units = "kilometers",
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
  ct$eval(sprintf("var pg = turf.pointGrid(%s, %s, options);",
    toj(extent), cellSide))
  as.fc(ct$get("pg"))
}
