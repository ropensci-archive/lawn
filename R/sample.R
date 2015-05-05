#' Return features from FeatureCollection at random
#'
#' Takes a \code{\link{data-FeatureCollection}} and returns a
#' \code{\link{data-FeatureCollection}} with given number of features at random
#'
#' @export
#' @param features A FeatureCollection
#' @param n (integer) Number of features to generate
#' @template lint
#' @family data functions
#' @return A \code{\link{data-FeatureCollection}}
#'
#' @examples
#' lawn_sample(lawn_data$points_average, 1)
#' lawn_sample(lawn_data$points_average, 2)
#' lawn_sample(lawn_data$points_average, 3)
lawn_sample <- function(features = NULL, n = 100, lint = FALSE) {
  if (!is.null(features)) lawnlint(features, lint)
  ct$eval(sprintf("var pts = turf.sample(%s, %s);", features, n))
  as.fc(ct$get("pts"))
}
