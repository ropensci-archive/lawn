#' Simplify GeoJSON data
#'
#' Takes a \code{\link{data-LineString}} or \code{\link{data-Polygon}}
#' and returns a simplified version
#'
#' @export
#' @param feature a \code{\link{data-LineString}} or \code{\link{data-Polygon}}
#' feature to be simplified
#' @param tolerance (numeric) Simplification tolerance
#' @param high_quality (boolean) Whether or not to spend more time to create a
#' higher-quality simplification with a different algorithm. Default: \code{FALSE}
#' @return a simplified feature
#' @template lint
#' @family transformations
#' @return A Feature of either \code{\link{data-Polygon}} or \code{\link{data-LineString}}
#' @details Internally uses simplify-js (\url{http://mourner.github.io/simplify-js/})
#' to perform simplification.
#'
#' @examples
#' feature <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Polygon",
#'     "coordinates": [[
#'       [-70.603637, -33.399918],
#'       [-70.614624, -33.395332],
#'       [-70.639343, -33.392466],
#'       [-70.659942, -33.394759],
#'       [-70.683975, -33.404504],
#'       [-70.697021, -33.419406],
#'       [-70.701141, -33.434306],
#'       [-70.700454, -33.446339],
#'       [-70.694274, -33.458369],
#'       [-70.682601, -33.465816],
#'       [-70.668869, -33.472117],
#'       [-70.646209, -33.473835],
#'       [-70.624923, -33.472117],
#'       [-70.609817, -33.468107],
#'       [-70.595397, -33.458369],
#'       [-70.587158, -33.442901],
#'       [-70.587158, -33.426283],
#'       [-70.590591, -33.414248],
#'       [-70.594711, -33.406224],
#'       [-70.603637, -33.399918]
#'     ]]
#'   }
#' }'
#'
#' lawn_simplify(feature, tolerance = 0.01)
#' @examples \dontrun{
#' lawn_simplify(feature, tolerance = 0.01) %>% view
#' }
lawn_simplify <- function(feature, tolerance = 0.01, high_quality = FALSE, lint = FALSE) {
  lawnlint(feature, lint)
  stopifnot(is.logical(high_quality))
  ct$eval(sprintf("var simp = turf.simplify(%s, %s, %s);", convert(feature), tolerance, tolower(high_quality)))
  structure(ct$get("simp"), class = tolower(ct$get("simp.geometry.type")))
}
