#' Create a FeatureCollection
#'
#' @export
#' @param features Input features
#' @examples
#' # points
#' features <- list(
#'    point(c(-75.343, 39.984), properties = list(name = 'Location A')),
#'    point(c(-75.833, 39.284), properties = list(name = 'Location B')),
#'    point(c(-75.534, 39.123), properties = list(name = 'Location C'))
#' )
#' featurecollection(features)
#'
#' # polygons
#' rings <- list(list(
#'    c(-2.275543, 53.464547),
#'    c(-2.275543, 53.489271),
#'    c(-2.215118, 53.489271),
#'    c(-2.215118, 53.464547),
#'    c(-2.275543, 53.464547)
#' ))
#' rings2 <- list(list(
#'    c(-2.775543, 54.464547),
#'    c(-2.775543, 54.489271),
#'    c(-2.245118, 54.489271),
#'    c(-2.245118, 54.464547),
#'    c(-2.775543, 54.464547)
#' ))
#' features <- list(
#'    polygon(rings, properties = list(name = 'poly1', population = 400)),
#'    polygon(rings2, properties = list(name = 'poly2', population = 5000))
#' )
#' featurecollection(features)
#'
#' # linestrings
#' pts1 <- list(
#'    c(-2.364416, 53.448203),
#'    c(-2.356176, 53.441316),
#'    c(-2.33901, 53.435924),
#'    c(-2.327337, 53.436673)
#' )
#' pts2 <- rapply(pts1, function(x) x+0.1, how = "list")
#' features <- list(
#'    linestring(pts1, properties = list(name = 'line1', distance = 145)),
#'    linestring(pts2, properties = list(name = 'line2', distance = 145))
#' )
#' featurecollection(features) %>% view
#'
#' # mixed feature set, polygon, linestring, and point
#' features <- list(
#'    polygon(rings, properties = list(name = 'poly1', population = 400)),
#'    linestring(pts1, properties = list(name = 'line1', distance = 145)),
#'    point(c(-2.25, 53.479271), properties = list(name = 'Location A'))
#' )
#' featurecollection(features) %>% view

featurecollection <- function(features) {
  fts <- sapply(features, as.turf)
  ct$eval(sprintf("var features = %s;", sprintf("[ %s ]", paste0(fts, collapse = ", "))))
  ct$eval("var feet = turf.featurecollection(features);")
  ct$get("feet")
}

as.turf <- function(x, ...) {
  UseMethod("as.turf")
}

as.turf.point <- function(x, ...) {
  fixq(sprintf("turf.point(%s, %s)", toj(x$geometry$coordinates), toj(x$properties, auto_unbox = TRUE)))
}

as.turf.polygon <- function(x, ...) {
  fixq(sprintf("turf.polygon(%s, %s)", toj(x$geometry$coordinates), toj(x$properties, auto_unbox = TRUE)))
}

as.turf.linestring <- function(x, ...) {
  fixq(sprintf("turf.linestring(%s, %s)", toj(x$geometry$coordinates), toj(x$properties, auto_unbox = TRUE)))
}

fixq <- function(x) {
  gsub("\"", "'", x)
}
