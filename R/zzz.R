#' @importFrom jsonlite toJSON
convert <- function(x) {
  if (is.character(x)) {
    x
  } else {
    jsonlite::toJSON(unclass(x), auto_unbox = TRUE, digits = 22)
  }
}

toj <- function(x, ...) jsonlite::toJSON(x, ...)

cmp <- function(l) Filter(Negate(is.null), l)

lawnlint <- function(x, lint = FALSE) {
  if (lint) {
    for (i in seq_along(x)) {
      lintit(x[[i]])
    }
  }
}

# helper fxns
## use geojsonhint to lint geojson input
lintit <- function(z) {
  ht$eval(sprintf("var out = geojsonhint.hint('%s');", jsonlite::minify(z)))
  tmp_ <- ht$get("out")
  tmp <- if (inherits(tmp_, "data.frame")) {
    paste0("\n", apply(tmp_, 1, function(w) {
      ww <- as.list(w)
      sprintf("Line %s - %s", ww['line'], ww['message'])
    }), collapse = " ")
  } else {
    tmp_
  }
  if (identical(tmp, list())) {
    return(TRUE)
  } else {
    stop(tmp, call. = FALSE)
  }
}

as.p <- function(x) structure(x, class = "point")
as.mp <- function(x) structure(x, class = "multipoint")
as.l <- function(x) structure(x, class = "linestring")
as.ml <- function(x) structure(x, class = "multilinestring")
as.pol <- function(x) structure(x, class = "polygon")
as.mpol <- function(x) structure(x, class = "multipolygon")
as.f <- function(x) structure(x, class = "feature")
as.fc <- function(x) structure(x, class = "featurecollection")
as.gc <- function(x) structure(x, class = "geometrycollection")

pluck <- function(x, name, type) {
  if (missing(type)) {
    lapply(x, "[[", name)
  } else {
    vapply(x, "[[", name, FUN.VALUE = type)
  }
}

calc_math <- function(op, py, pt, in_field, out_field) {
  ct$eval(sprintf("var fc = turf.collect(%s, %s, '%s', 'values');",
                  py, pt, in_field))
  ct$eval(sprintf("fc.features.forEach(function (feature) {
    feature.properties.%s = ss.%s(feature.properties.values);
  });", out_field, op))
  as.fc(ct$get("fc"))
}

`%||%` <- function(x, y) if (is.null(x)) y else x

assert <- function(x, y) {
  if (!is.null(x)) {
    if (!class(x) %in% y) {
      stop(deparse(substitute(x)), " must be of class ",
           paste0(y, collapse = ", "), call. = FALSE)
    }
  }
}
