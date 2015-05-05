#' Calculate the area of a polygon or group of polygons
#'
#' @export
#'
#' @param input A feature or featurecollection of polygons.
#' @template lint
#' @family measurements
#' @return value in square meters
#' @examples
#' lawn_area(lawn_data$poly)
#' lawn_area(lawn_data$multipoly)
lawn_area <- function(input, lint = FALSE) {
  input <- convert(input)
  lawnlint(input, lint)
  ct$eval(sprintf("var area = turf.area(%s);", input))
  ct$get("area")
}
