#' Filter a FeatureCollection by a given property and value
#'
#' @export
#'
#' @param features A FeatureCollection
#' @param key (character) The property on which to filter
#' @param value (character) The value of that property on which to filter
#' @examples
#' cat(lawn_data$filter_features)
#' filter(lawn_data$filter_features, 'species', 'oak')
#' filter(lawn_data$filter_features, 'species', 'maple')
#' filter(lawn_data$filter_features, 'species', 'redwood')
filter <- function(features, key, value) {
  ct$eval(sprintf('var key = "%s";', key))
  ct$eval(sprintf('var value = "%s";', value))
  ct$eval(sprintf("var filtered = turf.filter(%s, key, value);", features))
  ct$get("filtered")
}
