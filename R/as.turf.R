#' Coerce to turf.js object
#'
#' @param x Input
#' @param ... Ignored
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
as.turf.centroid <- function(x, ...) {
  fixq(sprintf("turf.point(%s, %s)", toj(x$geometry$coordinates), toj(x$properties, auto_unbox = TRUE)))
}

#' @export
as.turf.polygon <- function(x, ...) {
  fixq(sprintf("turf.polygon(%s, %s)", toj(x$geometry$coordinates), toj(x$properties, auto_unbox = TRUE)))
}

#' @export
as.turf.linestring <- function(x, ...) {
  fixq(sprintf("turf.linestring(%s, %s)", toj(x$geometry$coordinates), toj(x$properties, auto_unbox = TRUE)))
}

fixq <- function(x) {
  gsub("\"", "'", x)
}
