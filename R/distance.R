#' Calculate the distance between two points
#'
#' @importFrom jsonlite toJSON
#' @export
#'
#' @param polygons Geojson polygons
#' @param points Geojson points
#' @param field (character) The field in the points features from which to pull values to average
#' @param outputField (character) The field in polygons to put results of the averages
#' @details Calculates the distance between two points in degress, radians, miles, or kilometers.
#' Uses the Haversine formula to account for global curvature.
#' @examples
#' from <- '{
#'  "type": "Feature",
#'  "properties": {},
#'  "geometry": {
#'    "type": "Point",
#'    "coordinates": [-75.343, 39.984]
#'  }
#' }'
#' to <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [-75.534, 39.123]
#'   }
#' }'
#' distance(from, to)
#'
#' # from us.cities dataset
#' library('maps')
#' library('geojsonio')
#' data(us.cities)
#' out <- geojson_list(us.cities[1:2,], lat='lat', lon='long')
#' distance(from=out$features[[1]], out$features[[2]])
distance <- function(from, to, units = 'kilometers') {
  from <- convert(from)
  to <- convert(to)
  ct$eval(sprintf('var point1 = %s;', from))
  ct$eval(sprintf('var point2 = %s;', to))
  ct$eval(sprintf("var avg = turf.distance(point1, point2, '%s');", units))
  ct$get("avg")
}

convert <- function(x) {
  if(is.character(x)) {
    x
  } else {
    jsonlite::toJSON(x, auto_unbox = TRUE)
  }
}
