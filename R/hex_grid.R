#' Create a HexGrid
#'
#' Takes a bounding box and a cell size in degrees and returns a
#' \code{\link{data-FeatureCollection}} of flat-topped hexagons
#' (\code{\link{data-Polygon}} features) aligned in an "odd-q" vertical
#' grid as described in Hexagonal Grids
#' \url{http://www.redblobgames.com/grids/hexagons/}
#'
#' @export
#'
#' @param extent (numeric) extent in [minX, minY, maxX, maxY] order
#' @param cellWidth (integer) width of each cell
#' @param units (character) units to use for cellWidth, one of 'miles' or
#' 'kilometers'
#' @family interpolation
#' @return \code{\link{data-FeatureCollection}} grid of points
#' @examples
#' lawn_hex_grid(c(-96,31,-84,40), 50, 'miles')
#' lawn_hex_grid(c(-96,31,-84,40), 30, 'miles')
lawn_hex_grid <- function(extent, cellWidth, units) {
  ct$eval(sprintf("var hg = turf.hexGrid(%s, %s, '%s');", toj(extent), cellWidth, units))
  as.fc(ct$get("hg"))
}
