#' Isolines
#'
#' Takes points with z-values and an array of value breaks and generates isolines
#'
#' @export
#'
#' @param points Input points
#' @param z (character) the property name in points from which z-values will be pulled
#' @param resolution (numeric) resolution of the underlying grid
#' @param breaks (numeric) where to draw contours
#' @return FeatureCollection of isolines (LineString features)
#' @examples
#' pts <- lawn_random(n = 10)
#' pts$features$properties <- data.frame(z = round(rnorm(10, mean = 10)), stringsAsFactors = FALSE)
#' breaks <- c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
#' lawn_isolines(pts, 'z', 15, breaks)
lawn_isolines <- function(points, z, resolution, breaks) {
  points <- convert(points)
  ct$eval(sprintf("var iso = turf.isolines(%s, '%s', %s, %s);",
                  points, z, resolution, breaks))
  ct$get("iso")
}
