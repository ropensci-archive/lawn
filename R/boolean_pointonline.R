#' Boolean overlap
#'
#' @export
#' @param point any [data-Geometry]/[data-Feature](<[data-Point]>)
#' @param linestring any [data-Geometry]/[data-Feature](<[data-LineString]>)
#' @param ignoreEndVertices (logical) whether to ignore the start and end
#' vertices. Default: `FALSE
#' @family boolean functions
#' @return a logical (`TRUE`/`FALSE`)
#' @examples
#' l1 <- "[[-1, -1],[1, 1],[1.5, 2.2]]"
#' lawn_boolean_pointonline(lawn_point("[0, 0]"), lawn_linestring(l1))
lawn_boolean_pointonline <- function(point, linestring,
                                     ignoreEndVertices = FALSE, lint = FALSE) {

  lawnlint(list(point, linestring), lint)
  ct$eval(sprintf("var bpol = turf.booleanPointOnLine(%s, %s, %s);",
                  convert(point), convert(linestring),
                  convert(ignoreEndVertices)))
  ct$get("bpol")
}
