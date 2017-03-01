#' Enforce expectations about types of GeoJSON objects.
#'
#' @export
#' @param x value of any [data-GeoJSON] object. required.
#' @param type expected GeoJSON type. required.
#' @param name name of calling function. required.
#' @template lint
#' @family invariant
#' @return nothing if no problems - error message if a problem
#' @examples
#' # all okay
#' x <- "{ type: 'Point', coordinates: [10, 50] }"
#' lawn_geosjontype(x, 'Point', 'fooBar')
#'
#' # error
#' # lawn_geosjontype(x, 'Polygon', 'fooBar')
lawn_geosjontype <- function(x, type, name, lint = FALSE) {
  lawnlint(x, lint)
  ct$eval(sprintf("var gt = turfinvariant.geojsonType(%s, '%s', '%s');",
                  convert(x), type, name))
  ct$get("gt")
}
