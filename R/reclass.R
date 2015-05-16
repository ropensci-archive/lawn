#' Reclassify properties data
#'
#' Takes a \code{\link{data-FeatureCollection}}, an input field, an output field,
#' and an array of translations and outputs an identical FeatureCollection with
#' the output field property populated
#'
#' @export
#'
#' @param input Set of input features
#' @param inField	the field to translate
#' @param outField the field in which to store translated results
#' @param translations an array of translations. Use nested lists instead of vectors
#' as combined numerics and characters will become all character strings when converted
#' to json. Each list within the nested list of length 3, of the form
#' \code{<lower limit>, <upper limit>, <name for new grouping>}
#' @template lint
#' @family classification
#' @return a \code{\link{data-FeatureCollection}} with identical geometries to
#' input but with outField populated.
#' @examples
#' t1 <- list(list(0, 200, "small"), list(200, 400, "medium"), list(400, 600, "large"))
#' lawn_reclass(lawn_data$points_average, 'population', 'size', t1)
#' lawn_reclass(lawn_data$points_average, 'population', 'number', t1)
#'
#' t2 <- list(list(0, 150, "small"), list(150, 700, "big"))
#' lawn_reclass(lawn_data$points_average, 'population', 'size', t2)
lawn_reclass <- function(input, inField, outField, translations, lint = FALSE) {
  input <- convert(input)
  translations <- convert(translations)
  lawnlint(list(input, translations), lint)
  ct$eval(sprintf("var rc = turf.reclass(%s, '%s', '%s', %s);",
                  input, inField, outField, translations))
  as.fc(ct$get("rc"))
}
