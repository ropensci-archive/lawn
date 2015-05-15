context("check4leaflet")

skip_if_not_installed <- function(pkg) {
  if (requireNamespace(pkg, quietly = TRUE))
    return()
  testthat::skip(paste0(pkg, " not installed"))
}

test_that("check4leaflet returns TRUE", {
  skip_if_not_installed("leaflet")

  expect_true(check4leaflet())
})
