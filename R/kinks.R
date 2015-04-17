#' Kinks
#'
#' Takes a polygon and returns points at all self-intersections
#'
#' @export
#' @param input Feature of features
#' @template lint
#' @examples
#' poly <- '{
#'  "type": "Feature",
#'  "properties": {},
#'  "geometry": {
#'    "type": "Polygon",
#'    "coordinates": [[
#'      [-12.034835, 8.901183],
#'      [-12.060413, 8.899826],
#'      [-12.03638, 8.873199],
#'      [-12.059383, 8.871418],
#'      [-12.034835, 8.901183]
#'     ]]
#'   }
#' }'
#' kinks(poly)
#' # lint input object
#' kinks(poly, TRUE)
#' @examples \dontrun{
#' poly %>% view
#' kinks(poly)$intersections %>% view
#' }

kinks <- function(input, lint = FALSE) {
  lawnlint(input, lint)
  ct$eval(sprintf("var exp = turf.kinks(%s);", convert(input)))
  ct$get("exp")
}
