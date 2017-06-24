#' Get a bounding box
#'
#' Calculates the extent of all input features in a FeatureCollection,
#' and returns a bounding box. The returned bounding box is of the form
#' (west, south, east, north).
#'
#' @export
#' @param input A [data-Feature] or [data-FeatureCollection]
#' @template lint
#' @family measurements
#' @return A bounding box, numeric vector of length 4, in
#' `[ minX, minY, maxX, maxY ]` order
#' @examples
#' # From a FeatureCollection
#' cat(lawn_data$points_average)
#' lawn_extent(lawn_data$points_average)
#'
#' # From a Feature
#' dat <- '{
#'  "type": "Feature",
#'  "properties": {},
#'  "geometry": {
#'      "type": "Polygon",
#'      "coordinates": [[
#'        [-112.072391,46.586591],
#'        [-112.072391,46.61761],
#'        [-112.028102,46.61761],
#'        [-112.028102,46.586591],
#'        [-112.072391,46.586591]
#'      ]]
#'    }
#' }'
#' lawn_extent(dat)
lawn_extent <- function(input, lint = FALSE) {
  input <- convert(input)
  lawnlint(input, lint)
  is_type(input, type_top = c("Feature", "FeatureCollection"))
  ct$eval(sprintf("var bbox = turf.bbox(%s);", input))
  ct$get("bbox")
}
