skip_on_fedora <- function() {
  sysname <- tolower(Sys.info()[["sysname"]])
  if (sysname == "linux") skip("skipping")
  invisible(TRUE)
}
