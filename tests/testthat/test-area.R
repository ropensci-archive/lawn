context("lawn_area")

poly <- lawn_data$poly
multi <- lawn_data$multipoly
pt <- lawn_point(c(-71.4226, 41.4945))

test_that("lawn_area works", {
  expect_is(lawn_area(poly), "numeric")
  expect_is(lawn_area(multi), "numeric")
  expect_is(lawn_area(pt), "integer")
  expect_equal(round(lawn_area(poly)/1000000), 12391 )
  expect_equal(round(lawn_area(multi)/1000000), 24779 )
  expect_equal(lawn_area(pt), 0 )
})

test_that("lawn_area fails correctly", {
  expect_error(lawn_area(), "argument \"input\" is missing, with no default")
})
