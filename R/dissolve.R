#' Dissolves a FeatureCollection of polygons based on a property. Note
#' that multipart features within the collection are not supported
#'
#' @export
#' @param features A [data-FeatureCollection].
#' @param key (character) The property on which to filter.
#' @template lint
#' @family assertions
#' @return a [data-FeatureCollection] containing the dissolved
#' polygons
#' @examples
#' cat(lawn_data$filter_features)
#' lawn_dissolve(features = lawn_data$filter_features, key = 'species')
#' lawn_dissolve(lawn_data$filter_features, 'species')
lawn_dissolve <- function(features, key, lint = FALSE) {
  lawnlint(features, lint)
  ct$eval(sprintf('var out = turf.dissolve(%s, "%s");', features, key))
  as.fc(ct$get("out"))
}
