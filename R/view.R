#' Visualize geojson
#'
#' @export
#' @param x Input, a geojson character string or list
#' @param ... Any geojson object, as list, json, or point, polygon, etc. class
#' @return Opens a map with the geojson object(s)
#' @details \code{view_} is a special interface to \code{view} to accept arbitrary
#' input via \code{...}
#' @examples \dontrun{
#' # from character string
#' view(lawn_data$polygons_average)
#' view(lawn_data$filter_features)
#' view(lawn_data$polygons_within)
#' view(lawn_data$polygons_count)
#'
#' # from json (a jsonlite class)
#' x <- minify(lawn_data$points_count)
#' class(x)
#' view(x)
#'
#' # from a list (a single object)
#' library("jsonlite")
#' x <- fromJSON(lawn_data$polygons_average, FALSE)
#' view(x)
#'
#' # From a list of many objects
#' x <- list(
#'  lawn_point(c(-75.343, 39.984), properties = list(name = 'Location A')),
#'  lawn_point(c(-75.833, 39.284), properties = list(name = 'Location B')),
#'  lawn_point(c(-75.534, 39.123), properties = list(name = 'Location C'))
#' )
#' view(x)
#'
#' # Use view_ to pass in arbitrary objects that will be combined
#' view_(
#'  lawn_point(c(-75.343, 39.984), properties = list(name = 'Location A')),
#'  lawn_point(c(-75.833, 39.284), properties = list(name = 'Location B')),
#'  lawn_point(c(-75.534, 39.123), properties = list(name = 'Location C'))
#' )
#'
#' ## another eg, smile :)
#' l1 <- list(
#'    c(-69.9609375, 35.460669951495305),
#'    c(-78.75, 39.095962936305504),
#'    c(-87.1875, 39.36827914916011),
#'    c(-92.46093749999999, 36.03133177633189)
#' )
#' l2 <- list(
#'    c(-46.0546875, 8.7547947),
#'    c(-33.0468750, -0.7031074),
#'    c(-14.0625000, 0.0000000),
#'    c(-0.3515625,  9.4490618)
#' )
#' l3 <- list(
#'    c(-1.40625, 38.81152),
#'    c(14.76562, 45.33670),
#'    c(23.20312, 45.58329),
#'    c(33.04688, 39.63954)
#' )
#' view_(lawn_point(c(-30, 20)),
#'    lawn_linestring(l1),
#'    lawn_linestring(l2),
#'    lawn_linestring(l3)
#' )
#'
#' # From a geo_list object from geojsonio package
#' # library("geojsonio")
#' # vecs <- list(c(100.0,0.0), c(101.0,0.0), c(101.0,1.0), c(100.0,1.0), c(100.0,0.0))
#' # x <- geojson_list(vecs, geometry="polygon")
#' # view_(x)
#' # view_(x, lawn_point(c(101, 0)))
#' }
view <- function(x) {
  UseMethod("view")
}

#' @export
view.character <- function(x) {
  make_view(x)
}

#' @export
view.json <- function(x) {
  make_view(x)
}

#' @export
view.list <- function(x) {
  make_view_obj(lawn_featurecollection(x))
}

#' @export
view.json <- function(x) {
  make_view(x)
}

#' @export
view.geo_list <- function(x) {
  make_view(jsonlite::toJSON(unclass(x), auto_unbox = TRUE))
}

#' @export
view.point <- function(x) {
  make_view_obj(x)
}

#' @export
view.multipoint <- function(x) {
  make_view_obj(x)
}

#' @export
view.polygon <- function(x) {
  make_view_obj(x)
}

#' @export
view.linestring <- function(x) {
  make_view_obj(x)
}

#' @export
view.multilinestring <- function(x) {
  make_view_obj(x)
}

#' @export
view.featurecollection <- function(x) {
  make_view_obj(x)
}

make_view_obj <- function(x) {
  make_view(toJSON(unclass(x), auto_unbox = TRUE, digits = 22))
}

#' @export
#' @rdname view
view_ <- function(...) {
  tmp <- list(...)
  if (length(tmp) == 1) tmp <- tmp[[1]]
  view(tmp)
}

make_view <- function(x) {
  check4leaflet()
  b <- make_bounds(x)
  leaflet::leaflet() %>%
    leaflet::addTiles() %>%
    leaflet::addGeoJSON(jsonlite::fromJSON(x, FALSE)) %>%
    leaflet::fitBounds(lng1 = b$lng1, lat1 = b$lat1, lng2 = b$lng2, lat2 = b$lat2)
}

make_bounds <- function(z) {
  b <- as.list(setNames(lawn_extent(z), c("lng1", "lat1", "lng2", "lat2")))
  if (b$lng1 == b$lng2 || b$lat1 == b$lat2) {
    Map("+", b, c(-1, -1, 1, 1))
  } else {
    b
  }
}
