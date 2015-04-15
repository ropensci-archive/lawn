#' HexGrid
#'
#' Takes a bounding box and a cell size in degrees and returns a
#' FeatureCollection of flat-topped hexagons (Polygon features)
#' aligned in an "odd-q" vertical grid as described in
#' Hexagonal Grids \url{http://www.redblobgames.com/grids/hexagons/}
#'
#' @export
#'
#' @param extent (numeric) extent in [minX, minY, maxX, maxY] order
#' @param cellWidth (integer) width of each cell
#' @param units (character) units to use for cellWidth, one of 'miles', xxxx
#' @return FeatureCollection grid of points
#' @examples
#' hex_grid(c(-96,31,-84,40), 50, 'miles')
#' hex_grid(c(-96,31,-84,40), 30, 'miles')
#' hex_grid(c(-96,31,-84,40), 10, 'miles')
hex_grid <- function(extent, cellWidth, units) {
  ct$eval(sprintf("var hg = turf.hexGrid(%s, %s, '%s');", toj(extent), cellWidth, units))
  ct$get("hg")
}
