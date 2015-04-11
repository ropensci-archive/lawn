#' Nearest
#'
#' Takes a reference point and a set of points and returns the point from
#' the set closest to the reference
#'
#' @export
#'
#' @param point The reference point, a Feature
#' @param against Input point set, a FeatureCollection
#' @return A point as a Feature
#' @examples
#' point <- '{
#'   "type": "Feature",
#'   "properties": {
#'     "marker-color": "#0f0"
#'   },
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [28.965797, 41.010086]
#'   }
#' }'
#' against <- '{
#'  "type": "FeatureCollection",
#'  "features": [
#'    {
#'      "type": "Feature",
#'      "properties": {},
#'      "geometry": {
#'        "type": "Point",
#'        "coordinates": [28.973865, 41.011122]
#'      }
#'    }, {
#'      "type": "Feature",
#'      "properties": {},
#'      "geometry": {
#'        "type": "Point",
#'        "coordinates": [28.948459, 41.024204]
#'      }
#'    }, {
#'      "type": "Feature",
#'      "properties": {},
#'      "geometry": {
#'        "type": "Point",
#'        "coordinates": [28.938674, 41.013324]
#'      }
#'    }
#'  ]
#' }'
#' nearest(point, against)
nearest <- function(point, against) {
  point <- convert(point)
  against <- convert(against)
  ct$eval(sprintf("var nearest = turf.nearest(%s, %s);", point, against))
  ct$get("nearest")
}
