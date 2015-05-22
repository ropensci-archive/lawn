#' Flip x,y to y,x, and vice versa
#'
#' @export
#' @param input Feature of features
#' @template lint
#' @return a \code{\link{data-Feature}} or \code{\link{data-FeatureCollection}}
#' @examples
#' # a point
#' serbia <- '{
#'   "type": "Feature",
#'   "properties": {"color": "red"},
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [20.566406, 43.421008]
#'    }
#' }'
#' lawn_flip(serbia)
#'
#' # a featurecollection
#' pts <- lawn_random("points")
#' lawn_flip(pts)
#' @examples \dontrun{
#' lawn_data$points_average %>% view
#' lawn_flip(lawn_data$points_average) %>% view
#' lawn_data$polygons_average %>% view
#' lawn_flip(lawn_data$polygons_average) %>% view
#' }
lawn_flip <- function(input, lint = FALSE) {
  input <- convert(input)
  lawnlint(input, lint)
  ct$eval(sprintf("var flp = turf.flip(%s);", input))
  structure(ct$get("flp"), class = tolower(ct$get("flp.type")))
}
