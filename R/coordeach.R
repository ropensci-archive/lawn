#' Iterate over property objects in any GeoJSON object
#'
#' @export
#' @param x any [data-GeoJSON] object
#' @param fun (character) a Javascript function. if not given, returns self
#' @param excludeWrapCoord (logical) whether or not to include
#' the final coordinate of LinearRings that wraps the ring in its iteration.
#' @template lint
#' @return matrix of coordinates, where each row in the matrix is a
#' coordinate pair
#' @examples
#' x <- "{ type: 'Point', coordinates: [10, 50] }"
#'
#' # don't apply any function, identity essentially
#' lawn_coordeach(x)
#'
#' # appply a function callback
#' lawn_coordeach(x, "z.length === 2")
#' lawn_coordeach(lawn_data$points_count, "z.length === 2")
#'
#' z <- '{
#'   "type": "FeatureCollection",
#'   "features": [
#'     {
#'       "type": "Feature",
#'       "properties": {
#'         "population": 200,
#'         "name": "things"
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-112.0372, 46.608058]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {
#'         "population": 600,
#'         "name": "stuff"
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-112.045955, 46.596264]
#'       }
#'     }
#'     ]
#' }'
#' lawn_coordeach(z)
#' lawn_coordeach(z, "z.reduce(function(a, b) { return a + b; }, 0)")

lawn_coordeach <- function(x, fun = NULL, excludeWrapCoord = FALSE,
                           lint = FALSE) {

  lawnlint(x, lint)
  ct$eval(
    sprintf("
      var ceach = [];
      turfmeta.coordEach(%s, function(z) {
        res = %s;
        ceach.push(res);
      }, %s);", convert(x), fun %||% 'z', tolower(excludeWrapCoord)
    )
  )
  ct$get("ceach")
}
