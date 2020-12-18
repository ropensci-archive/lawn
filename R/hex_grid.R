#' Create a HexGrid
#'
#' Takes a bounding box and a cell size in degrees and returns a
#' [data-FeatureCollection] of flat-topped hexagons
#' ([data-Polygon] features) aligned in an "odd-q" vertical
#' grid as described in Hexagonal Grids
#' http://www.redblobgames.com/grids/hexagons/
#'
#' @export
#'
#' @param extent (numeric) Extent in `[minX, minY, maxX, maxY]` order.
#' @param cellWidth (integer) Width of each cell.
#' @param units (character) Units to use for cellWidth, one of 'miles' or
#' 'kilometers'.
#' @family interpolation
#' @return A [data-FeatureCollection] grid of points.
#' @examples
#' lawn_hex_grid(c(-96,31,-84,40), 50, 'miles')
#' lawn_hex_grid(c(-96,31,-84,40), 30, 'miles')
lawn_hex_grid <- function(extent, cellWidth, units) {
  ct$eval(sprintf("var hg = turf.hexGrid(%s, %s, {units:'%s'});",
    toj(extent), cellWidth, units))
  as.fc(ct$get("hg"))
}
