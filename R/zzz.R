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

# helper fxn
lintit <- function(z) {
  ht$eval(sprintf("var out = geojsonhint.hint('%s');", jsonlite::minify(z)))
  tmp_ <- ht$get("out")
  tmp <- if (is(tmp_, "data.frame")) {
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
    # stop("Line ", tmp$line, " - ", tmp$message, call. = FALSE)
  }
}

as.fc <- function(x) structure(x, class = "featurecollection")

pluck <- function(x, name, type) {
  if (missing(type)) {
    lapply(x, "[[", name)
  } else {
    vapply(x, "[[", name, FUN.VALUE = type)
  }
}
