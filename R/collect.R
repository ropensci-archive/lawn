#' Collect method
#'
#' Given an inProperty on points and an outProperty for polygons,
#' this finds every point that lies within each polygon, collects the
#' inProperty values from those points, and adds them as an array to
#' outProperty on the polygon.
#'
#' @export
#' @template math
#' @template lint
#' @family aggregations
#' @return A FeatureCollection of \code{\link{data-Polygon}} features with
#' properties listed as \code{out_field}
#' @author Jeff Hollister \email{hollister.jeff@@epa.gov}
#' @examples
#' ex_polys <- lawn_data$polygons_aggregate
#' ex_pts <- lawn_data$points_aggregate
#' res <- lawn_collect(ex_polys, ex_pts, 'population', 'stuff')
#' res$type
#' res$features
#' res$features$properties
#'
#' @examples \dontrun{
#' lawn_collect(ex_polys, ex_pts, 'population', 'stuff') %>% view
#' }
lawn_collect <- function(polygons, points, in_field, out_field, lint = FALSE) {
  # This code has been contributed by Jeff Hollister, US EPA
  # Please read the following disclaimer: \url{https://www.epa.gov/home/github-contribution-disclaimer}

  lawnlint(list(polygons, points), lint)
  ct$eval(sprintf("var fc = turf.collect(%s, %s, '%s', '%s');",
                  convert(polygons),
                  convert(points),
                  in_field,
                  out_field))
  as.fc(ct$get("fc"))
}
