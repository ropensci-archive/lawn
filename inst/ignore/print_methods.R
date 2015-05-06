#' @export
print.polygon <- function(x, ...) {
  cat("<Polygon>", sep = "\n")
  cat(sprintf("  No. points: %s", length(x$geometry$coordinates[,,1])), sep = "\n")
  cat(sprintf("  Mean Long: %s", mean(x$geometry$coordinates[,,1])), sep = "\n")
  cat(sprintf("  Mean Lat: %s", mean(x$geometry$coordinates[,,2])), sep = "\n")
  if (length(x$properties) != 0) {
    cat("  Properties: ", sep = "\n")
    for (i in seq_along(x$properties)) {
      cat(sprintf("     %s: %s", names(x$properties[i]), x$properties[[i]]), sep = "\n")
    }
  } else {
    cat("  Properties: NULL", sep = "\n")
  }
}

#' @export
print.linestring <- function(x, ...) {
  cat("<LineString>", sep = "\n")
  cat(sprintf("  No. points: %s", NROW(x$geometry$coordinates)), sep = "\n")
  cat(sprintf("  Mean Long: %s", mean(x$geometry$coordinates[,1])), sep = "\n")
  cat(sprintf("  Mean Lat: %s", mean(x$geometry$coordinates[,2])), sep = "\n")
  if (length(x$properties) != 0) {
    cat("  Properties: ", sep = "\n")
    for (i in seq_along(x$properties)) {
      cat(sprintf("     %s: %s", names(x$properties[i]), x$properties[[i]]), sep = "\n")
    }
  } else {
    cat("  Properties: NULL", sep = "\n")
  }
}

#' @export
print.point <- function(x, ...) {
  cat("<Point>", sep = "\n")
  cat(sprintf("  Long: %s", x$geometry$coordinates[1]), sep = "\n")
  cat(sprintf("  Lat: %s", x$geometry$coordinates[2]), sep = "\n")
  if (length(x$properties) != 0) {
    cat("  Properties: ", sep = "\n")
    for (i in seq_along(x$properties)) {
      cat(sprintf("     %s: %s", names(x$properties[i]), x$properties[[i]]), sep = "\n")
    }
  } else {
    cat("  Properties: NULL", sep = "\n")
  }
}
