#' Boolean crosses
#'
#' @export
#' @param feature1,feature2 any [data-Geometry]/[data-Feature] objects
#' @template lint
#' @family boolean functions
#' @return a logical (`TRUE`/`FALSE`)
#' @examples
#' l1 <- '[[-2, 2], [4, 2]]'
#' l2 <- '[[1, 1], [1, 2], [1, 3], [1, 4]]'
#' lawn_boolean_crosses(lawn_linestring(l1), lawn_linestring(l2))
lawn_boolean_crosses <- function(feature1, feature2, lint = FALSE) {
  lawnlint(list(feature1, feature2), lint)
  ct$eval(sprintf("var bcr = turf.booleanCrosses(%s, %s);",
                  convert(feature1), convert(feature2)))
  ct$get("bcr")
}
