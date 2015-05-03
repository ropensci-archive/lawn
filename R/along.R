#' Along
#'
#' @export
#' @param line input \code{\link{data-LineString}}
#' @param distance distance along the line
#' @param units	can be degrees, radians, miles (default), or kilometers
#' @template lint
#' @return \code{\link{data-Point}} distance units along the line
#' @details Takes a \code{\link{data-Linestring}} and returns a \code{\link{data-Point}}
#' at a specified distance along the line.
#' @examples
#' line <- '{
#' "type": "Feature",
#' "properties": {},
#' "geometry": {
#'   "type": "LineString",
#'   "coordinates": [
#'     [-77.031669, 38.878605],
#'     [-77.029609, 38.881946],
#'     [-77.020339, 38.884084],
#'     [-77.025661, 38.885821],
#'     [-77.021884, 38.889563],
#'     [-77.019824, 38.892368]
#'     ]
#' }
#' }'
#' along(line, 1, 'miles')
#' @examples \dontrun{
#' along(line, 1, 'miles') %>% view
#' res <- along(line, 1, 'miles')
#' featurecollection(list(linestring(line), res)) %>% view
#' }
along <- function(line, distance, units, lint = FALSE) {
  lawnlint(line, lint)
  ct$eval(sprintf("var alg = turf.along(%s, %s, '%s');", convert(line), distance, units))
  structure(ct$get("alg"), class = "point")
}
