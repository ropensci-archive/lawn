#' Remove things from a FeatureCollection
#'
#' Takes a \code{\link{data-FeatureCollection}} of any type, a property, and a
#' value and returns a \code{\link{data-FeatureCollection}} with features
#' matching that property-value pair removed.
#'
#' @export
#'
#' @param features A set of input features
#' @param property Property to filter
#' @param value Value to filter
#' @template lint
#' @family data functions
#' @return A \code{\link{data-FeatureCollection}}
#' @examples
#' cat(lawn_data$remove_features)
#' lawn_remove(lawn_data$remove_features, 'marker-color', '#00f')
#' lawn_remove(lawn_data$remove_features, 'marker-color', '#0f0')
lawn_remove <- function(features, property, value, lint = FALSE) {
  features <- convert(features)
  lawnlint(features, lint)
  ct$eval(sprintf("var rmv = turf.remove(%s, '%s', '%s');", features, property, value))
  as.fc(ct$get("rmv"))
}
