#' Coerce to turf.js javascript function call
#'
#' @param x Input data to be coerced.
#' @param ... Ignored.
#' @export
#' @keywords internal
as.turf <- function(x, ...) {
  UseMethod("as.turf")
}

#' @export
as.turf.point <- function(x, ...) {
  fixq(sprintf("turf.point(%s, %s)", toj(x$geometry$coordinates), toj(x$properties, auto_unbox = TRUE)))
}

#' @export
as.turf.multipoint <- function(x, ...) {
  fixq(sprintf("turf.multiPoint(%s, %s)", toj(x$geometry$coordinates), toj(x$properties, auto_unbox = TRUE)))
}

#' @export
as.turf.centroid <- function(x, ...) {
  fixq(sprintf("turf.point(%s, %s)", toj(x$geometry$coordinates), toj(x$properties, auto_unbox = TRUE)))
}

#' @export
as.turf.polygon <- function(x, ...) {
  fixq(sprintf("turf.polygon(%s, %s)", toj(x$geometry$coordinates), toj(x$properties, auto_unbox = TRUE)))
}

#' @export
as.turf.multipolygon <- function(x, ...) {
  fixq(sprintf("turf.multiPolygon(%s, %s)", toj(x$geometry$coordinates), toj(x$properties, auto_unbox = TRUE)))
}

#' @export
as.turf.linestring <- function(x, ...) {
  fixq(sprintf("turf.lineString(%s, %s)", toj(x$geometry$coordinates), toj(x$properties, auto_unbox = TRUE)))
}

#' @export
as.turf.multilinestring <- function(x, ...) {
  fixq(sprintf("turf.multiLineString(%s, %s)", toj(x$geometry$coordinates), toj(x$properties, auto_unbox = TRUE)))
}

#' @export
as.turf.geometrycollection <- function(x, ...) {
  fixq(sprintf("turf.geometryCollection(%s, %s)", toj(x$geometry$coordinates), toj(x$properties, auto_unbox = TRUE)))
}

#' @export
as.turf.geo_list <- function(x, ...) {
  lapply(x$features, function(b) {
    fixq(sprintf("turf.%s(%s, %s)",
                 tolower(b$geometry$type),
                 toj(b$geometry$coordinates),
                 toj(b$properties, auto_unbox = TRUE)))
  })
}

fixq <- function(x) {
  gsub("\"", "'", x)
}
