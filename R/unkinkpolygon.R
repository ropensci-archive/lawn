#' Unkink polygon
#'
#' Takes a kinked polygon and returns a feature collection of polygons
#' that have no kinks.
#'
#' @export
#' @param x A [data-FeatureCollection]<([data-Polygon])> or
#' [data-FeatureCollection]<([data-MultiPolygon])>
#' @template lint
#' @family grids
#' @return a [data-FeatureCollection]<([data-Polygon])>
#' @examples
#' x <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Polygon",
#'       "coordinates": [[[0, 0], [2, 0], [0, 2], [2, 2], [0, 0]]]
#'    }
#' }'
#' lawn_unkinkpolygon(x)
#' view(x)
#' view(lawn_unkinkpolygon(x))
lawn_unkinkpolygon <- function(x, lint = FALSE) {
  lawnlint(x, lint)
  if (lint) is_type(x, "FeatureCollection", c("Polygon", "MultiPolygon"))
  ct$eval(sprintf('var out = turf.unkinkPolygon(%s);', x))
  as.fc(ct$get("out"))
}
