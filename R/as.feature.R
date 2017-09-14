#' Coerce character strings or JSON to GeoJSON Feature
#'
#' @export
#' @param x a character string or json class with a GeoJSON object, any
#' of feature, point, multipoint, linestring, multilinestring, polygon,
#' or multipolygon. featurecollection and geometrycollection simply returned
#' without alteration
#' @param ... ignored
#' @return a `feature` class object
#' @examples
#' poly <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Polygon",
#'     "coordinates": [[
#'       [105.818939,21.004714],
#'       [105.818939,21.061754],
#'       [105.890007,21.061754],
#'       [105.890007,21.004714],
#'       [105.818939,21.004714]
#'      ]]
#'   }
#' }'
#' as.feature(poly)
#'
#' pt <- '{"type":"Point","coordinates":[-75.343,39.984]}'
#' as.feature(pt)
#'
#' line <- '{
#'   "type": "LineString",
#'   "coordinates": [
#'     [-77.031669, 38.878605],
#'     [-77.029609, 38.881946],
#'     [-77.020339, 38.884084],
#'     [-77.025661, 38.885821],
#'     [-77.021884, 38.889563],
#'     [-77.019824, 38.892368]
#'     ]
#' }'
#' as.feature(line)
#'
#' # returns self if no match - note "Points" is not a GeoJSON type
#' pt <- '{"type":"Points","coordinates":[-75.343,39.984]}'
#' as.feature(pt)
as.feature <- function(x, ...) {
  UseMethod("as.feature")
}

#' @export
as.feature.character <- function(x, ...) {
  keys <- get_keys(x)
  if ("type" %in% keys) {
    typ <- tolower(get_type(x))
    if (typ == "feature") {
      return(lawn_feature(get_geometry(x), get_props(x)))
    } else if (typ %in% c("point", "multipoint", "linestring",
                          "multilinestring", "polygon", "multipolygon")) {
      return(lawn_feature(x))
    } else {
      return(x)
    }
  }
}

get_keys <- function(x) {
  ht$eval(sprintf("var keys = Object.keys(%s);", jsonlite::minify(x)))
  ht$get('keys')
}

get_type <- function(x) {
  ht$eval(sprintf("var xx = %s.type;", jsonlite::minify(x)))
  ht$get('xx')
}

get_geometry <- function(x) {
  ht$eval(sprintf("var geom = %s.geometry;", jsonlite::minify(x)))
  ht$get('geom')
}

get_props <- function(x) {
  ht$eval(sprintf("var props = %s.properties;", jsonlite::minify(x)))
  ht$get('props')
}
