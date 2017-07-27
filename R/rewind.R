#' Rewind
#'
#' Rewind (Multi)LineString or (Multi)Polygon outer ring counterclockwise
#' and inner rings clockwise (Uses Shoelace Formula
#' (<https://en.wikipedia.org/wiki/Shoelace_formula>)).
#'
#' @export
#' @param x A [data-FeatureCollection] or [data-Feature] with
#' Polygon, MultiPolygon, LineString, or MultiLineString
#' @param reverse (logical) enable reverse winding. Default: `FALSE`
#' @param mutate (logical) allows GeoJSON input to be mutated (significant
#' performance increase if true) Default: `FALSE`
#' @template lint
#' @return A [data-FeatureCollection]
#'
#' @examples
#' x <- '{
#' "type": "Feature",
#' "properties": {},
#' "geometry": {
#'   "type": "Polygon",
#'   "coordinates": [
#'     [[121, -29], [138, -29], [138, -18], [121, -18], [121, -29]]
#'    ]
#'   }
#' }'
#' lawn_rewind(x, TRUE)
#' lawn_rewind(x, mutate = TRUE)
#' lawn_rewind(x, lint = TRUE)
lawn_rewind <- function(x, reverse = FALSE, mutate = FALSE, lint = FALSE) {
  if (!is.null(x)) lawnlint(x, lint)
  if (lint) is_type(x, type_top = c("FeatureCollection", "Feature"))
  ct$eval(sprintf("var res = turf.rewind(%s, %s, %s);", convert(x),
                  tolower(reverse), tolower(mutate)))
  as.fc(ct$get("res"))
}
