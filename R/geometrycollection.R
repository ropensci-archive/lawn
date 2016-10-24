#' Create a geometrycollection
#'
#' @export
#' @param coordinates A list of GeoJSON geometries, or in json
#' @param properties A list of properties
#' @family data functions
#' @return a \code{\link{data-GeometryCollection}} feature
#' @examples
#' x <- list(
#'   list(
#'     type = "Point",
#'     coordinates = list(
#'      list(100, 0)
#'     )
#'   ),
#'   list(
#'     type = "LineString",
#'     coordinates = list(
#'      list(100, 0),
#'      list(102, 1)
#'     )
#'   )
#' )
#' lawn_geometrycollection(x)
#' lawn_geometrycollection(x,
#'   properties = list(city = 'Los Angeles', population = 400))
#'
#' x <- '[
#'    {
#'      "type": "Point",
#'      "coordinates": [100.0, 0.0]
#'    },
#'    {
#'      "type": "LineString",
#'      "coordinates": [ [101.0, 0.0], [102.0, 1.0] ]
#'    }
#' ]'
#' lawn_geometrycollection(x)
lawn_geometrycollection <- function(coordinates, properties = NULL) {
  ct$eval(sprintf("var geocoll = turf.geometryCollection(%s, %s);",
                  convert(coordinates), toj(properties)))
  as.gc(ct$get("geocoll"))
}
