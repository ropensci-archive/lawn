#' Get Jenks breaks
#'
#' Takes a set of \code{\link{data-Feature}}'s and returns an array of the Jenks
#' Natural breaks for a given property
#'
#' @export
#'
#' @param input Set of \code{\link{data-Feature}}'s
#' @param field the property in input on which to calculate Jenks natural breaks
#' @param numberOfBreaks Number of classes in which to group the data
#' @template lint
#' @family classification
#' @return An array of the break values (numeric)
#' @references Jenks Natural breaks
#' \url{http://en.wikipedia.org/wiki/Jenks_natural_breaks_optimization}
#' @examples \dontrun{
#' lawn_jenks(input = lawn_data$points_average, field = 'population', numberOfBreaks = 0)
#' lawn_jenks(lawn_data$points_average, 'population', 1)
#' lawn_jenks(lawn_data$points_average, 'population', 2)
#' lawn_jenks(lawn_data$points_average, 'population', 3)
#' lawn_jenks(lawn_data$points_average, 'population', 4)
#' }
lawn_jenks <- function(input, field, numberOfBreaks, lint = FALSE) {
  input <- convert(input)
  lawnlint(input, lint)
  # ct$eval('
  #   jenksy = function(x, y, z) {
  #
  #   }
  # ')
  ct$eval(sprintf("var jks = jenksy(%s, '%s', %s);", input, field, toj(numberOfBreaks)))
  ct$get("jks")
}
