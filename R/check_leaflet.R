# check for leaflet
check4leaflet <- function() {
  if (!requireNamespace("leaflet", quietly = TRUE)) {
    stop("Please install leaflet", call. = FALSE)
  } else {
    invisible(TRUE)
  }
}
