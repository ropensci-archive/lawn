#' Boolean overlap
#'
#' @export
#' @param feature1,feature2 any [data-Geometry]/[data-Feature](
#' <[data-LineString]|[data-MultiLineString]|[data-Polygon]|[data-MultiPolygon])
#' objects
#' @family boolean functions
#' @return a logical (`TRUE`/`FALSE`)
#' @examples
#' poly1 <- "[[[0,0],[0,5],[5,5],[5,0],[0,0]]]"
#' poly2 <- "[[[1,1],[1,6],[6,6],[6,1],[1,1]]]"
#' poly3 <- "[[[10,10],[10,15],[15,15],[15,10],[10,10]]]"
#' lawn_boolean_overlap(lawn_polygon(poly1), lawn_polygon(poly2))
#' lawn_boolean_overlap(lawn_polygon(poly2), lawn_polygon(poly3))
lawn_boolean_overlap <- function(feature1, feature2, lint = FALSE) {
  lawnlint(list(feature1, feature2), lint)
  ct$eval(sprintf("var bover = turf.booleanOverlap(%s, %s);",
                  convert(feature1), convert(feature2)))
  ct$get("bover")
}
