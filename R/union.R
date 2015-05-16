#' Merge polygons
#'
#' Finds the interesection of two \code{\link{data-Polygon}}'s and returns the
#' union of the two
#'
#' @export
#' @param poly1 A polygon
#' @param poly2 A polygon
#' @template lint
#' @family transformations
#' @return a combined \code{\link{data-Polygon}} or
#' \code{\link{data-MultiPolygon}} feature
#'
#' @details Contiguous polygons are combined, non-contiguous polygons are returned
#' as MultiPolygon
#' @seealso \code{\link{lawn_merge}}
#' @author Jeff Hollister \email{hollister.jeff@@epa.gov}
#' @examples
#' poly1 <- '{
#'  "type": "Feature",
#'  "properties": {
#'    "fill": "#0f0"
#'  },
#'  "geometry": {
#'    "type": "Polygon",
#'    "coordinates": [[
#'      [-122.801742, 45.48565],
#'      [-122.801742, 45.60491],
#'      [-122.584762, 45.60491],
#'      [-122.584762, 45.48565],
#'      [-122.801742, 45.48565]
#'     ]]
#'  }
#' }'
#'
#' poly2 <- '{
#'  "type": "Feature",
#'  "properties": {
#'    "fill": "#00f"
#'  },
#'  "geometry": {
#'    "type": "Polygon",
#'    "coordinates": [[
#'      [-122.520217, 45.535693],
#'      [-122.64038, 45.553967],
#'      [-122.720031, 45.526554],
#'      [-122.669906, 45.507309],
#'      [-122.723464, 45.446643],
#'      [-122.532577, 45.408574],
#'      [-122.487258, 45.477466],
#'      [-122.520217, 45.535693]
#'      ]]
#'  }
#' }'
#' lawn_union(poly1, poly2)
#'
#' @examples \dontrun{
#' view(poly1)
#' view(poly2)
#' lawn_union(poly1, poly2) %>% view()
#'
#' x1 <- lawn_buffer(lawn_point(c(-122.6375, 45.53)), 1500, "meters")
#' x2 <- lawn_buffer(lawn_point(c(-122.6475, 45.53)), 1500, "meters")
#' lawn_union(x1, x2)
#' view(x1)
#' view(x2)
#' lawn_union(x1, x2) %>% view()
#' }
lawn_union <- function(poly1, poly2, lint = FALSE) {
  poly1 <- unclass(as_feature(poly1))
  poly2 <- unclass(as_feature(poly2))
  poly1 <- convert(poly1)
  poly2 <- convert(poly2)
  lawnlint(list(poly1, poly2), lint)
  ct$eval(sprintf("var union = turf.union(%s, %s);", poly1, poly2))
  tmp <- ct$get("union")
  structure(tmp, class = tolower(tmp$geometry$type))
}
