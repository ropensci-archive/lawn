#' Create a linestring
#'
#' @export
#' @param coordinates A list of Positions
#' @param properties A list of properties
#' @examples
#' pts <- list(
#'    c(-21.964416, 64.148203),
#'    c(-21.956176, 64.141316),
#'    c(-21.93901, 64.135924),
#'    c(-21.927337, 64.136673)
#' )
#' linestring(pts, properties = list(name = 'line1', distance = 145))
#'
#' # completely non-sensical, but gets some data quickly
#' pts <- random()$features$geometry$coordinates
#' linestring(pts)

linestring <- function(coordinates, properties = NULL) {
  ct$eval(sprintf("var poly = turf.linestring(%s, %s);", toj(coordinates), toj(properties)))
  ct$get("poly")
}
