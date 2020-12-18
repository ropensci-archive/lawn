#' Dissolves a FeatureCollection of polygons based on a property. Note
#' that multipart features within the collection are not supported
#'
#' @export
#' @param features A [data-FeatureCollection]<([data-Polygon])>
#' @param key (character) The property on which to filter
#' @template lint
#' @family assertions
#' @return a [data-FeatureCollection]<([data-Polygon])> containing the
#' dissolved polygons
#' @examples
#' cat(lawn_data$filter_features)
#' x <- '{
#'  "type": "FeatureCollection",
#'  "features": [
#'   {
#'     "type": "Feature",
#'     "properties": {
#'       "combine": "yes"
#'     },
#'     "geometry": {
#'       "type": "Polygon",
#'       "coordinates": [[[0, 0], [0, 1], [1, 1], [1, 0], [0, 0]]]
#'     }
#'   },
#'   {
#'     "type": "Feature",
#'     "properties": {
#'       "combine": "yes"
#'     },
#'     "geometry": {
#'       "type": "Polygon",
#'       "coordinates": [[[0, -1], [0, 0], [1, 0], [1, -1], [0,-1]]]
#'     }
#'   },
#'   {
#'     "type": "Feature",
#'     "properties": {
#'       "combine": "no"
#'     },
#'     "geometry": {
#'       "type": "Polygon",
#'       "coordinates": [[[1,-1],[1, 0], [2, 0], [2, -1], [1, -1]]]
#'     }
#'   }
#'   ]
#' }'
#' lawn_dissolve(x, key = 'combine')
lawn_dissolve <- function(features, key, lint = FALSE) {
  lawnlint(features, lint)
  if (lint) is_type(features, "FeatureCollection", "Polygon")
  ct$eval(sprintf('var out = turf.dissolve(%s, {propertyName:"%s"});',
    features, key))
  as.fc(ct$get("out"))
}
