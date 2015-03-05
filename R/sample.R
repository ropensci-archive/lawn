#' Return a FeatureCollection with given number of features at random
#'
#' @export
#'
#' @param n (integer) Number of features to select.
#' @param features A FeatureCollection
#' @examples
#' # Random set of points
#' random(2)
#' random(10)
#' random(1000)
#'
#' # Sample points from a FeatureCollection
#' sample(lawn_data$points_average, 1)
#' sample(lawn_data$points_average, 2)
#' sample(lawn_data$points_average, 3)
random <- function(n = 10) {
  ct$eval(sprintf("var pts = turf.random('points', %s);", n))
  ct$get("pts")
}

#' @export
#' @rdname random
sample <- function(features = NULL, n = 100) {
  ct$eval(sprintf("var pts = turf.sample(%s, %s);", features, n))
  ct$get("pts")
}
