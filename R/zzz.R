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

#' check for correct feature type
#'
#' @noRd
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
#' is_type(x, type = "Point")
#'
#' is_type(lawn_data$points_average, type = "")
is_type <- function(x, type) {
  ht$eval(sprintf("var keys = Object.keys(%s);", jsonlite::minify(x)))
  keys <- ht$get('keys')
  if ("geometry" %in% keys) {
    ht$eval(sprintf("var val = %s.geometry.type;", jsonlite::minify(x)))
    xtype <- ht$get('val')
  } else if ("features" %in% keys) {
    ht$eval(sprintf("var val = %s.type;", jsonlite::minify(x)))
    top <- ht$get('val')
    ht$eval(sprintf("var vals = %s.features.map(function(x) {return x.geometry.type});", jsonlite::minify(x)))
    lower <- ht$get('vals')
    xtype <- list(top = top, lower = lower)
  }

  if (xtype != type) stop(sprintf("input should be of type '%s'", type), call. = FALSE)
}

## use geojsonhint to lint geojson input
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
