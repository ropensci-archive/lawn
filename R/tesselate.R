#' Tesselate
#'
#' Tesselates a \code{\link{data-Polygon}} into a
#' \code{\link{data-FeatureCollection}} of
#' triangles using earcut (\url{https://github.com/mapbox/earcut})
#'
#' @export
#' @param polygon Input \code{\link{data-Polygon}} feature.
#' @template lint
#' @family assertions
#' @return A \code{\link{data-FeatureCollection}}.
#' @examples
#' poly <- '{
#'  "type": "Feature",
#'   "properties": {
#'     "fill": "#0f0"
#'   },
#'   "geometry": {
#'     "type": "Polygon",
#'     "coordinates": [[
#'       [-46.738586, -23.596711],
#'       [-46.738586, -23.458207],
#'       [-46.560058, -23.458207],
#'       [-46.560058, -23.596711],
#'       [-46.738586, -23.596711]
#'     ]]
#'   }
#' }'
#' lawn_tesselate(poly)
#'
#' xx <- jsonlite::fromJSON(lawn_data$polygons_within, FALSE)
#' lawn_tesselate(xx$features[[1]])
#' @examples \dontrun{
#' lawn_tesselate(xx$features[[1]]) %>% view
#' lawn_tesselate(poly) %>% view
#' }
lawn_tesselate <- function(polygon, lint = FALSE) {
  poly <- convert(polygon)
  lawnlint(poly, lint)
  ct$eval(sprintf("var er = turf.tesselate(%s);", poly))
  tmp <- ct$get("er")
  structure(tmp, class = tolower(tmp$type))
}
