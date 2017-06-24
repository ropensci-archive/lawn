#' Get center point
#'
#' Takes a [data-FeatureCollection] and returns the
#' absolute center point of all features.
#'
#' @export
#' @param features Input features, as a [data-Feature] or
#' [data-FeatureCollection]
#' @param properties A list of properties. Default: `NULL`
#' @template lint
#' @family measurements
#' @return A [data-Point] feature at the absolute center point of
#' all input features.
#' @examples
#' lawn_center(lawn_data$points_average)
#' lawn_center(lawn_data$points_average, properties = list(
#'   foo = "bar", hello = "world"))
#' @examples \dontrun{
#' lawn_center(lawn_data$points_average) %>% view
#' lawn_featurecollection(lawn_data$points_average) %>% view
#' lawn_center(lawn_data$points_average) %>% view
#' }
lawn_center <- function(features, properties = NULL, lint = FALSE) {
  features <- convert(features)
  lawnlint(features, lint)
  is_type(features, type_top = c("Feature", "FeatureCollection"))
  ct$eval(sprintf("var cent = turf.center(%s, %s);", features, toj(properties)))
  structure(ct$get("cent"), class = "point")
}
