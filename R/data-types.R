#' Description of GeoJSON data types
#'
#' @section GeoJSON object:
#'
#' GeoJSON always consists of a single object. This object (referred to as the
#' GeoJSON object below) represents a geometry, feature, or collection of features.
#' \itemize{
#'  \item The GeoJSON object may have any number of members (name/value pairs).
#'  \item The GeoJSON object must have a member with the name "type". This member's
#'  value is a string that determines the type of the GeoJSON object.
#'  \item The value of the type member must be one of: "Point", "MultiPoint", "LineString",
#'  "MultiLineString", "Polygon", "MultiPolygon", "GeometryCollection", "Feature", or
#'  "FeatureCollection". The case of the type member values must be as shown here.
#'  \item A GeoJSON object may have an optional "crs" member, the value of which must be
#'  a coordinate reference system object (see 3. Coordinate Reference System Objects).
#'  \item A GeoJSON object may have a "bbox" member, the value of which must be a bounding
#'  box array (see 4. Bounding Boxes).
#' }
#'
#' @section Point:
#'
#' For type "Point", the "coordinates" member must be a single position.
#'
#' Example JSON: \code{{ "type": "Point", "coordinates": [100.0, 0.0] }}
#'
#' In \code{lawn}: \code{lawn_point(c(1, 2))}
#'
#' See: \code{\link{lawn_point}}
#'
#' @section MultiPoint:
#'
#' For type "MultiPoint", the "coordinates" member must be an array of positions.
#'
#' Example JSON: \code{{ "type": "MultiPoint", "coordinates": [ [100.0, 0.0], [101.0, 1.0] ] }}
#'
#' Creation of multipoint in \code{lawn} coming soon
#'
#' @section Polygon:
#'
#' For type "Polygon", the "coordinates" member must be an array of LinearRing
#' coordinate arrays. For Polygons with multiple rings, the first must be the
#' exterior ring and any others must be interior rings or holes.
#'
#' Example JSON:
#' \code{{ "type": "Polygon", "coordinates": [
#'  [ [100.0, 0.0], [101.0, 0.0], [101.0, 1.0], [100.0, 1.0], [100.0, 0.0] ]] }}
#'
#' In \code{lawn}: \code{lawn_polygon(list(list(c(-2, 52), c(-3, 54), c(-2, 53), c(-2, 52))))}
#'
#' See: \code{\link{lawn_polygon}}
#'
#' @section MultiPolygon:
#'
#' For type "MultiPolygon", the "coordinates" member must be an array of
#' Polygon coordinate arrays.
#'
#' Example JSON:
#' \code{{ "type": "MultiPolygon", "coordinates": [
#'   [[[102.0, 2.0], [103.0, 2.0], [103.0, 3.0], [102.0, 3.0], [102.0, 2.0]]],
#'   [[[100.0, 0.0], [101.0, 0.0], [101.0, 1.0], [100.0, 1.0], [100.0, 0.0]],
#'   [[100.2, 0.2], [100.8, 0.2], [100.8, 0.8], [100.2, 0.8], [100.2, 0.2]]]
#'   ]
#' }}
#'
#' Creation of multipolygon in \code{lawn} coming soon
#'
#' @section LineString:
#'
#' For type "LineString", the "coordinates" member must be an array of two or more
#' positions. A LinearRing is closed LineString with 4 or more positions. The first
#' and last positions are equivalent (they represent equivalent points). Though a
#' LinearRing is not explicitly represented as a GeoJSON geometry type, it is
#' referred to in the Polygon geometry type definition.
#'
#' Example JSON:
#' \code{{ "type": "LineString", "coordinates": [ [100.0, 0.0], [101.0, 1.0] ] }}
#'
#' In \code{lawn}: \code{lawn_linestring(list(c(-2, 52), c(-3, 54), c(-2, 53)))}
#'
#' See: \code{\link{lawn_linestring}}
#'
#' @section MultiLineString:
#'
#' For type "MultiLineString", the "coordinates" member must be an array of
#' LineString coordinate arrays.
#'
#' Example JSON:
#' \code{{
#'  "type": "MultiLineString",
#'  "coordinates": [
#'      [[ -105, 39 ], [ -105, 39 ]],
#'      [[ -105, 39 ], [ -105, 39 ]]
#'   ]
#' }}
#'
#' Creation of multilinestring in \code{lawn} coming soon
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
#' In \code{lawn}: \code{lawn_featurecollection(lawn_point(c(-75, 39)))}
#'
#' See: \code{\link{lawn_featurecollection}}
#'
#' @section GeometryCollection:
#'
#' Each element in the geometries array of a GeometryCollection is one of the geometry
#' objects described above.
#'
#' Example JSON:
#' \code{{
#'    "type": "GeometryCollection",
#'    "geometries": [ {
#'      "type": "Point",
#'      "coordinates": [100.0, 0.0]
#'    }, {
#'    "type": "LineString",
#'    "coordinates": [ [101.0, 0.0], [102.0, 1.0] ]
#'    }
#'  ]
#' }}
#'
#' Creation of geometrycollection in \code{lawn} coming soon
#'
#' @name data-types
#' @aliases data-Point data-MultiPoint data-Polygon data-MultiPolygon data-LineString
#' data-MultiLineString data-Feature data-FeatureCollection data-GeometryCollection
#' data-GeoJSON
NULL
