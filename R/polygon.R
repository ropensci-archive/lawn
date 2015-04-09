#' Create a polygon
#'
#' @export
#' @param rings A list of LinearRings
#' @param properties A list of properties
#' @examples
#' rings <- list(list(
#'    c(-2.275543, 53.464547),
#'    c(-2.275543, 53.489271),
#'    c(-2.215118, 53.489271),
#'    c(-2.215118, 53.464547),
#'    c(-2.275543, 53.464547)
#' ))
#' polygon(rings, properties = list(name = 'poly1', population = 400))

polygon <- function(rings, properties = NULL) {
  ct$eval(sprintf("var poly = turf.polygon(%s, %s);", toj(rings), toj(properties)))
  ct$get("poly")
}
