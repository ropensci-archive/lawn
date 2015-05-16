#' Get a point at a distance along a line
#'
#' Takes a \code{\link{data-LineString}} and returns a \code{\link{data-Point}}
#' at a specified distance along the line.
#'
#' @export
#' @param line input \code{\link{data-LineString}}
#' @param distance distance along the line
#' @param units	can be degrees, radians, miles (default), or kilometers
#' @template lint
#' @family measurements
#' @return \code{\link{data-Point}} distance units along the line
#' @examples
#' pts <- '[
#'    [-21.964416, 64.148203],
#'    [-21.956176, 64.141316],
#'    [-21.93901, 64.135924],
#'    [-21.927337, 64.136673]
#' ]'
#' lawn_along(lawn_linestring(pts), 1, 'miles')
#' @examples \dontrun{
#' lawn_along(lawn_linestring(pts), 1, 'miles') %>% view
#' res <- lawn_along(lawn_linestring(pts), 1, 'miles')
#' lawn_featurecollection(list(res, lawn_linestring(pts))) %>% view
#' }
lawn_along <- function(line, distance, units, lint = FALSE) {
  line <- convert(line)
  lawnlint(line, lint)
  ct$eval(sprintf("var alg = turf.along(%s, %s, '%s');", line, distance, units))
  structure(ct$get("alg"), class = "point")
}
