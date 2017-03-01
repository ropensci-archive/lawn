#' Create a multipolygon
#'
#' @export
#' @param coordinates A list of LinearRings, or in json.
#' @param properties A list of properties.
#' @family data functions
#' @return A [data-MultiPolygon] feature.
#' @examples
#' rings <- list(
#'   list(list(
#'    c(-2.27, 53.46),
#'    c(-2.27, 53.48),
#'    c(-2.21, 53.48),
#'    c(-2.21, 53.46),
#'    c(-2.27, 53.46)
#'   )),
#'   list(list(
#'    c(-4.27, 55.46),
#'    c(-4.27, 55.48),
#'    c(-4.21, 55.48),
#'    c(-4.21, 55.46),
#'    c(-4.27, 55.46)
#'   ))
#' )
#' lawn_multipolygon(rings)
#' lawn_multipolygon(rings, properties = list(name = 'poly1', population = 400))
#'
#' x <- '[
#'   [[[102.0, 2.0], [103.0, 2.0], [103.0, 3.0], [102.0, 3.0], [102.0, 2.0]]],
#'   [[[100.0, 0.0], [101.0, 0.0], [101.0, 1.0], [100.0, 1.0], [100.0, 0.0]],
#'   [[100.2, 0.2], [100.8, 0.2], [100.8, 0.8], [100.2, 0.8], [100.2, 0.2]]]
#' ]'
#' lawn_multipolygon(x)
#'
#' lawn_multipolygon("[[[[0,0],[0,10],[10,10],[10,0],[0,0]]]]")
#'
#' # Make a FeatureCollection
#' lawn_featurecollection(lawn_multipolygon(rings))
#'
#' @examples \dontrun{
#' lawn_featurecollection(lawn_multipolygon(rings)) %>% view
#' }
lawn_multipolygon <- function(coordinates, properties = NULL) {
  ct$eval(sprintf("var mpoly = turf.multiPolygon(%s, %s);",
                  convert(coordinates), toj(properties)))
  as.mpol(ct$get("mpoly"))
}
