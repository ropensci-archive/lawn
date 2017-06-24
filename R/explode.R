#' Explode vertices to points
#'
#' Takes a feature or set of features and returns all positions as points
#'
#' @export
#' @param input [data-Feature] or [data-FeatureCollection]
#' @template lint
#' @return a [data-FeatureCollection] of points
#' @examples
#' poly <- '{
#'  "type": "Feature",
#'  "properties": {},
#'  "geometry": {
#'    "type": "Polygon",
#'    "coordinates": [[
#'      [177.434692, -17.77517],
#'      [177.402076, -17.779093],
#'      [177.38079, -17.803937],
#'      [177.40242, -17.826164],
#'      [177.438468, -17.824857],
#'      [177.454948, -17.796746],
#'      [177.434692, -17.77517]
#'     ]]
#'  }
#' }'
#' lawn_explode(poly)
#' @examples \dontrun{
#' lawn_data$polygons_average %>% view
#' lawn_explode(lawn_data$polygons_average) %>% view
#' lawn_data$polygons_within %>% view
#' lawn_explode(lawn_data$polygons_within) %>% view
#' }
lawn_explode <- function(input, lint = FALSE) {
  input <- convert(input)
  lawnlint(input, lint)
  is_type(input, type_top = c("Feature", "FeatureCollection"))
  ct$eval(sprintf("var exp = turf.explode(%s);", input))
  as.fc(ct$get("exp"))
}
