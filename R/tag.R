#' Spatial join of points and polygons
#'
#' Takes a set of \code{\link{data-Point}}'s and a set of
#' \code{\link{data-Polygon}}'s and performs a spatial join.
#'
#' @export
#' @param points Input \code{\link{data-Point}}.
#' @param polygons Input \code{\link{data-Polygon}} or
#' \code{\link{data-MultiPolygon}}.
#' @param field Property in polygons to add to joined Point features.
#' @param out_field Property in points in which to store joined
#' property from polygons.
#' @template lint
#' @family joins
#' @return Points with containing_polyid property containing values from poly_id.
#' @examples
#' bbox <- c(0, 0, 10, 10)
#' pts <- lawn_random(n = 30, bbox = bbox)
#' polys <- lawn_triangle_grid(bbox, 50, 'miles')
#' polys$features$properties$fill <- "#f92"
#' polys$features$properties$stroke <- 0
#' polys$features$properties$`fill-opacity` <- 1
#' lawn_tag(pts, polys, 'fill', 'marker-color')
#' @examples \dontrun{
#' lawn_tag(pts, polys, 'fill', 'marker-color') %>% view
#' }
lawn_tag <- function(points, polygons, field, out_field, lint = FALSE) {
  points <- convert(points)
  polygons <- convert(polygons)
  lawnlint(list(points, polygons), lint)
  ct$eval(sprintf("var xx = turf.tag(%s, %s, '%s', '%s');",
                  points, polygons, field, out_field))
  as.fc(ct$get("xx"))
}
