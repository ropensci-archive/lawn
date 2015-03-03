#' Calculates the number of points that fall within the set of polygons.
#'
#' @export
#'
#' @param polygons Geojson polygons
#' @param points Geojson points
#' @param countField (character) A field to append to the attributes of the Polygon features
#' representing Point counts
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
#'           [-112.072391,46.586591],
#'           [-112.072391,46.61761],
#'           [-112.028102,46.61761],
#'           [-112.028102,46.586591],
#'           [-112.072391,46.586591]
#'           ]]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {},
#'       "geometry": {
#'         "type": "Polygon",
#'         "coordinates": [[
#'           [-112.023983,46.570426],
#'           [-112.023983,46.615016],
#'           [-111.966133,46.615016],
#'           [-111.966133,46.570426],
#'           [-112.023983,46.570426]
#'           ]]
#'       }
#'     }
#'     ]
#' };'
#' points <- '{
#' "type": "FeatureCollection",
#' "features": [
#'     {
#'       "type": "Feature",
#'       "properties": {
#'         "population": 200
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-112.0372, 46.608058]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {
#'         "population": 600
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-112.045955, 46.596264]
#'       }
#'     }
#'     ]
#' };'
#' count(polygons = polygons, points = points)
count <- function(polygons, points, countField = 'pt_count') {
  ct$eval(sprintf('var polygons = %s', polygons))
  ct$eval(sprintf('var points = %s', points))
  ct$eval(sprintf("var counted = turf.count(polygons, points, '%s');", countField))
  ct$get("counted")
}
