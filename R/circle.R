#' circle
#'
#' Takes a \code{\link{data-Point}} and calculates the circle polygon given
#' a radius in degrees, radians, miles, or kilometers; and steps for precision
#'
#' @export
#' @param center The center \code{\link{data-Point}}
#' @param radius (integer) Radius of the circle.
#' @param steps (integer) Number of steps.
#' @param units (character) Miles, kilometers (default),
#' degrees, or radians.
#' @template lint
#' @family assertions
#' @return a \code{\link{data-Polygon}}
#' @examples
#' pt <- '{
#'   "type": "Feature",
#'   "properties": {
#'     "marker-color": "#0f0"
#'   },
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [-75.343, 39.984]
#'   }
#' }'
#'
#' lawn_circle(pt, radius = 5, steps = 10)
#' @examples \dontrun{
#' lawn_circle(pt, radius = 5, steps = 10) %>% view
#' lawn_circle(pt, radius = 4, steps = 10) %>% view
#' lawn_circle(pt, radius = 3, steps = 10) %>% view
#' lawn_circle(pt, radius = 10, steps = 10) %>% view
#' lawn_circle(pt, radius = 5, steps = 5) %>% view
#' lawn_circle(pt, radius = 5, steps = 4) %>% view
#' }
lawn_circle <- function(center, radius, steps = FALSE, units = "kilometers",
                        lint = FALSE) {
  lawnlint(center, lint)
  ct$eval(sprintf("var xx = turf.circle(%s, %s, %s, '%s');",
                  convert(center), radius, tolower(steps), units))
  structure(ct$get("xx"), class = "polygon")
}
