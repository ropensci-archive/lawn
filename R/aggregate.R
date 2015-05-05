#' Aggregate
#'
#' @export
#' @param polys Polygon(s) defining area to aggregate.
#' @param pts Points with values to aggregate.
#' @param agg Aggregation object. For more information, see details.
#'
#' @details Provides a statistical summary of values from points that are
#'          within a polygon.   The \code{agg} parameter must be a list of
#'          vector(s), that contain three values: aggregation, inField, and
#'          outField.  Aggregation may be a string of one of the following:
#'          sum, average, count, min, max, or deviation. The inField is the
#'          name of the field on \code{pts} on which you wish to perfrom the
#'          aggregation and outField is the name of the field on the ouput
#'          polygon FeatureCollection that will store the resultant value.
#'
#' @author Jeff Hollister \email{hollister.jeff@@epa.gov}
#' @examples
#' ex_polys <- lawn_data$polygons_aggregate
#' ex_pts <- lawn_data$points_aggregate
#' ex_agg <- list(c('sum','population','pop_sum'),
#'             c('average','population','pop_average'),
#'             c('count','','num_of_pts'))
#' lawn_aggregate(ex_polys, ex_pts, ex_agg)
lawn_aggregate <- function(polys, pts, agg = list(c("count", "", "num_of_pts"))) {
  polys <- convert(polys)
  pts <- convert(pts)
  agg <- make_agg_array(agg)
  ct$eval(sprintf("var polys = %s;", polys))
  ct$eval(sprintf("var pts = %s;", pts))
  ct$eval(sprintf("var agg = %s;", agg))
  ct$eval("var aggreg = turf.aggregate(polys, pts, agg);")
  ct$get("aggreg")
}

make_agg_array <- function(agg) {
  if (!is.list(agg)) {
    stop("'agg' is not a list")
  }
  agg <- data.frame(do.call("rbind", agg))
  names(agg) <- c("aggregation", "inField", "outField")
  return(toJSON(agg))
}