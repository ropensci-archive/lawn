#' Enforce expectations about types of Feature inputs
#'
#' @export
#' @param x a [data-Feature] with an expected geometry type. required.
#' @param type (character) expected GeoJSON type. required.
#' @param name (character) name of calling function. required.
#' @template lint
#' @family invariant
#' @return nothing if no problems - error message if a problem
#' @examples
#' # all okay
#' x <- "{ type: 'Feature', properties: {}, geometry: { type: 'Point',
#'   coordinates: [10, 50] } }"
#' lawn_featureof(x, 'Point', 'foobar')
#'
#' # error
#' # lawn_featureof(x, 'MultiPoint', 'foobar')
lawn_featureof <- function(x, type, name, lint = FALSE) {
  lawnlint(x, lint)
  ct$eval(sprintf("var gt = turfinvariant.featureOf(%s, '%s', '%s');",
                  convert(x), type, name))
  ct$get("gt")
}
