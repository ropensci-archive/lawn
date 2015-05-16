#' Calculate quantiles
#'
#' Takes a \code{\link{data-FeatureCollection}}, a property name, set of percentiles
#' and returns a quantile array
#'
#' @export
#'
#' @param input Set of Features
#' @param field The property in input from which to retrieve quantile values
#' @param percentiles An Array of percentiles on which to calculate quantile values
#' @template lint
#' @family classification
#' @return An array of the break values
#' @examples
#' pts <- '{
#'  "type": "FeatureCollection",
#'  "features": [
#'    {
#'      "type": "Feature",
#'      "properties": {
#'        "population": 5
#'      },
#'      "geometry": {
#'        "type": "Point",
#'        "coordinates": [5, 5]
#'      }
#'    }, {
#'      "type": "Feature",
#'      "properties": {
#'        "population": 40
#'      },
#'      "geometry": {
#'        "type": "Point",
#'        "coordinates": [1, 3]
#'      }
#'    }, {
#'      "type": "Feature",
#'      "properties": {
#'        "population": 80
#'      },
#'      "geometry": {
#'        "type": "Point",
#'        "coordinates": [14, 2]
#'      }
#'    }, {
#'      "type": "Feature",
#'      "properties": {
#'        "population": 90
#'      },
#'      "geometry": {
#'        "type": "Point",
#'        "coordinates": [13, 1]
#'      }
#'    }, {
#'      "type": "Feature",
#'      "properties": {
#'        "population": 100
#'      },
#'      "geometry": {
#'        "type": "Point",
#'        "coordinates": [19, 7]
#'      }
#'    }
#'  ]
#' }'
#' lawn_quantile(pts, 'population', c(25, 50, 75, 99))
#' lawn_quantile(pts, 'population', c(25, 50, 75, 95))
#' lawn_quantile(pts, 'population', c(25, 50, 75))
#' lawn_quantile(pts, 'population', c(1, 50, 99.9))
lawn_quantile <- function(input, field, percentiles, lint = FALSE) {
  input <- convert(input)
  lawnlint(input, lint)
  ct$eval(sprintf("var quant = turf.quantile(%s, '%s', %s);", input, field, toj(percentiles)))
  ct$get("quant")
}
