#' @importFrom jsonlite toJSON
convert <- function(x) {
  if(is.character(x)) {
    x
  } else {
    jsonlite::toJSON(x, auto_unbox = TRUE)
  }
}

toj <- function(x, ...) jsonlite::toJSON(x, ...)
