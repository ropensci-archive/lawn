#' Iterate over property objects in any GeoJSON object
#'
#' @export
#' @param x any [data-GeoJSON] object
#' @param fun a Javascript function. if not given, returns self
#' @template lint
#' @return matrix of coordinates, where each row in the matrix is a
#' coordinate pair
#' @examples
#' x <- "{ type: 'Feature', geometry: null, properties: { foo: 1, bar: 3 } }"
#'
#' # don't apply any function, identity essentially
#' lawn_propeach(x)
#'
#' # appply a function callback
#' lawn_propeach(x, "z.foo === 1")
#'
#' lawn_propeach(lawn_data$points_count)
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
#' lawn_propeach(z)
#' lawn_propeach(z, "z.population === 200")
#' lawn_propeach(z, "z.name === 'stuff'")

lawn_propeach <- function(x, fun = NULL, lint = FALSE) {
  lawnlint(x, lint)
  ct$eval(
    sprintf("
      var peach = [];
      turfmeta.propEach(%s, function(z) {
        res = %s;
        peach.push(res);
      });", convert(x), fun %||% 'z'
    )
  )
  as.list(ct$get("peach"))
}
