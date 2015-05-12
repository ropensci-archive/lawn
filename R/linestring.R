#' Create a linestring
#'
#' @export
#' @param coordinates A list of Positions
#' @param properties A list of properties
#' @family data functions
#' @return a \code{\link{data-LineString}} feature
#' @examples
#' linestring1 <- '[
#'    [-21.964416, 64.148203],
#'    [-21.956176, 64.141316],
#'    [-21.93901, 64.135924],
#'    [-21.927337, 64.136673]
#' ]'
#' linestring2 <- '[
#'    [-21.929054, 64.127985],
#'    [-21.912918, 64.134726],
#'    [-21.916007, 64.141016],
#'    [-21.930084, 64.14446]
#' ]'
#' lawn_linestring(linestring1)
#' lawn_linestring(linestring2)
#'
#' pts <- list(
#'    c(-21.964416, 64.148203),
#'    c(-21.956176, 64.141316),
#'    c(-21.93901, 64.135924),
#'    c(-21.927337, 64.136673)
#' )
#' lawn_linestring(pts, properties = list(name = 'line1', distance = 145))
#'
#' # completely non-sensical, but gets some data quickly
#' pts <- lawn_random()$features$geometry$coordinates
#' lawn_linestring(pts)
lawn_linestring <- function(coordinates, properties = NULL) {
  # TODO: need to find way to fail well when unacceptable items passed in
  ct$eval(sprintf("var poly = turf.linestring(%s, %s);", convert(coordinates), toj(properties)))
  structure(ct$get("poly"), class = "linestring")
}
