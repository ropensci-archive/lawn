context("check4leaflet")

test_that("check4leaflet returns TRUE", {
  skip_if_not_installed("leaflet")

  expect_true(check4leaflet())
})
