#' Reclass
#'
#' Takes a FeatureCollection, an input field, an output field, and an array of
#' translations and outputs an identical FeatureCollection with the output
#' field property populated
#'
#' @export
#'
#' @param input Set of input features
#' @param inField	the field to translate
#' @param outField the field in which to store translated results
#' @param translations an array of translations. Use nested lists instead of vectors
#' as combined numerics and characters will become all character strings when converted
#' to json
#' @return FeatureCollection a FeatureCollection with identical geometries to
#' input but with outField populated.
#' @examples
#' translations <- list(list(0, 200, "small"), list(200, 400, "medium"), list(400, 600, "large"))
#' reclass(lawn_data$points_average, 'population', 'size', translations)
reclass <- function(input, inField, outField, translations) {
  input <- convert(input)
  translations <- convert(translations)
  ct$eval(sprintf("var rc = turf.reclass(%s, '%s', '%s', %s);",
                  input, inField, outField, translations))
  ct$get("rc")
}
