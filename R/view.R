#' Visualize geojson
#'
#' @export
#' @param x Input, a geojson character string or list
#' @return Opens a map with the geojson object(s)
#' @examples \dontrun{
#' # from character string
#' view(lawn_data$polygons_average)
#' view(lawn_data$filter_features)
#' view(lawn_data$polygons_within)
#' view(lawn_data$polygons_count)
#'
#' # from a list
#' library("jsonlite")
#' mylist <- fromJSON(lawn_data$polygons_average, FALSE)
#' view(mylist)
#'
#' # from json (a jsonlite class)
#' x <- minify(lawn_data$points_count)
#' class(x)
#' view(x)
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
  make_view(toJSON(x, auto_unbox = TRUE, digits = 22))
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
