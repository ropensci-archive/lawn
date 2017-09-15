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
#' @param centered (logical) adjust points position to center the grid into
#' bbox. This parameter is going to be removed in the next major release,
#' having the output always centered into bbox. Default: `TRUE`
#' @param bboxIsMask if `TRUE`, and bbox is a Polygon or MultiPolygon, the
#' grid Point will be created only if inside the bbox Polygon(s).
#' Default: `FALSE`
#' @family interpolation
#' @return [data-FeatureCollection] grid of points.
#' @examples
#' lawn_point_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 30, 'miles')
#' lawn_point_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 10, 'miles')
#' lawn_point_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 3, 'miles')
lawn_point_grid <- function(extent, cellSide, units = "kilometers",
                            centered = TRUE, bboxIsMask = FALSE) {

  ct$eval(sprintf("var pg = turf.pointGrid(%s, %s, '%s', %s, %s);", toj(extent),
                  cellSide, units, convert(centered), convert(bboxIsMask)))
  as.fc(ct$get("pg"))
}
