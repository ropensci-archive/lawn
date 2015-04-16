#' Flip x,y to y,x, and vice versa
#'
#' @export
#' @param input Feature of features
#' @param lint (logical) Lint or not. Uses geojsonhint. Takes up increasing time
#' as the object to get linted increases in size, so probably use by
#' default for small objects, but not for large if you know they are good geojson
#' objects. Default: FALSE
#' @examples
#' serbia <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [20.566406, 43.421008]
#'    }
#' }'
#' flip(serbia)
#' @examples \dontrun{
#' lawn_data$points_average %>% view
#' flip(lawn_data$points_average) %>% view
#' lawn_data$polygons_average %>% view
#' flip(lawn_data$polygons_average) %>% view
#' }

flip <- function(input, lint = FALSE) {
  lawnlint(input, lint)
  ct$eval(sprintf("var flp = turf.flip(%s);", convert(input)))
  ct$get("flp")
}
