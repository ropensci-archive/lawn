#' Visualize geojson from a character string or list
#'
#' @import leaflet
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
#' }
view <- function(x) {
  UseMethod("view")
}

#' @export
view.character <- function(x) {
  make_view(x)
}

#' @export
view.list <- function(x) {
  make_view(toJSON(x, auto_unbox = TRUE))
}

make_view <- function(x) {
  b <- as.list(setNames(extent(x), c("lng1","lat1","lng2","lat2")))
  leaflet() %>%
    addTiles() %>%
    addGeoJSON(jsonlite::fromJSON(x, FALSE)) %>%
    fitBounds(lng1 = b$lng1, lat1 = b$lat1, lng2 = b$lng2, lat2 = b$lat2)
}
