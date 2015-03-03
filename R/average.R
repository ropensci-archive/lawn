#' Calculate the average value of a field for a set of points within a set of polygons.
#'
#' @export
#'
#' @param polygons Geojson polygons
#' @param points Geojson points
#' @param field (character) The field in the points features from which to pull values to average
#' @param outputField (character) The field in polygons to put results of the averages
#' @examples
#' # using data in the package
#' average(polygons = polygons_average, points = points_average, 'population')
average <- function(polygons, points, field, outputField = 'average') {
  ct$eval(sprintf('var polygons = %s;', polygons))
  ct$eval(sprintf('var points = %s;', points))
  ct$eval(sprintf("var avg = turf.average(polygons, points, '%s', '%s');", field, outputField))
  ct$get("avg")
}
