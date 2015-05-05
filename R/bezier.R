#' Bezier
#'
#' @export
#' @param line input \code{\link{data-LineString}}
#' @param resolution time in milliseconds between points
#' @param sharpness	a measure of how curvy the path should be between splines
#' @template lint
#' @return \code{\link{data-LineString}} curved line
#' @details Takes a \code{\link{data-LineString}} and returns a curved version
#' by applying a \href{http://en.wikipedia.org/wiki/Bezier_spline}{Bezier}
#' spline algorithm.
#' @examples
#' pts <- '[
#'    [-21.964416, 64.148203],
#'    [-21.956176, 64.141316],
#'    [-21.93901, 64.135924],
#'    [-21.927337, 64.136673]
#' ]'
#' bezier(linestring(pts))
#' bezier(linestring(pts), 9000L)
#' bezier(linestring(pts), 9000L, 0.65)
#' @examples \dontrun{
#' bezier(linestring(pts)) %>% view
#' featurecollection(list(linestring(pts), bezier(linestring(pts)))) %>% view
#' }
bezier <- function(line, resolution = 10000L, sharpness = 0.85, lint = FALSE) {
  line <- convert(line)
  lawnlint(line, lint)
  ct$eval(sprintf("var bz = turf.bezier(%s, %s, %s);", line, resolution, sharpness))
  structure(ct$get("bz"), class = "linestring")
}
