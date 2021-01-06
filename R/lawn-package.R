#' R client for turf.js for geospatial analysis
#'
#' turf.js uses GeoJSON for all geographic data, and expects the data to be
#' standard WGS84 
#' longitude,latitude coordinates. See for a tool to
#' easily create GeoJSON in a browser.
#'
#' @seealso [lawn-defunct]
#'
#' @name lawn-package
#' @importFrom jsonlite fromJSON
#' @aliases lawn
#' @author Scott Chamberlain
#' @author Jeff Hollister (\email{hollister.jeff@@epa.gov})
#' @docType package
NULL

#' Data for use in examples
#'
#' @docType data
#' @keywords datasets
#' @format A list of character strings of points or polygons in FeatureCollection or Feature
#' Geojson formats.
#' @name lawn_data
#' @details The data objects included in the list, accessible by name
#' \itemize{
#'  \item filter_features - FeatureCollection of points
#'  \item points_average - FeatureCollection of points
#'  \item polygons_average - FeatureCollection of polygons
#'  \item points_count - FeatureCollection of points
#'  \item polygons_count - FeatureCollection of polygons
#'  \item points_within - FeatureCollection of points
#'  \item polygons_within - FeatureCollection of polygons
#'  \item poly - Feature of a single 1 degree by 1 degree polygon
#'  \item multipoly - FeatureCollection of two 1 degree by 1 degree polygons
#'  \item polygons_aggregate - FeatureCollection of Polygons from turf.js examples
#'  \item points_aggregate - FeatureCollection of Points from turf.js examples
#' }
NULL
