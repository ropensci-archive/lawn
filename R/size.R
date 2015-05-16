#' Expand a bounding box
#'
#' Takes a bounding box and returns a new bounding box with a size
#' expanded or contracted by a factor of X.
#'
#' @export
#' @param bbox a bounding box
#' @param factor the ratio of the new bbox to the input bbox
#' @family measurements
#' @return the resized bbox, numeric vector of length four
#' @examples
#' bbox <- c(0, 0, 10, 10)
#' lawn_size(bbox, factor = 1)
#' lawn_size(bbox, factor = 10)
#' lawn_size(bbox, factor = 50)
#' lawn_size(bbox, factor = 100)
lawn_size <- function(bbox, factor) {
  ct$eval(sprintf("var resize = turf.size(%s, %s);", toj(bbox), factor))
  ct$get("resize")
}
