#' Minimum distance between a point and a lineString
#'
#' Returns the minimum distance between a [data-Point] and a [data-LineString],
#' being the distance from a line the minimum distance between the
#' point and any segment of the LineString.
#'
#' @export
#' @param point ([data-Feature]<([data-Point])>) feature or geometry
#' @param line Line to measure, a [data-Feature]<([data-LineString])>,
#' or [data-FeatureCollection]<([data-LineString])>
#' @param units (character) Can be degrees, radians, miles, or kilometers
#' (default)
#' @param mercator (logical) if distance should be on Mercator or WGS84
#' projection. Default: `FALSE`
#' @template lint
#' @family measurements
#' @return distance between point and line (numeric)
#' @examples
#' pt <- lawn_point("[0, 0]")
#' ln <- lawn_linestring("[[1, 1],[-1, 1]]")
#'
#' lawn_pt2line_distance(pt, ln)
#' lawn_pt2line_distance(pt, ln, mercator = TRUE)
#'
#' lawn_pt2line_distance(pt, ln, 'miles')
#' lawn_pt2line_distance(pt, ln, 'radians')
#' lawn_pt2line_distance(pt, ln, 'degrees')
#' lawn_pt2line_distance(pt, ln, mercator = TRUE)
lawn_pt2line_distance <- function(point, line, units = "kilometers",
                               mercator = FALSE, lint = FALSE) {

  point <- convert(point)
  line <- convert(line)
  lawnlint(list(point, line), lint)
  assert(units, "character")
  assert(mercator, "logical")
  ct$eval(sprintf("var xxx = turf.pointToLineDistance(%s, %s, {units:'%s', mercator:%s});",
    point, line, units, convert(mercator)))
  ct$get("xxx")
}
