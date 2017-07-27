#' Create a multilinestring
#'
#' @export
#' @param coordinates A list of positions.
#' @param properties A list of properties.
#' @family data functions
#' @return A [data-Feature]<([data-MultiLineString])>
#' @examples
#' mlstr <- '[
#'   [
#'    [-21.964416, 64.148203],
#'    [-21.956176, 64.141316],
#'    [-21.93901, 64.135924],
#'    [-21.927337, 64.136673]
#'   ],
#'   [
#'    [-21.929054, 64.127985],
#'    [-21.912918, 64.134726],
#'    [-21.916007, 64.141016],
#'    [-21.930084, 64.14446]
#'   ]
#' ]'
#' lawn_multilinestring(mlstr)
#'
#' lawn_multilinestring(mlstr,
#'   properties = list(name = 'line1', distance = 145))
#'
#' # Make a FeatureCollection
#' lawn_featurecollection(lawn_multilinestring(mlstr))
#'
#' @examples \dontrun{
#' lawn_featurecollection(lawn_multilinestring(mlstr)) %>% view
#' }
lawn_multilinestring <- function(coordinates, properties = NULL) {
  ct$eval(sprintf("var xx = turf.multiLineString(%s, %s);",
                  convert(coordinates), toj(properties)))
  as.ml(ct$get("xx"))
}
