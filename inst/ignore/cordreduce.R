#' Reduce coordinates in any GeoJSON object into a single value.
#' However, in this case we lazily run the reduction, so an array of
#' all coordinates is unnecessary.
#'
#' @export
#' @param x any \code{\link{data-GeoJSON}} object
#' @param fun (character) a Javascript function. if not given, returns self
#' @param memo the starting value of memo: can be any type.
#' @param excludeWrapCoord (logical) whether or not to include
#' the final coordinate of LinearRings that wraps the ring in its iteration.
#' @template lint
#' @return matrix of coordinates, where each row in the matrix is a
#' coordinate pair
#' @examples
#' x <- "{ type: 'Point', coordinates: [10, 50] }"
#'
#' # don't apply any function, identity essentially
#' lawn_coordreduce(x)
#'
#' # appply a function callback
#' lawn_coordreduce(x, "z.length === 2")
#' lawn_coordreduce(lawn_data$points_count, "z.length === 2")
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
#' lawn_coordreduce(z)
#' lawn_coordreduce(z, "z.reduce(function(a, b) { return a + b; }, 0)")

lawn_coordreduce <- function(x, fun = NULL, memo = 0, excludeWrapCoord = FALSE,
                           lint = FALSE) {

  lawnlint(x, lint)
  ct$eval(
    sprintf("
      var ceach = [];
      turfmeta.coordReduce(%s, function(z) {
        res = %s;
        ceach.push(res);
      }, %s, %s);", convert(x), fun %||% 'z', memo, tolower(excludeWrapCoord)
    )
  )
  ct$get("ceach")
}
