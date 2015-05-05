#' Tag
#'
#' @export
#' @param points Input \code{\link{data-Point}}
#' @param polygons Input \code{\link{data-Polygon}} or \code{\link{data-MultiPolygon}}
#' @param polyId property in polygons to add to joined Point features
#' @param containingPolyId property in points in which to store joined
#' property from polygons
#' @template lint
#' @return points with containingPolyId property containing values from polyId
#' @details Takes a set of points and a set of polygons and performs a spatial join
#' @examples
#' pts <- lawn_random(n = 30)
#' polys <- lawn_triangle_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 30, 'miles')
#' lawn_tag(pts, polys, 'fill', 'marker-color')
#' @examples \dontrun{
#' lawn_tag(pts, polys, 'fill', 'marker-color') %>% view
#' }
lawn_tag <- function(points, polygons, polyId, containingPolyId, lint = FALSE) {
  points <- convert(points)
  polygons <- convert(polygons)
  lawnlint(list(points, polygons), lint)
  ct$eval(sprintf("var tag = turf.tag(%s, %s, '%s', '%s');",
                  points, polygons, polyId, containingPolyId))
  ct$get("tag")
}
