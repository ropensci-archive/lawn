#' Calculate the area of a polygon or group of polygons
#'
#' @export
#'
#' @param input A feature or feature collection of polygons.
#' @template lint
#'
#' @details Calculates the total area of a polygon or group of polygons. Returns
#'          the values in square meters.
#' @examples
#' lawn_area(lawn_data$poly)
#' lawn_area(lawn_data$multipoly)
lawn_area <- function(input, lint = FALSE) {
  input <- convert(input)
  lawnlint(input, lint)
  ct$eval(sprintf("var area = turf.area(%s);", input))
  ct$get("area")
}
