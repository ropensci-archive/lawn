#' @param lint (logical) Lint or not. Uses geojsonhint. Takes up increasing time
#' as the object to get linted increases in size, so probably use by
#' default for small objects, but not for large if you know they are good geojson
#' objects. Default: \code{FALSE}
