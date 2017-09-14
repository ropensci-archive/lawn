#' Boolean crosses
#'
#' @export
#' @param feature1,feature2 any [data-Geometry]/[data-Feature] objects
#' @family boolean functions
#' @return a logical (`TRUE`/`FALSE`)
#' @examples
#' pt1 <- '[2, 2]'
#' l1 <- '[[1, 1], [1, 2], [1, 3], [1, 4]]'
#' lawn_boolean_disjoint(lawn_point(pt1), lawn_linestring(l1))
lawn_boolean_disjoint <- function(feature1, feature2, lint = FALSE) {
  lawnlint(list(feature1, feature2), lint)
  ct$eval(sprintf("var bdj = turf.booleanDisjoint(%s, %s);",
                  convert(feature1), convert(feature2)))
  ct$get("bdj")
}
