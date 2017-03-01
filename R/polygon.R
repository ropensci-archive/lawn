#' Create a polygon
#'
#' @export
#' @param coordinates A list of LinearRings, or in json.
#' @param properties A list of properties.
#' @family data functions
#' @return A [data-Polygon] feature.
#' @examples
#' rings <- list(list(
#'    c(-2.275543, 53.464547),
#'    c(-2.275543, 53.489271),
#'    c(-2.215118, 53.489271),
#'    c(-2.215118, 53.464547),
#'    c(-2.275543, 53.464547)
#' ))
#' lawn_polygon(rings)
#' lawn_polygon(rings, properties = list(name = 'poly1', population = 400))
#'
#' # Make a FeatureCollection
#' lawn_featurecollection(lawn_polygon(rings))
#'
#' @examples \dontrun{
#' lawn_featurecollection(lawn_polygon(rings)) %>% view
#' }
lawn_polygon <- function(coordinates, properties = NULL) {
  ct$eval(sprintf("var poly = turf.polygon(%s, %s);",
                  convert(coordinates), toj(properties)))
  as.pol(ct$get("poly"))
}
