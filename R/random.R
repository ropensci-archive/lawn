#' Generate random data
#'
#' Generates random [data-GeoJSON] data, including [data-Point]'s
#' and [data-Polygon]'s, for testing and experimentation
#'
#' @export
#'
#' @param type Type of features desired: 'position', 'points', 'polygons',
#' or 'lines'
#' @param n (integer) Number of features to generate.
#' @param bbox A bounding box inside of which geometries are placed. In the
#' case of Point features, they are guaranteed to be within this bounds,
#' while Polygon features have their centroid within the bounds.
#' @param num_vertices (numeric) the number of vertices added to
#' polygon features. default: `10`
#' @param max_radial_length (numeric) The total number of decimal
#' degrees longitude or latitude that a polygon can extent outwards to
#' from its center. default: `10`
#' @param max_length (numeric) maximum number of decimal degrees that a
#' vertex can be from its predecessor. default: `0.0001`
#' @param max_rotation (numeric) maximum number of radians that a line
#' segment can turn from the previous segment. default: `pi/8`
#' @family data functions
#' @return A [data-FeatureCollection]
#'
#' @examples
#' ## a position
#' lawn_random("position")
#' ## set of points
#' lawn_random(n = 2)
#' lawn_random(n = 10)
#' ## set of polygons
#' lawn_random('polygons', 2)
#' lawn_random('polygons', 10)
#' ## set of lines
#' lawn_random('lines', 2)
#' lawn_random('lines', 10)
#' # with options
#' lawn_random(bbox = c(-70, 40, -60, 60))
#' lawn_random(num_vertices = 5)
lawn_random <- function(type = "points", n = 10, bbox = NULL,
  num_vertices = 10, max_radial_length = 10, max_length = 0.0001,
  max_rotation = pi/8) {

  assert(type, 'character')
  stopifnot(type %in% c("position", "points", "polygons", "lines"))
  assert(n, c('numeric', 'integer'))
  assert(bbox, c('numeric', 'integer'))
  assert(num_vertices, c('numeric', 'integer'))
  assert(max_radial_length, c('numeric', 'integer'))
  if (type=="position") {
    ct$eval(sprintf("var rnd = turf.randomPosition(%s);", bbox))
  }
  if (type=="points") {
    opts <- jsonlite::toJSON(cmp(list(bbox = bbox)), auto_unbox = TRUE)
    ct$eval(sprintf("var rnd = turf.randomPoint(%s, %s);", n, opts))
  }
  if (type=="polygons") {
    opts <- jsonlite::toJSON(cmp(list(bbox = bbox, num_vertices = num_vertices,
      max_radial_length = max_radial_length)), auto_unbox = TRUE)
    ct$eval(sprintf("var rnd = turf.randomPolygon(%s, %s);", n, opts))
  }
  if (type=="lines") {
    opts <- jsonlite::toJSON(cmp(list(bbox = bbox, num_vertices = num_vertices,
      max_length = max_length, max_rotation = max_rotation)),
      auto_unbox = TRUE)
    ct$eval(sprintf("var rnd = turf.randomLineString(%s, %s);", n, opts))
  }
  as.fc(ct$get("rnd"))
}
