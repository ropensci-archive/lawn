#' Generate Isolines
#'
#' Takes [data-Point]'s with z-values and an array of value
#' breaks and generates [isolines](http://en.wikipedia.org/wiki/Isoline)
#'
#' @export
#'
#' @param points Input points. a point grid, e.g., output of [lawn_point_grid()]
#' @param z (character) The property name in points from which z-values will
#' be pulled.
#' @param breaks (numeric) Where to draw contours.
#' @param propertiesToAllIsolines GeoJSON properties passed to ALL isolines
#' @param propertiesPerIsoline GeoJSON properties passed, in order, to the
#' correspondent isoline; the breaks array will define the order in which the
#' isolines are created
#' @param resolution (numeric) Resolution of the underlying grid. THIS
#' PARAMETER IS DEFUNCT
#' @template lint
#' @family interpolation
#' @return A [data-FeatureCollection] of isolines
#' ([data-LineString] features).
#' @details Warning: this function seems to be broken, not sure why
#' @examples \dontrun{
#' # pts <- lawn_random(n = 100, bbox = c(0, 30, 20, 50))
#' pts <- lawn_point_grid(c(0, 30, 20, 50), 100, 'miles')
#' pts$features$properties <-
#'   data.frame(temperature = round(rnorm(NROW(pts$features), mean = 5)),
#'   stringsAsFactors = FALSE)
#' breaks <- c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
#' lawn_isolines(points = pts, breaks, z = 'temperature')
#'
#' lawn_isolines(pts, breaks, 'temperature') %>% view
#' }
lawn_isolines <- function(points, breaks, z, propertiesToAllIsolines = c(),
                          propertiesPerIsoline = list(), resolution = NULL,
                          lint = FALSE) {
  calls <- names(sapply(match.call(), deparse))[-1]
  calls_vec <- "resolution" %in% calls
  if (any(calls_vec)) {
    stop("The parameter resolution has been removed. \n\nSee docs for ?lawn_isolines")
  }

  points <- convert(points)
  lawnlint(points, lint)
  ct$eval(sprintf("var iso = turf.isolines(%s, %s, '%s', %s, %s);",
                  points, toj(breaks), z, toj(propertiesToAllIsolines),
                  toj(propertiesPerIsoline)))
  as.fc(ct$get("iso"))
}
