#' Return a FeatureCollection with features removed matching value of property given
#'
#' @export
#'
#' @param features A set of input features
#' @param property Property to filter
#' @param value Value to filter
#' @return A FeatureCollection
#' @examples
#' cat(lawn_data$remove_features)
#' remove(lawn_data$remove_features, 'marker-color', '#00f')
#' remove(lawn_data$remove_features, 'marker-color', '#0f0')
remove <- function(features, property, value) {
  ct$eval(sprintf("var rmv = turf.remove(%s, '%s', '%s');", features, property, value))
  ct$get("rmv")
}
