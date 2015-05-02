#' Variance
#'
#' @export
#' @param polygons a FeatureCollection of \code{\link{data-Polygon}} features
#' @param points a FeatureCollection of \code{\link{data-Point}} features
#' @param in_field the field in input data to analyze
#' @param out_field the field in which to store results
#' @return a FeatureCollection of \code{\link{data-Polygon}} features with
#' properties listed as \code{out_field}
#' @template lint
#' @return A FeatureCollection of \code{\link{data-Polygon}} features with
#' properties listed as \code{out_field}
#' @details Calculates the variance value of a field for \code{\link{data-Point}}
#' features within a set of \code{\link{data-Polygon}} features.
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
#'           [-97.414398, 37.684092],
#'           [-97.414398, 37.731353],
#'           [-97.332344, 37.731353],
#'           [-97.332344, 37.684092],
#'           [-97.414398, 37.684092]
#'         ]]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {},
#'       "geometry": {
#'         "type": "Polygon",
#'         "coordinates": [[
#'           [-97.333717, 37.606072],
#'           [-97.333717, 37.675397],
#'           [-97.237586, 37.675397],
#'           [-97.237586, 37.606072],
#'           [-97.333717, 37.606072]
#'         ]]
#'       }
#'     }
#'   ]
#' }'
#'
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
#'         "coordinates": [-97.401351, 37.719676]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {
#'         "population": 600
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-97.355346, 37.706639]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {
#'         "population": 100
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-97.387962, 37.70012]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {
#'         "population": 200
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-97.301788, 37.66507]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {
#'         "population": 300
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-97.265052, 37.643325]
#'       }
#'     }
#'   ]
#' }'
#' variance(polygons, points, 'population', 'variance')
#' @examples \dontrun{
#' variance(polygons, points, 'population', 'variance') %>% view
#' }
variance <- function(polygons, points, in_field, out_field, lint = FALSE) {
  lawnlint(list(polygons, points), lint)
  py <- convert(polygons)
  pt <- convert(points)
  ct$eval(sprintf("var variance = turf.variance(%s, %s, '%s', '%s');", py, pt, in_field, out_field))
  ct$get("variance")
}
