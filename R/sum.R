#' Sum
#'
#' @export
#' @param polygons a FeatureCollection of \code{\link{data-Polygon}} features
#' @param points a FeatureCollection of \code{\link{data-Point}} features
#' @param in_field the field in input data to analyze
#' @param out_field the field in which to store results
#' @template lint
#' @return A FeatureCollection of \code{\link{data-Polygon}} features with
#' properties listed as \code{out_field}
#' @details Calculates the sum of a field for \code{\link{data-Point}} features
#' within a set of \code{\link{data-Polygon}} features.
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
#'           [-87.990188, 43.026486],
#'           [-87.990188, 43.062115],
#'           [-87.913284, 43.062115],
#'           [-87.913284, 43.026486],
#'           [-87.990188, 43.026486]
#'         ]]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {},
#'       "geometry": {
#'         "type": "Polygon",
#'         "coordinates": [[
#'           [-87.973709, 42.962452],
#'           [-87.973709, 43.014689],
#'           [-87.904014, 43.014689],
#'           [-87.904014, 42.962452],
#'           [-87.973709, 42.962452]
#'         ]]
#'       }
#'     }
#'   ]
#' }'
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
#'         "coordinates": [-87.974052, 43.049321]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {
#'         "population": 600
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-87.957229, 43.037277]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {
#'         "population": 100
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-87.931137, 43.048568]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {
#'         "population": 200
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-87.963409, 42.99611]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {
#'         "population": 300
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-87.94178, 42.974762]
#'       }
#'     }
#'   ]
#' }'
#' sum(polygons, points, 'population', 'sum')
sum <- function(polygons, points, in_field, out_field, lint = FALSE) {
  lawnlint(list(polygons, points), lint)
  py <- convert(polygons)
  pt <- convert(points)
  ct$eval(sprintf("var sumed = turf.sum(%s, %s, '%s', '%s');", py, pt, in_field, out_field))
  ct$get("sumed")
}
