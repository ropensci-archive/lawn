#' Intersection
#'
#' Finds the interesection of two [data-Polygon]'s and returns just
#' the intersection of the two
#'
#' @export
#' @param poly1 A [data-Polygon].
#' @param poly2 A [data-Polygon].
#' @template lint
#' @family transformations
#' @details Polygons with just a shared boundary will return the boundary.
#' Polygons that do not intersect will return `NULL`.
#' @return [data-Polygon], [data-MultiLineString], or undefined
#' @author Jeff Hollister \email{hollister.jeff@@epa.gov}
#' @examples
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
#' lawn_intersect(poly1, poly2)
#'
#' @examples \dontrun{
#' view(poly1)
#' view(poly2)
#' lawn_intersect(poly1, poly2) %>% view()
#'
#' x1 <- lawn_buffer(lawn_point(c(-122.6375, 45.53)), 1500, "meters")
#' x2 <- lawn_buffer(lawn_point(c(-122.6475, 45.53)), 1500, "meters")
#' lawn_intersect(x1, x2)
#' as.fc(x1) %>% view()
#' as.fc(x2) %>% view()
#' lawn_intersect(x1, x2) %>% view()
#'
#' # not overlapping
#' x3 <- lawn_buffer(lawn_point(c(-122.6375, 45.53)), 1500, "meters")
#' x4 <- lawn_buffer(lawn_point(c(-122.6975, 45.53)), 1500, "meters")
#' as.fc(x3) %>% view()
#' as.fc(x4) %>% view()
#' lawn_intersect(x3, x4) %>% view()
#' }
lawn_intersect <- function(poly1, poly2, lint = FALSE) {
  # This code has been contributed by Jeff Hollister, US EPA
  # Please read the following disclaimer:
  # \url{https://www.epa.gov/home/github-contribution-disclaimer}

  poly1 <- unclass(as_feature(poly1))
  poly2 <- unclass(as_feature(poly2))
  poly1 <- convert(poly1)
  poly2 <- convert(poly2)
  lawnlint(list(poly1, poly2), lint)
  ct$eval(sprintf("var inter = turf.intersect(%s, %s);", poly1, poly2))
  tmp <- ct$get("inter")
  structure(tmp, class = tolower(tmp$geometry$type))
}
