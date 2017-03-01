#' Reduce properties in any GeoJSON object into a single value.
#' However, in this case we lazily run the reduction, so an
#' array of all properties is unnecessary.
#'
#' @export
#' @param x any \code{\link{data-GeoJSON}} object
#' @param fun (character) a Javascript function. if not given, returns self
#' @param memo the starting value of memo: can be any type.
#' @template lint
#' @return list of properties
#' @examples
#' x <- "{ type: 'Point', coordinates: [10, 50] }"
#'
#' # don't apply any function, identity essentially
#' lawn_propreduce(x)
#'
#' # appply a function callback
#' lawn_propreduce(x, "z.length === 2")
#' lawn_propreduce(lawn_data$points_count, "z.length === 2")
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
#' lawn_propreduce(z)
#' lawn_propreduce(z, "z.reduce(function(a, b) { return a + b; }, 0)")

lawn_propreduce <- function(x, fun = NULL, memo = 0, lint = FALSE) {
  lawnlint(x, lint)
  ct$eval(
    sprintf("
      var ceach = [];
      turfmeta.propReduce(%s, function(z) {
        res = %s;
        ceach.push(res);
      }, %s);", convert(x), fun %||% 'z', memo
    )
  )
  ct$get("ceach")
}
