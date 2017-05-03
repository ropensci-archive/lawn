#' Return points that fall within polygons
#'
#' Takes a set of [data-Point]'s and a set of
#' [data-Polygon]'s and returns points that fall within
#' the polygons.
#'
#' @export
#' @param points [data-FeatureCollection] of points.
#' @param polygons [data-FeatureCollection] of polygons.
#' @template lint
#' @family joins
#' @return Points that land within at least one polygon, as a
#' [data-FeatureCollection].
#' @examples
#' cat(lawn_data$points_within)
#' cat(lawn_data$polygons_within)
#' lawn_within(lawn_data$points_within, lawn_data$polygons_within)
#'
#' pt <- '{
#'  "type": "Feature",
#'  "properties": {},
#'  "geometry": {
#'     "type": "Point",
#'     "coordinates": [-90.548630, 14.616599]
#'   }
#' }'
#' poly <- lawn_featurecollection(lawn_buffer(pt, 5))
#' pts <- lawn_featurecollection(lawn_point(c(-90.55, 14.62)))
#'
#' lawn_within(pts, poly)
lawn_within <- function(points, polygons, lint = FALSE) {
  points <- convert(points)
  polygons <- convert(polygons)
  is_type(points, type = "FeatureCollection")
  is_type(polygons, type = "FeatureCollection")
  lawnlint(list(points, polygons), lint)
  ct$eval(sprintf("var pts = turf.within(%s, %s);", points, polygons))
  as.fc(ct$get("pts"))
}
