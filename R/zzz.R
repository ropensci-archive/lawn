#' @importFrom jsonlite toJSON
convert <- function(x) {
  if (is.character(x)) {
    x
  } else {
    jsonlite::toJSON(unclass(x), auto_unbox = TRUE)
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
lintit <- function(x) {
  ht$eval(sprintf("var out = geojsonhint.hint('%s');", jsonlite::minify(x)))
  tmp <- as.list(ht$get("out"))
  if (identical(tmp, list())) {
    return(TRUE)
  } else {
    stop("Line ", tmp$line, " - ", tmp$message, call. = FALSE)
  }
}
