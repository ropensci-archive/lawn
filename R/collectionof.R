#' Enforce expectations about types of FeatureCollection inputs
#'
#' @export
#' @param x a [data-FeatureCollection] for which features will be judged.
#' required
#' @param type (character) expected GeoJSON type. required.
#' @param name (character) name of calling function. required.
#' @template lint
#' @family invariant
#' @return nothing if no problems - error message if a problem
#' @examples
#' # all okay
#' lawn_collectionof(lawn_data$points_count, 'Point', 'stuff')
#'
#' # error
#' # lawn_collectionof(lawn_data$points_count, 'Polygon', 'stuff')
lawn_collectionof <- function(x, type, name, lint = FALSE) {
  lawnlint(x, lint)
  is_type(x, type_top = "FeatureCollection")
  ct$eval(sprintf("var gt = turfinvariant.collectionOf(%s, '%s', '%s');",
                  convert(x), type, name))
  ct$get("gt")
}
