#' Spatial join of points and polygons
#'
#' Takes a set of \code{\link{data-Point}}'s and a set of
#' \code{\link{data-Polygon}}'s and performs a spatial join
#'
#' @export
#' @param points Input \code{\link{data-Point}}
#' @param polygons Input \code{\link{data-Polygon}} or \code{\link{data-MultiPolygon}}
#' @param poly_id property in polygons to add to joined Point features
#' @param containing_polyid property in points in which to store joined
#' property from polygons
#' @template lint
#' @family joins
#' @return points with containing_polyid property containing values from poly_id
#' @examples
#' pts <- lawn_random(n = 30)
#' polys <- lawn_triangle_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 30, 'miles')
#' polys$features$properties <-
#'    data.frame(fill = c("#f92", "295"), stroke = 1:2, `fill-opacity` = 2:3)
#' lawn_tag(pts, polys, 'fill', 'marker-color')
#' @examples \dontrun{
#' lawn_tag(pts, polys, 'fill', 'marker-color') %>% view
#' }
lawn_tag <- function(points, polygons, poly_id, containing_polyid, lint = FALSE) {
  points <- convert(points)
  polygons <- convert(polygons)
  lawnlint(list(points, polygons), lint)
  ct$eval(sprintf("var tag = turf.tag(%s, %s, '%s', '%s');",
                  points, polygons, poly_id, containing_polyid))
  as.fc(ct$get("tag"))
}
