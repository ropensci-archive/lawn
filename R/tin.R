#' Tin
#'
#' @export
#' @param pt input points
#' @param propertyName name of the property from which to pull z values This is
#' optional: if not given, then there will be no extra data added to the derived
#' triangles.
#' @template lint
#' @return TIN output
#' @details Takes a set of points and the name of a z-value property and creates a
#' Triangulated Irregular Network, or a TIN for short, returned as a collection of
#' Polygons. These are often used for developing elevation contour maps or stepped
#' heat visualizations.
#'
#' This triangulates the points, as well as adds properties called a, b, and c
#' representing the value of the given propertyName at each of the points that
#' represent the corners of the triangle.
#' @examples
#' pts <- lawn_random(bbox = c(-70, 40, -60, 60))
#' lawn_tin(pts)
#' @examples \dontrun{
#' lawn_tin(pts) %>% view
#' lawn_tin(lawn_random(bbox = c(-70, 40, -60, 10))) %>% view
#' }
lawn_tin <- function(pt, propertyName = NULL, lint = FALSE) {
  pt <- convert(pt)
  lawnlint(pt, lint)
  ct$eval(sprintf("var tin = turf.tin(%s, '%s');", pt, convert(propertyName)))
  ct$get("tin")
}
