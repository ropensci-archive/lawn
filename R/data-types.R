#' Description of GeoJSON data types
#'
#' @section Point:
#'
#' For type "Point", the "coordinates" member must be a single position.
#'
#' An example: \code{{ "type": "Point", "coordinates": [100.0, 0.0] }}
#'
#' @section MultiPoint:
#'
#' For type "MultiPoint", the "coordinates" member must be an array of positions.
#'
#' An example: \code{{ "type": "MultiPoint", "coordinates": [ [100.0, 0.0], [101.0, 1.0] ] }}
#'
#' @section Polygon:
#'
#' For type "Polygon", the "coordinates" member must be an array of LinearRing
#' coordinate arrays. For Polygons with multiple rings, the first must be the
#' exterior ring and any others must be interior rings or holes.
#'
#' An example:
#' \code{{ "type": "Polygon", "coordinates": [
#'  [ [100.0, 0.0], [101.0, 0.0], [101.0, 1.0], [100.0, 1.0], [100.0, 0.0] ]] }}
#'
#' @section MultiPolygon:
#'
#' For type "MultiPolygon", the "coordinates" member must be an array of
#' Polygon coordinate arrays.
#'
#' An example:
#' \code{{ "type": "MultiPolygon", "coordinates": [
#'   [[[102.0, 2.0], [103.0, 2.0], [103.0, 3.0], [102.0, 3.0], [102.0, 2.0]]],
#'   [[[100.0, 0.0], [101.0, 0.0], [101.0, 1.0], [100.0, 1.0], [100.0, 0.0]],
#'   [[100.2, 0.2], [100.8, 0.2], [100.8, 0.8], [100.2, 0.8], [100.2, 0.2]]]
#'   ]
#' }}
#'
#' @section LineString:
#'
#' For type "LineString", the "coordinates" member must be an array of two or more
#' positions. A LinearRing is closed LineString with 4 or more positions. The first
#' and last positions are equivalent (they represent equivalent points). Though a
#' LinearRing is not explicitly represented as a GeoJSON geometry type, it is
#' referred to in the Polygon geometry type definition.
#'
#' An example:
#' \code{{ "type": "LineString", "coordinates": [ [100.0, 0.0], [101.0, 1.0] ] }}
#'
#' @section MultiLineString:
#'
#' For type "MultiLineString", the "coordinates" member must be an array of
#' LineString coordinate arrays.
#'
#' @section Feature:
#'
#' A GeoJSON object with the type "Feature" is a feature object:
#' \itemize{
#'  \item A feature object must have a member with the name "geometry". The value
#'  of the geometry member is a geometry object as defined above or a JSON null
#'  value.
#'  \item A feature object must have a member with the name "properties". The
#'  value of the properties member is an object (any JSON object or a JSON null
#'  value).
#'  \item If a feature has a commonly used identifier, that identifier should be
#'  included as a member of the feature object with the name "id".
#' }
#'
#' @section FeatureCollection:
#'
#' A GeoJSON object with the type "FeatureCollection" is a feature collection
#' object. An object of type "FeatureCollection" must have a member with the name
#' "features". The value corresponding to "features" is an array. Each element in
#' the array is a feature object as defined above.
#'
#' @section GeometryCollection:
#'
#' Each element in the geometries array of a GeometryCollection is one of the geometry
#' objects described above.
#'
#' An example:
#' \code{
#' { "type": "GeometryCollection", "geometries": [ { "type": "Point",
#' "coordinates": [100.0, 0.0] }, { "type": "LineString", "coordinates":
#' [ [101.0, 0.0], [102.0, 1.0] ] } ] }}
#'
#' @name data-types
#' @aliases data-Point data-MultiPoint data-Polygon data-MultiPolygon data-LineString
#' data-MultiLineString data-Feature data-FeatureCollection data-GeometryCollection
NULL
