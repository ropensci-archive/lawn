#' Center
#'
#' @export
#' @param features input featurs, as a \code{\link{data-FeatureCollection}}
#' @template lint
#' @return a \code{\link{data-Point}} feature at the absolute center point of
#' all input features
#' @details Takes a \code{\link{data-FeatureCollection}} and returns the
#' absolute center point of all features.
#' @examples
#' center(lawn_data$points_average)
#' @examples \dontrun{
#' center(lawn_data$points_average) %>% view
#' featurecollection(lawn_data$points_average) %>% view
#' center(lawn_data$points_average) %>% view
#' }
center <- function(features, lint = FALSE) {
  features <- convert(features)
  lawnlint(features, lint)
  ct$eval(sprintf("var cent = turf.center(%s);", features))
  ct$get("cent")
}
