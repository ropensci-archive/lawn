#' Visualize
#'
#' @import leaflet
#' @export
#' @examples \dontrun{
#' view(lawn_data$polygons_average)
#' view(lawn_data$filter_features)
#' view(lawn_data$polygons_within)
#' view(lawn_data$polygons_count)
#' }
view <- function(x) {
  b <- as.list(setNames(extent(x), c("lng1","lat1","lng2","lat2")))
  leaflet() %>%
    addTiles() %>%
    addGeoJSON(jsonlite::fromJSON(x, FALSE)) %>%
    fitBounds(lng1 = b$lng1, lat1 = b$lat1, lng2 = b$lng2, lat2 = b$lat2)
}
