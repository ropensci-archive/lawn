#' Curve a linestring
#'
#' Takes a [data-LineString] and returns a curved version
#' by applying a \href{http://en.wikipedia.org/wiki/Bezier_spline}{Bezier}
#' spline algorithm.
#'
#' @export
#' @param line A [data-Feature] with a single [data-LineString]
#' @param resolution Time in milliseconds between points
#' @param sharpness	A measure of how curvy the path should be between splines
#' @template lint
#' @family transformations
#' @return A [data-LineString] curved line.
#' @examples
#' pts <- '[
#'    [-21.964416, 64.148203],
#'    [-21.956176, 64.141316],
#'    [-21.93901, 64.135924],
#'    [-21.927337, 64.136673]
#' ]'
#' lawn_bezier(lawn_linestring(pts))
#' lawn_bezier(lawn_linestring(pts), 9000L)
#' lawn_bezier(lawn_linestring(pts), 9000L, 0.65)
#' @examples \dontrun{
#' lawn_bezier(lawn_linestring(pts)) %>% view
#' lawn_featurecollection(list(lawn_linestring(pts),
#'   lawn_bezier(lawn_linestring(pts)))) %>% view
#' }
lawn_bezier <- function(line, resolution = 10000L, sharpness = 0.85,
                        lint = FALSE) {

  line <- convert(line)
  lawnlint(line, lint)
  if (lint) is_type(line, type_top = "Feature", type_lower = "LineString")
  ct$eval(sprintf("var bz = turf.bezier(%s, %s, %s);", line, resolution,
                  sharpness))
  structure(ct$get("bz"), class = "linestring")
}
