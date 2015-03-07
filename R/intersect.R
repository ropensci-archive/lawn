#' Find the intersection of two polygons
#'
#' @export
#' @param poly1 A polygon
#' @param poly2 A polygon

#' @details Finds the interesection of two polygons and returns just the
#'          intersection of the two.  Polygons that do not intersect will return
#'          \code{NULL}.
#' @author Jeff Hollister \email{hollister.jeff@@epa.gov}
#' @examples
#'
#' poly1 <- '{
#' "type": "Feature",
#' "properties": {
#'   "fill": "#0f0"
#' },
#' "geometry": {
#'   "type": "Polygon",
#'   "coordinates": [[
#'     [-122.801742, 45.48565],
#'     [-122.801742, 45.60491],
#'     [-122.584762, 45.60491],
#'     [-122.584762, 45.48565],
#'     [-122.801742, 45.48565]
#'     ]]
#' }
#' }'
#'poly2 <- '{
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
#'}'
#' view(poly1)
#' view(poly2)
#' intersect(poly1,poly2) %>% view()
#'
#' x1 <- buffer(point(c(-122.64, 45.53)),1500,"meters")
#' x2 <- buffer(point(c(-122.645, 45.53)),1500,"meters")
#' intersect(x1,x2) %>% view()

intersect <- function(poly1, poly2) {
  poly1 <- convert(poly1)
  poly2 <- convert(poly2)
  ct$eval(sprintf("var poly1 = %s;", poly1))
  ct$eval(sprintf("var poly2 = %s;", poly2))
  ct$eval("var inter = turf.intersect(poly1, poly2);")
  ct$get("inter")
}
