#' Check for correct GeoJSON types
#'
#' @noRd
#' @details For lower type we only check the first one and assume the rest
#' are okay. Would be too time consuming to check all.
#' @examples
#' x <- '{
#'  "type": "Feature",
#'   "properties": {
#'     "fill": "#0f0"
#'   },
#'   "geometry": {
#'     "type": "Polygon",
#'     "coordinates": [[
#'       [-46.738586, -23.596711],
#'       [-46.738586, -23.458207],
#'       [-46.560058, -23.458207],
#'       [-46.560058, -23.596711],
#'       [-46.738586, -23.596711]
#'     ]]
#'   }
#' }'
#' is_type(x, type_top = "Feature", type_lower = "Polygon")
#'
#' x <- '{
#'   "geometry": {
#'     "type": "Polygon",
#'     "coordinates": [[
#'       [-46.738586, -23.596711],
#'       [-46.738586, -23.458207],
#'       [-46.560058, -23.458207],
#'       [-46.560058, -23.596711],
#'       [-46.738586, -23.596711]
#'     ]]
#' }}'
#' is_type(x, type_top = "Polygon")
#'
#' is_type(lawn_data$points_average, type_top = "FeatureCollection")
is_type <- function(x, type_top = NULL, type_lower = NULL) {
  ht$eval(sprintf("var keys = Object.keys(%s);", jsonlite::minify(x)))
  keys <- ht$get('keys')
  if ("geometry" %in% keys && length(keys) > 1) {
    ht$eval(sprintf("var val = %s.geometry.type;", jsonlite::minify(x)))
    lower <- ht$get('val')
    ht$eval(sprintf("var top = %s.type;", jsonlite::minify(x)))
    top <- ht$get('top')
  } else if ("features" %in% keys) {
    ht$eval(sprintf("var val = %s.type;", jsonlite::minify(x)))
    top <- ht$get('val')
    ht$eval(
      sprintf(
        "var vals = %s.features.map(function(x) {return x.geometry.type});",
        jsonlite::minify(x)))
    lower <- ht$get('vals')
  } else if ("geometry" %in% keys && length(keys) == 1) {
    ht$eval(sprintf("var val = %s.geometry.type;", jsonlite::minify(x)))
    top <- ht$get('val')
  } else {
    ht$eval(sprintf("var val = %s.type;", jsonlite::minify(x)))
    top <- ht$get('val')
  }

  if (!is.null(type_top)) {
    if (!top %in% type_top) {
      stop(
        sprintf("%s should be of type '%s'", deparse(substitute(x)),
                paste0(type_top, collapse = "', '")
        ), call. = FALSE)
    }
  }
  if (!is.null(type_lower)) {
    # `lower[1]` to only check first one
    if (!lower[1] %in% type_lower) {
      stop(
        sprintf("%s should be of type '%s'", deparse(substitute(x)),
                paste0(type_lower, collapse = "', '")
        ), call. = FALSE)
    }
  }
  return(TRUE)
}
