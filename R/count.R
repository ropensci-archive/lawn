#' Count number of points within polygons
#'
#' Calculates the number of \code{\link{data-Point}}'s that fall within the set
#' of \code{\link{data-Polygon}}'s
#'
#' @export
#'
#' @param polygons Geojson polygons
#' @param points Geojson points
#' @param countField (character) A field to append to the attributes of the Polygon features
#' representing Point counts
#' @template lint
#' @family aggregations
#' @return a \code{\link{data-FeatureCollection}}
#' @examples
#' # using data in the package
#' cat(lawn_data$points_count)
#' cat(lawn_data$polygons_count)
#' lawn_count(polygons = lawn_data$polygons_count, points = lawn_data$points_count)
lawn_count <- function(polygons, points, countField = 'pt_count', lint = FALSE) {
  lawnlint(list(polygons, points), lint)
  ct$eval(sprintf('var polygons = %s;', polygons))
  ct$eval(sprintf('var points = %s;', points))
  ct$eval(sprintf("var counted = turf.count(polygons, points, '%s');", countField))
  as.fc(ct$get("counted"))
}
