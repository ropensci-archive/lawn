#' Calculate the average value of a field for a set of points within a set of polygons.
#'
#' @export
#'
#' @param polygons Geojson polygons
#' @param points Geojson points
#' @param field (character) The field in the points features from which to pull values to average
#' @param outputField (character) The field in polygons to put results of the averages
#' @examples
#' polygons <- '{
#'   "type": "FeatureCollection",
#'   "features": [
#'     {
#'       "type": "Feature",
#'       "properties": {},
#'       "geometry": {
#'         "type": "Polygon",
#'         "coordinates": [[
#'           [10.666351, 59.890659],
#'           [10.666351, 59.936784],
#'           [10.762481, 59.936784],
#'           [10.762481, 59.890659],
#'           [10.666351, 59.890659]
#'         ]]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {},
#'       "geometry": {
#'         "type": "Polygon",
#'         "coordinates": [[
#'           [10.764541, 59.889281],
#'           [10.764541, 59.937128],
#'           [10.866165, 59.937128],
#'           [10.866165, 59.889281],
#'           [10.764541, 59.889281]
#'         ]]
#'       }
#'     }
#'   ]
#' };'
#' points <- '{
#'   "type": "FeatureCollection",
#'   "features": [
#'     {
#'       "type": "Feature",
#'       "properties": {
#'         "population": 200
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [10.724029, 59.926807]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {
#'         "population": 600
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [10.715789, 59.904778]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {
#'         "population": 100
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [10.746002, 59.908566]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {
#'         "population": 200
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [10.806427, 59.908910]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {
#'         "population": 300
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [10.79544, 59.931624]
#'       }
#'     }
#'   ]
#' };'
#' average(polygons = polygons, points = points, 'population')
average <- function(polygons, points, field, outputField = 'average') {
  ct$eval(sprintf('var polygons = %s', polygons))
  ct$eval(sprintf('var points = %s', points))
  ct$eval(sprintf("var avg = turf.average(polygons, points, '%s', '%s');", field, outputField))
  ct$get("avg")
}
