#' Get a bounding box
#'
#' @export
#' @param input A Feature or FeatureCollection
#' @details Calculates the extent of all input features in a FeatureCollection,
#' and returns a bounding box. The returned bounding box is of the form
#' [west, south, east, north].
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
lawn_extent <- function(input) {
  ct$eval(sprintf("var bbox = turf.extent(%s);", input))
  ct$get("bbox")
}
