#' Deviation
#'
#' @export
#' @param polys Polygon(s) defining area to aggregate.
#' @param pts Points with values to aggregate.
#' @param inField Characater for the name of the field on \code{pts} on which you wish to perfrom
#'        the aggregation
#' @param outField Characater for the name of the field on the ouput polygon FeatureCollection
#'        that will store the resultant value.
#'
#' @details Calculates the population standard deviation (i.e. denominator = n, not n-1) of
#'          values from points that are within a polygon and returns that on a polygon
#'          FeatureCollection.
#'
#' @author Jeff Hollister \email{hollister.jeff@@epa.gov}
#' @examples
#' ex_polys <- lawn_data$polygons_aggregate
#' ex_pts <- lawn_data$points_aggregate
#' lawn_deviation(ex_polys, ex_pts, "population", "pop_sd")
lawn_deviation <- function(polys, pts, inField, outField) {
  polys <- convert(polys)
  pts <- convert(pts)
  ct$eval(sprintf("var polys = %s;", polys))
  ct$eval(sprintf("var pts = %s;", pts))
  ct$eval(sprintf("var inField = '%s';", inField))
  ct$eval(sprintf("var outField = '%s';", outField))
  ct$eval("var dev = turf.deviation(polys, pts, inField, outField);")
  ct$get("dev")
}
