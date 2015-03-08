#' Find the union of two polygons
#'
#' @export
#' @param poly1 A polygon
#' @param poly2 A polygon
#'
#' @details Finds the interesection of two polygons and returns the
#'          union of the two.  Contiguous polygons are combined, non-contiguous
#'          polygons are returned as MultiPolygon.
#'          \code{NULL}.
#' @author Jeff Hollister \email{hollister.jeff@@epa.gov}
#' @examples
#' \dontrun{
#' poly1 <- '{
#'  "type": "Feature",
#'  "properties": {
#'    "fill": "#0f0"
#'  },
#'  "geometry": {
#'    "type": "Polygon",
#'    "coordinates": [[
#'      [-122.801742, 45.48565],
#'      [-122.801742, 45.60491],
#'      [-122.584762, 45.60491],
#'      [-122.584762, 45.48565],
#'      [-122.801742, 45.48565]
#'     ]]
#'  }
#' }'
#'
#' poly2 <- '{
#'  "type": "Feature",
#'  "properties": {
#'    "fill": "#00f"
#'  },
#'  "geometry": {
#'    "type": "Polygon",
#'    "coordinates": [[
#'      [-122.520217, 45.535693],
#'      [-122.64038, 45.553967],
#'      [-122.720031, 45.526554],
#'      [-122.669906, 45.507309],
#'      [-122.723464, 45.446643],
#'      [-122.532577, 45.408574],
#'      [-122.487258, 45.477466],
#'      [-122.520217, 45.535693]
#'      ]]
#'  }
#' }'
#' view(poly1)
#' view(poly2)
#' union(poly1, poly2) %>% view()
#'
#' x1 <- buffer(point(c(-122.6375, 45.53)), 1500, "meters")
#' x2 <- buffer(point(c(-122.6475, 45.53)), 1500, "meters")
#' view(x1)
#' view(x2)
#' union(x1,x2) %>% view()
#' }
union <- function(poly1, poly2) {
  poly1_1 <- convert(poly1)
  poly2_1 <- convert(poly2)
  if(is.list(poly1)){
    ct$eval(sprintf("var poly1 = %s;", poly1_1))
    ct$eval("poly1 = poly1.features[0]")
  } else {
    ct$eval(sprintf("var poly1 = %s;", poly1_1))
  }
  if(is.list(poly2)){
    ct$eval(sprintf("var poly2 = %s;", poly2_1))
    ct$eval("poly2 = poly2.features[0]")
  } else {
    ct$eval(sprintf("var poly2 = %s;", poly2))
  }
  ct$eval("var union = turf.union(poly1, poly2);")
  ct$get("union")
}
