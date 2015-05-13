#' Create a FeatureCollection
#'
#' @export
#' @param features Input features, can be json as json or character class,
#' or a point, polygon, linestring, or centroid class, or many of those
#' things in a list
#' @family data functions
#' @examples \dontrun{
#' # points
#' ## single point
#' pt <- lawn_point(c(-75.343, 39.984), properties = list(name = 'Location A'))
#' lawn_featurecollection(pt)
#'
#' ## many points in a list
#' features <- list(
#'    lawn_point(c(-75.343, 39.984), properties = list(name = 'Location A')),
#'    lawn_point(c(-75.833, 39.284), properties = list(name = 'Location B')),
#'    lawn_point(c(-75.534, 39.123), properties = list(name = 'Location C'))
#' )
#' lawn_featurecollection(features)
#'
#' # polygons
#' rings <- list(list(
#'    c(-2.275543, 53.464547),
#'    c(-2.275543, 53.489271),
#'    c(-2.215118, 53.489271),
#'    c(-2.215118, 53.464547),
#'    c(-2.275543, 53.464547)
#' ))
#' ## single polygon
#' lawn_featurecollection(lawn_polygon(rings))
#'
#' ## many polygons in a list
#' rings2 <- list(list(
#'    c(-2.775543, 54.464547),
#'    c(-2.775543, 54.489271),
#'    c(-2.245118, 54.489271),
#'    c(-2.245118, 54.464547),
#'    c(-2.775543, 54.464547)
#' ))
#' features <- list(
#'    lawn_polygon(rings, properties = list(name = 'poly1', population = 400)),
#'    lawn_polygon(rings2, properties = list(name = 'poly2', population = 5000))
#' )
#' lawn_featurecollection(features)
#'
#' # linestrings
#' pts1 <- list(
#'    c(-2.364416, 53.448203),
#'    c(-2.356176, 53.441316),
#'    c(-2.33901, 53.435924),
#'    c(-2.327337, 53.436673)
#' )
#' ## single linestring
#' lawn_featurecollection(lawn_linestring(pts1))
#'
#' ## many linestring's in a list
#' pts2 <- rapply(pts1, function(x) x+0.1, how = "list")
#' features <- list(
#'    lawn_linestring(pts1, properties = list(name = 'line1', distance = 145)),
#'    lawn_linestring(pts2, properties = list(name = 'line2', distance = 145))
#' )
#' lawn_featurecollection(features)
#'
#' # mixed feature set: polygon, linestring, and point
#' features <- list(
#'    lawn_polygon(rings, properties = list(name = 'poly1', population = 400)),
#'    lawn_linestring(pts1, properties = list(name = 'line1', distance = 145)),
#'    lawn_point(c(-2.25, 53.479271), properties = list(name = 'Location A'))
#' )
#' lawn_featurecollection(features)
#'
#' # Return self if a featurecollection class passed
#' res <- lawn_featurecollection(features)
#' lawn_featurecollection(res)
#'
#' # json featurecollection passed in
#' library("jsonlite")
#' str <- toJSON(unclass(res))
#' lawn_featurecollection(str)
#'
#' # from a centroid object
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
#' cent <- lawn_centroid(poly)
#' lawn_featurecollection(cent)
#'
#' # From a geo_list object from geojsonio package
#' # library("geojsonio")
#' # vecs <- list(c(100.0,0.0), c(101.0,0.0), c(101.0,1.0), c(100.0,1.0), c(100.0,0.0))
#' # x <- geojson_list(vecs, geometry="polygon")
#' # lawn_featurecollection(x)
#' }
lawn_featurecollection <- function(features) {
  UseMethod("lawn_featurecollection")
}

# from a list, could be many different things in the list ----
#' @export
lawn_featurecollection.list <- function(features) {
  if (!is.null(names(features))) {
    lawn_featurecollection(jsonlite::toJSON(features))
  } else {
    do_fc(lapply(features, function(z){
      if (is(z, "character")) {
        lawn_featurecollection(z)
      } else if (is(z, "featurecollection")) {
        type <- tolower(z$features$geometry$type)
        switch(type,
               polygon = lawn_polygon(z$features$geometry$coordinates[[1]]),
               point = lawn_point(z$features$geometry$coordinates[[1]]),
               linestring = lawn_linestring(z$features$geometry$coordinates[[1]]))
      } else {
        z
      }
    }))
  }
}

# geometries ------------------------------------
#' @export
lawn_featurecollection.point <- function(features) {
  do_fc(list(features))
}

#' @export
lawn_featurecollection.polygon <- function(features) {
  do_fc(list(features))
}

#' @export
lawn_featurecollection.linestring <- function(features) {
  do_fc(list(features))
}

# centroid - to easily make a featurecollection out of a centroid obj --------
#' @export
lawn_featurecollection.centroid <- function(features) {
  do_fc(list(features))
}

# character: main use case here is for json as character class --------
#' @export
lawn_featurecollection.character <- function(features) {
  res <- tryCatch(jsonlite::fromJSON(features), error = function(e) e)
  if (!is(res, "simpleError")) {
    if (res$type == "FeatureCollection") {
      structure(res, class = "featurecollection")
    } else {
      structure(res, class = tolower(res$geometry$type))
      # stop("'type' must be FeatureCollection", call. = FALSE)
    }
  } else {
    stop("character input must be JSON", call. = FALSE)
  }
}

# json: if json class passed (as defined in jsonlite pkg) -------------
#' @export
lawn_featurecollection.json <- function(features) {
  res <- jsonlite::fromJSON(features)
  if (res$type == "FeatureCollection") {
    structure(res, class = "featurecollection")
  } else {
    stop("'type' must be FeatureCollection", call. = FALSE)
  }
}

# geo_list - from geojsonio -----------------------
#' @export
lawn_featurecollection.geo_list <- function(features) {
  lawn_featurecollection(unclass(features))
}

# self - return a featurecollection -----------------------
#' @export
lawn_featurecollection.featurecollection <- function(features) {
  features
}

do_fc <- function(features) {
  fts <- unlist(sapply(features, as.turf))
  ct$eval(sprintf("var features = %s;", sprintf("[ %s ]", paste0(fts, collapse = ", "))))
  ct$eval("var feet = turf.featurecollection(features);")
  as.fc(ct$get("feet"))
}
