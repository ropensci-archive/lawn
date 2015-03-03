#' Calculates the number of points that fall within the set of polygons.
#'
#' @export
#'
#' @param polygons Geojson polygons
#' @param points Geojson points
#' @param countField (character) A field to append to the attributes of the Polygon features
#' representing Point counts
#' @examples
#' # using data in the package
#' count(polygons = polygons_count, points = points_count)
count <- function(polygons, points, countField = 'pt_count') {
  ct$eval(sprintf('var polygons = %s;', polygons))
  ct$eval(sprintf('var points = %s;', points))
  ct$eval(sprintf("var counted = turf.count(polygons, points, '%s');", countField))
  ct$get("counted")
}
