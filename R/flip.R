#' Flip x,y to y,x, and vice versa
#'
#' @export
#' @param input Feature of features
#' @template lint
#' @examples
#' serbia <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [20.566406, 43.421008]
#'    }
#' }'
#' lawn_flip(serbia)
#' @examples \dontrun{
#' lawn_data$points_average %>% view
#' lawn_flip(lawn_data$points_average) %>% view
#' lawn_data$polygons_average %>% view
#' lawn_flip(lawn_data$polygons_average) %>% view
#' }
lawn_flip <- function(input, lint = FALSE) {
  lawnlint(input, lint)
  ct$eval(sprintf("var flp = turf.flip(%s);", convert(input)))
  ct$get("flp")
}
