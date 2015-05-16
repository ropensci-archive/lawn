#' Standard deviation of a field among points within polygons
#'
#' Calculates the population standard deviation (i.e. denominator = n, not n-1) of
#' values from \code{\link{data-Point}}'s within a set of \code{\link{data-Polygon}}'s
#'
#' @export
#' @param polys Polygon(s) defining area to aggregate.
#' @param pts Points with values to aggregate.
#' @param inField Characater for the name of the field on \code{pts} on which you wish to perfrom
#'        the aggregation
#' @param outField Characater for the name of the field on the ouput polygon FeatureCollection
#'        that will store the resultant value.
#' @template lint
#' @family aggregations
#' @return polygons with appended field representing deviation, as a
#' \code{\link{data-FeatureCollection}}
#'
#' @author Jeff Hollister \email{hollister.jeff@@epa.gov}
#' @examples
#' ex_polys <- lawn_data$polygons_aggregate
#' ex_pts <- lawn_data$points_aggregate
#' lawn_deviation(ex_polys, ex_pts, "population", "pop_sd")
lawn_deviation <- function(polys, pts, inField, outField, lint = FALSE) {
  polys <- convert(polys)
  pts <- convert(pts)
  lawnlint(list(polys, pts), lint)
  ct$eval(sprintf("var polys = %s;", polys))
  ct$eval(sprintf("var pts = %s;", pts))
  ct$eval(sprintf("var inField = '%s';", inField))
  ct$eval(sprintf("var outField = '%s';", outField))
  ct$eval("var dev = turf.deviation(polys, pts, inField, outField);")
  as.fc(ct$get("dev"))
}
