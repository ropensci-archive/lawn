#' Iterate over features in any GeoJSON object
#'
#' @export
#' @param x any [data-GeoJSON] object
#' @param fun a Javascript function. if not given, returns self
#' @template lint
#' @return matrix of coordinates, where each row in the matrix is a
#' coordinate pair
#' @examples
#' x <- "{ type: 'Feature', geometry: null, properties: { foo: 1, bar: 3 } }"
#'
#' # don't apply any function, identity essentially
#' lawn_featureeach(x)
#'
#' lawn_featureeach(lawn_data$points_count)
#'
#' # appply a function callback
#' lawn_featureeach(lawn_data$points_count, "z.geometry")
#' lawn_featureeach(lawn_data$points_count, "z.geometry.type")
#' lawn_featureeach(lawn_data$points_count, "z.properties")
#' lawn_featureeach(lawn_data$points_count, "z.properties.population")

lawn_featureeach <- function(x, fun = NULL, lint = FALSE) {
  lawnlint(x, lint)
  ct$eval(
    sprintf("
      var peach = [];
      turfmeta.featureEach(%s, function(z) {
        res = %s;
        peach.push(res);
      });", convert(x), fun %||% 'z'
    )
  )
  as.list(ct$get("peach"))
}
