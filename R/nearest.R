#' Get nearest point
#'
#' Takes a reference [data-Point] and a set of points to compare it
#' against and returns the point from the set closest to the reference
#'
#' @export
#'
#' @param point The reference point, a [data-Feature].
#' @param against Input point set, a [data-FeatureCollection].
#' @template lint
#' @family classification
#' @return A [data-Point] as a Feature.
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
#' lawn_nearest(point, against)
#'
#' @examples \dontrun{
#' lawn_nearest(point, against) %>% view
#' }
lawn_nearest <- function(point, against, lint = FALSE) {
  point <- convert(point)
  against <- convert(against)
  lawnlint(list(point, against), lint)
  ct$eval(sprintf("var nearest = turf.nearest(%s, %s);", point, against))
  structure(ct$get("nearest"), class = "point")
}
