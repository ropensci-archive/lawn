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
