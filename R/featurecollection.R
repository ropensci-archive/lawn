#' Create a FeatureCollection
#'
#' @export
#' @param features Input features
#' @examples \dontrun{
#' # points
#' features <- list(
#'    lawn_point(c(-75.343, 39.984), properties = list(name = 'Location A')),
#'    lawn_point(c(-75.833, 39.284), properties = list(name = 'Location B')),
#'    lawn_point(c(-75.534, 39.123), properties = list(name = 'Location C'))
#' )
#' lawn_featurecollection(features)
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
#'    lawn_polygon(rings, properties = list(name = 'poly1', population = 400)),
#'    lawn_polygon(rings2, properties = list(name = 'poly2', population = 5000))
#' )
#' lawn_featurecollection(features)
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
#'    lawn_linestring(pts1, properties = list(name = 'line1', distance = 145)),
#'    lawn_linestring(pts2, properties = list(name = 'line2', distance = 145))
#' )
#' lawn_featurecollection(features)
#'
#' # mixed feature set, polygon, linestring, and point
#' features <- list(
#'    lawn_polygon(rings, properties = list(name = 'poly1', population = 400)),
#'    lawn_linestring(pts1, properties = list(name = 'line1', distance = 145)),
#'    lawn_point(c(-2.25, 53.479271), properties = list(name = 'Location A'))
#' )
#' lawn_featurecollection(features)
#' }
lawn_featurecollection <- function(features) {
  UseMethod("featurecollection")
}

#' @export
lawn_featurecollection.character <- function(features) {
  res <- tryCatch(jsonlite::fromJSON(features), error = function(e) e)
  if (!is(res, "simpleError")) {
    if (res$type == "FeatureCollection") {
      structure(res, class = "featurecollection")
    }
  } else {
    stop("character input must be JSON", call. = FALSE)
  }
}

#' @export
lawn_featurecollection.list <- function(features) {
  do_fc(features)
}

#' @export
lawn_featurecollection.centroid <- function(features) {
  do_fc(list(features))
}

#' @export
lawn_featurecollection.point <- function(features) {
  do_fc(list(features))
}

#' @export
lawn_featurecollection.polygon <- function(features) {
  do_fc(list(features))
}

#' @export
lawn_featurecollection.linestring <- function(features) {
  do_fc(list(features))
}

# featurecollection.featurecollection <- function(features) {
#   do_fc(lapply(features, "[[", "features"))
# }

do_fc <- function(features) {
  fts <- sapply(features, as.turf)
  ct$eval(sprintf("var features = %s;", sprintf("[ %s ]", paste0(fts, collapse = ", "))))
  ct$eval("var feet = turf.featurecollection(features);")
  structure(ct$get("feet"), class = "featurecollection")
}
