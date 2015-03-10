#' Calculate the area of a polygon or group of polygons
#'
#' @export
#'
#' @param input A feature or feature collection of polygons.
#'
#' @details Calculates the total area of a polygon or group of polygons. Returns
#'          the values in square meters.
#' @examples
#'
#' poly <- '{
#'  "type": "Feature",
#'  "properties": {},
#'  "geometry": {
#'    "type": "Polygon",
#'    "coordinates": [[ [0.0, 0.0],
#'      [1.0, 0.0],
#'      [1.0, 1.0],
#'      [0.0, 1.0],
#'      [0.0, 0.0] ]]
#'    }
#'    }'
#'
#' multipoly <- '{
#'  "type": "FeatureCollection",
#'  "features":[
#'    { "type": "Feature",
#'      "properties": {},
#'      "geometry": {
#'        "type": "Polygon",
#'          "coordinates": [[ [0.0, 0.0],
#'          [1.0, 0.0],
#'          [1.0, 1.0],
#'          [0.0, 1.0],
#'          [0.0, 0.0] ]]
#'          }
#'    },
#'    { "type": "Feature",
#'      "properties": {},
#'      "geometry": {
#'        "type": "Polygon",
#'        "coordinates": [[ [1.0, 1.0],
#'        [2.0, 1.0],
#'        [2.0, 2.0],
#'        [1.0, 2.0],
#'        [1.0, 1.0] ]]
#'        }
#'    }]
#'  }'
#' area(poly)
#' area(multipoly)
area <- function(input) {
  input <- convert(input)
  ct$eval(sprintf("var poly = %s;",input))
  ct$eval("var area = turf.area(poly);")
  ct$get("area")
}
