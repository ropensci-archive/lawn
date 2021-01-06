#' Center of mass
#'
#' Takes a [data-Feature] or a [data-FeatureCollection]
#' and returns its center of mass using formula
#' 
#'
#' @export
#' @param x a [data-Feature] or [data-FeatureCollection]
#' @template lint
#' @family measurements
#' @return a [data-Feature]<([data-Point])>
#' @examples
#' x <- '{
#'  "type": "Feature",
#'  "properties": {},
#'  "geometry": {
#'      "type": "Polygon",
#'      "coordinates": [[
#'        [-112.072391,46.586591],
#'        [-112.072391,46.61761],
#'        [-112.028102,46.61761],
#'        [-112.028102,46.586591],
#'        [-112.072391,46.586591]
#'      ]]
#'    }
#' }'
#' lawn_center_of_mass(x)
#'
#' lawn_center_of_mass(lawn_data$polygons_average)
lawn_center_of_mass <- function(x, lint = FALSE) {
  lawnlint(x, lint)
  if (lint) is_type(x, type_top = c("Feature", "FeatureCollection"))
  ct$eval(sprintf('var out = turf.centerOfMass(%s);', convert(x)))
  as.f(ct$get("out"))
}
