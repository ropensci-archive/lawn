#' Standard deviation of a field among points within polygons
#'
#' Calculates the population standard deviation (i.e. denominator = n,
#' not n-1) of values from \code{\link{data-Point}}'s within a set of
#' \code{\link{data-Polygon}}'s
#'
#' @export
#' @param polygons Polygon(s) defining area to aggregate.
#' @param points Points with values to aggregate.
#' @param in_field Characater for the name of the field on \code{pts} on
#' which you wish to perfrom the aggregation
#' @param out_field Characater for the name of the field on the ouput
#' polygon FeatureCollection that will store the resultant value.
#' @template lint
#' @family aggregations
#' @return polygons with appended field representing deviation, as a
#' \code{\link{data-FeatureCollection}}
#'
#' @author Jeff Hollister \email{hollister.jeff@@epa.gov}
#' @examples \dontrun{
#' ex_polys <- lawn_data$polygons_aggregate
#' ex_pts <- lawn_data$points_aggregate
#' lawn_deviation(ex_polys, ex_pts, "population")
#' }
lawn_deviation <- function(polygons, points, in_field, out_field = "deviation",
                           lint = FALSE) {
  lawnlint(list(polygons, points), lint)
  calc_math("standardDeviation", convert(polygons), convert(points),
            in_field, out_field)
}
