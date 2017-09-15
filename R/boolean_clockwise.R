#' Boolean clockwise
#'
#' @export
#' @param line line [data-Feature]<([data-LineString])>
#' @template lint
#' @family boolean functions
#' @return a logical (`TRUE`/`FALSE`)
#' @examples
#' l1 <- '[[0,0],[1,1],[1,0],[0,0]]'
#' l2 <- '[[0,0],[1,0],[1,1],[0,0]]'
#' lawn_boolean_clockwise(lawn_linestring(l1))
#' lawn_boolean_clockwise(lawn_linestring(l2))
lawn_boolean_clockwise <- function(line, lint = FALSE) {
  lawnlint(line, lint)
  ct$eval(sprintf("var bcw = turf.booleanClockwise(%s);", convert(line)))
  ct$get("bcw")
}
