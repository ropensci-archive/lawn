#' Count number of points within polygons
#'
#' Calculates the number of [data-Point]'s that fall within the set
#' of [data-Polygon]'s
#'
#' @export
#'
#' @template math
#' @template lint
#' @family aggregations
#' @return a [data-FeatureCollection]
#' @examples \dontrun{
#' # using data in the package
#' cat(lawn_data$points_count)
#' cat(lawn_data$polygons_count)
#' lawn_count(lawn_data$polygons_count, lawn_data$points_count, 'population')
#' }
lawn_count <- function(polygons, points, in_field, out_field = 'count',
                       lint = FALSE) {

  lawnlint(list(polygons, points), lint)
  is_type(polygons, "FeatureCollection", "Polygon")
  is_type(points, "FeatureCollection", "Point")
  ct$eval(sprintf("var fc = turf.collect(%s, %s, '%s', 'values');",
                  convert(polygons), convert(points), in_field))
  ct$eval(sprintf("fc.features.forEach(function (feature) {
    feature.properties.%s = feature.properties.values.length;
  });", out_field))
  as.fc(ct$get("fc"))
}
