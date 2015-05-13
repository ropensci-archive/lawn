#' Return a FeatureCollection with N number of features with random coordinates
#'
#' @export
#' @name georandom
#'
#' @param n (integer) Number of features to create. Default: 10 (points), 1 (polygons)
#' @param vertices (integer) Number coordinates each Polygon will contain.
#' Default: 10
#' @param max_radial_length (integer) Maximum number of decimal degrees latitude or
#' longitude that a vertex can reach out of the center of the Polygon. Default: 10
#' @param bbox (numeric) A bounding box of length 4, of the form west, south, east,
#' north order. By default, no bounding box is passed in.
#' @return A \code{\link{data-FeatureCollection}} for point and polygon, or numeric
#' vector for position.
#' @references \url{https://github.com/mapbox/geojson-random}
#' @details These functions create either random points, polygons, or positions (single
#' long/lat coordinate pairs).
#' @seealso \code{\link{lawn_random}}
#' @examples
#' # Random points
#' gr_point(5)
#' gr_point(10)
#' gr_point(1000)
#' ## with bounding box
#' gr_point(5, c(50, 50, 60, 60))
#'
#' # Random positions
#' gr_position()
#' ## with bounding box
#' gr_position(c(0, 0, 10, 10))
#'
#' # Random polygons
#' ## number of polygons, default is 1 polygon
#' gr_polygon()
#' gr_polygon(5)
#' ## number of vertices, 3 vs. 100
#' gr_polygon(1, 3)
#' gr_polygon(1, 100)
#' ## max radial length, compare the following three
#' gr_polygon(1, 10, 5)
#' gr_polygon(1, 10, 30)
#' gr_polygon(1, 10, 100)
#' ## use a bounding box
#' gr_polygon(1, 5, 5, c(50, 50, 60, 60))

#' @export
#' @rdname georandom
gr_point <- function(n = 10, bbox = NULL) {
  stopifnot(is.numeric(n))
  if (is.null(bbox)) {
    rand$eval(sprintf("var pt = georandom.point(%s);", n))
  } else {
    check_bbox(bbox)
    rand$eval(sprintf("var pt = georandom.point(%s, %s);", n, jsonlite::toJSON(bbox)))
  }
  as.fc(rand$get("pt"))
}

#' @export
#' @rdname georandom
gr_position <- function(bbox = NULL) {
  if (is.null(bbox)) {
    rand$eval("var pos = georandom.position();")
  } else {
    check_bbox(bbox)
    rand$eval(sprintf("var pos = georandom.position(%s);", jsonlite::toJSON(bbox)))
  }
  rand$get("pos")
}

#' @export
#' @rdname georandom
gr_polygon <- function(n = 1, vertices = 10, max_radial_length = 10, bbox = NULL) {
  if (is.null(bbox)) {
    rand$eval(sprintf("var polys = georandom.polygon(%s, %s, %s);", n, vertices, max_radial_length))
  } else {
    check_bbox(bbox)
    rand$eval(sprintf("var polys = georandom.polygon(%s, %s, %s, %s);", n, vertices, max_radial_length, jsonlite::toJSON(bbox)))
  }
  as.fc(rand$get("polys"))
}

check_bbox <- function(w) {
  if (!is.numeric(w)) stop("bbox must be numeric", call. = FALSE)
  if (length(w) != 4) stop("bbox must be length 4", call. = FALSE)
}
