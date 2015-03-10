context("area")

poly <- lawn_data$poly
multi <- lawn_data$multipoly



test_that("area works", {
  expect_is(area(poly), "numeric")
  expect_is(area(multi), "numeric")
  expect_equal(round(area(poly)/1000000), 12391 )
  expect_equal(round(area(multipoly/1000000)), 24779 )
})

test_that("area fails correctly", {
  expect_error(area(), "argument \"polygons\" is missing, with no default")
  expect_error(area(polygons = ply, points = 4), "Cannot read property")
  expect_error(area(polygons = ply, points = pts, NULL), "ReferenceError: NA is not defined")
})
