#' Filter a FeatureCollection by a given property and value
#'
#' @export
#'
#' @param features A FeatureCollection
#' @param key (character) The property on which to filter
#' @param value (character) The value of that property on which to filter
#' @examples
#' dat <- filter_features
#' filter(dat, 'species', 'oak')
#' filter(dat, 'species', 'maple')
#' filter(dat, 'species', 'redwood')
filter <- function(features, key, value) {
  ct$eval(sprintf('var key = "%s";', key))
  ct$eval(sprintf('var value = "%s";', value))
  ct$eval(sprintf("var filtered = turf.filter(%s, key, value);", features))
  ct$get("filtered")
}
