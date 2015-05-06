#' Generate Isolines
#'
#' Takes \code{\link{data-Point}}'s with z-values and an array of value
#' breaks and generates \href{http://en.wikipedia.org/wiki/Isoline}{isolines}
#'
#' @export
#'
#' @param points Input points
#' @param z (character) the property name in points from which z-values will be pulled
#' @param resolution (numeric) resolution of the underlying grid
#' @param breaks (numeric) where to draw contours
#' @template lint
#' @family interpolation
#' @return \code{\link{data-FeatureCollection}} of isolines
#' (\code{\link{data-LineString}} features)
#' @examples
#' pts <- lawn_random(n = 100, bbox = c(0, 30, 20, 50))
#' pts$features$properties <- data.frame(z = round(rnorm(100, mean = 5)), stringsAsFactors = FALSE)
#' breaks <- c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
#' lawn_isolines(pts, 'z', 15, breaks)
#'
#' @examples \dontrun{
#' lawn_isolines(pts, 'z', 15, breaks) %>% view
#' }
lawn_isolines <- function(points, z, resolution, breaks, lint = FALSE) {
  points <- convert(points)
  lawnlint(points, lint)
  ct$eval(sprintf("var iso = turf.isolines(%s, '%s', %s, %s);",
                  points, z, resolution, toj(breaks)))
  as.fc(ct$get("iso"))
}
