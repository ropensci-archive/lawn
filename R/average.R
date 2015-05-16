#' Average of a field among points within polygons
#'
#' Calculate the average value of a field for a set of \code{\link{data-Point}}'s
#' within a set of \code{\link{data-Polygon}}'s
#'
#' @export
#'
#' @param polygons Geojson \code{\link{data-Polygon}}'s
#' @param points Geojson \code{\link{data-Point}}'s
#' @param field (character) The field in the points features from which to pull
#' values to average
#' @param outputField (character) The field in polygons to put results of the
#' averages
#' @template lint
#' @family aggregations
#' @return polygons with the value of outField set to the calculated averages
#' @examples
#' # using data in the package
#' cat(lawn_data$points_average)
#' cat(lawn_data$polygons_average)
#' lawn_average(polygons = lawn_data$polygons_average,
#'              points = lawn_data$points_average, 'population')
lawn_average <- function(polygons, points, field, outputField = 'average', lint = FALSE) {
  lawnlint(list(polygons, points), lint)
  ct$eval(sprintf('var polygons = %s;', polygons))
  ct$eval(sprintf('var points = %s;', points))
  ct$eval(sprintf("var avg = turf.average(polygons, points, '%s', '%s');", field, outputField))
  as.fc(ct$get("avg"))
}
