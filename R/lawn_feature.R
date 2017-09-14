#' Create a Feature
#'
#' @export
#' @param geometry (character/json) Any geojson geometry.
#' @param properties (list) list of properties, must be named
#' @template lint
#' @family data functions
#' @examples \dontrun{
#' # points
#' ## single point
#' pt <- '{"type":"Point","coordinates":[-75.343,39.984]}'
#' lawn_feature(pt)
#'
#' ## with properties
#' lawn_feature(pt, properties = list(foo = "bar"))
#'
#' ## many points in a list
#' pts <- list(
#'    lawn_point(c(-75.343, 39.984))$geometry,
#'    lawn_point(c(-75.833, 39.284))$geometry,
#'    lawn_point(c(-75.534, 39.123))$geometry
#' )
#' lapply(pts, lawn_feature)
#' }
lawn_feature <- function(geometry, properties = c(), lint = FALSE) {
  lawnlint(geometry, lint)
  ct$eval(sprintf("var feet = turf.feature(%s, %s);",
                  convert(geometry), convert(properties)))
  as.f(ct$get("feet"))
}
