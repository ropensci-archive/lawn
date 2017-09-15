#' Boolean contains
#'
#' @export
#' @param feature1,feature2 any [data-Geometry]/[data-Feature] objects
#' @template lint
#' @family boolean functions
#' @return a logical (`TRUE`/`FALSE`)
#' @examples
#' l1 <- '[[1, 1], [1, 2], [1, 3], [1, 4]]'
#' pt1 <- '[1, 2]'
#' lawn_boolean_contains(feature1=lawn_linestring(l1), feature2=lawn_point(pt1))
lawn_boolean_contains <- function(feature1, feature2, lint = FALSE) {
  lawnlint(list(feature1, feature2), lint)
  ct$eval(sprintf("var bcon = turf.booleanContains(%s, %s);",
                  convert(feature1), convert(feature2)))
  ct$get("bcon")
}
