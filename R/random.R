#' Generate random data
#'
#' Generates random \code{\link{data-GeoJSON}} data, including \code{\link{data-Point}}'s
#' and \code{\link{data-Polygon}}'s, for testing and experimentation
#'
#' @export
#'
#' @param type type of features desired: 'points' or 'polygons'
#' @param n (integer) Number of features to generate
#' @param bbox A bounding box inside of which geometries are placed. In the case
#' of Point features, they are guaranteed to be within this bounds, while Polygon
#' features have their centroid within the bounds.
#' @param num_vertices	Number options.vertices the number of vertices added to
#' polygon features.
#' @param max_radial_length Number	<optional> 10	 the total number of decimal degrees
#' longitude or latitude that a polygon can extent outwards to from its center
#' @family data functions
#' @return A \code{\link{data-FeatureCollection}}
#'
#' @examples
#' ## set of points
#' lawn_random(n = 2)
#' lawn_random(n = 10)
#' ## set of polygons
#' lawn_random('polygons', 2)
#' lawn_random('polygons', 10)
#' # with options
#' lawn_random(bbox = c(-70, 40, -60, 60))
#' lawn_random(num_vertices = 5)
lawn_random <- function(type = "points", n = 10, bbox = NULL,
                        num_vertices = NULL, max_radial_length = NULL) {

  jj <- jsonlite::toJSON(cmp(list(bbox = bbox, num_vertices = num_vertices,
                                  max_radial_length = max_radial_length)))
  ct$eval(sprintf("var rnd = turf.random('%s', %s, %s);", type, n, jj))
  as.fc(ct$get("rnd"))
}
