#' @importFrom V8 new_context
ct <- NULL
rand <- NULL
.onLoad <- function(libname, pkgname){
  ct <<- new_context();
  ct$source(system.file("js/turf.js", package = pkgname))

  rand <<- new_context();
  rand$source(system.file("js/geojson_random.js", package = pkgname))
}
