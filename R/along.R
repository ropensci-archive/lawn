#' Along
#'
#' @export
#' @param line input \code{\link{data-LineString}}
#' @param distance distance along the line
#' @param units	can be degrees, radians, miles (default), or kilometers
#' @template lint
#' @return \code{\link{data-Point}} distance units along the line
#' @details Takes a \code{\link{data-LineString}} and returns a \code{\link{data-Point}}
#' at a specified distance along the line.
#' @examples
#' pts <- '[
#'    [-21.964416, 64.148203],
#'    [-21.956176, 64.141316],
#'    [-21.93901, 64.135924],
#'    [-21.927337, 64.136673]
#' ]'
#' along(linestring(pts), 1, 'miles')
#' @examples \dontrun{
#' along(line, 1, 'miles') %>% view
#' res <- along(line, 1, 'miles')
#' featurecollection(list(linestring(line), res)) %>% view
#' }
along <- function(line, distance, units, lint = FALSE) {
  line <- convert(line)
  lawnlint(line, lint)
  ct$eval(sprintf("var alg = turf.along(%s, %s, '%s');", line, distance, units))
  structure(ct$get("alg"), class = "point")
}
