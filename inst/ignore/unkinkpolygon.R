#' Unkink polygon
#'
#' Takes a kinked polygon and returns a feature collection of polygons
#' that have no kinks.
#'
#' @export
#' @param x A \code{\link{data-FeatureCollection}} of
#' \code{\link{data-Polygon}} or \code{\link{data-MultiPolygon}}
#' @template lint
#' @family grids
#' @return a \code{\link{data-FeatureCollection}} of \code{\link{data-Polygon}}
#' @examples
#' x <- '{
#'   'type': 'Feature',
#'   'geometry': {
#'     'type': 'Polygon',
#'       'coordinates': [[[0, 0], [2, 0], [0, 2], [2, 2], [0, 0]]]
#'    }
#' }'
#' lawn_unkinkpolygon(x)
lawn_unkinkpolygon <- function(x, lint = FALSE) {
  lawnlint(controlPoints, lint)
  ct$eval(sprintf('var out = turf.unkinkPolygon(%s);', x))
  as.fc(ct$get("out"))
}
