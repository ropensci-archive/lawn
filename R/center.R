#' Get center point
#'
#' Takes a \code{\link{data-FeatureCollection}} and returns the
#' absolute center point of all features
#'
#' @export
#' @param features input featurs, as a \code{\link{data-FeatureCollection}}
#' @template lint
#' @family measurements
#' @return a \code{\link{data-Point}} feature at the absolute center point of
#' all input features
#' @examples
#' lawn_center(lawn_data$points_average)
#' @examples \dontrun{
#' lawn_center(lawn_data$points_average) %>% view
#' lawn_featurecollection(lawn_data$points_average) %>% view
#' lawn_center(lawn_data$points_average) %>% view
#' }
lawn_center <- function(features, lint = FALSE) {
  features <- convert(features)
  lawnlint(features, lint)
  ct$eval(sprintf("var cent = turf.center(%s);", features))
  structure(ct$get("cent"), class = "point")
}
