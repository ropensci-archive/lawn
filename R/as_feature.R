#' Convert a FeatureCollection to a Feature
#'
#' @export
#' @param x A \code{\link{data-FeatureCollection}}
#' @details If there are more than one feature within the featurecollection,
#' each feature is split out into a separate feature, returned in a list.
#' Each feature is a assigned a class matching it's GeoJSON data type
#' (e.g., point, polygon, linestring).
#' @examples
#' as_feature(lawn_random())
#' # as_feature(lawn_random("polygons"))
as_feature <- function(x) {
  if (is(x, "featurecollection")) {
    ct$eval(sprintf("var x = %s;", convert(x)))
    tmp <- ct$get("x.features", simplifyVector = FALSE)
    tmp <- lapply(tmp, function(z) {
      structure(z, class = tolower(z$geometry$type))
    })
    if (length(tmp) == 1) {
      tmp[[1]]
    } else {
      tmp
    }
  } else {
    x
  }
}
