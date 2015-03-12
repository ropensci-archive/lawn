context("area")

poly <- lawn_data$poly
multi <- lawn_data$multipoly
pt <- point(c(-71.4226,41.4945))

test_that("area works", {
  expect_is(area(poly), "numeric")
  expect_is(area(multi), "numeric")
  expect_is(area(pt), "integer")
  expect_equal(round(area(poly)/1000000), 12391 )
  expect_equal(round(area(multi)/1000000), 24779 )
  expect_equal(area(pt), 0 )
})

test_that("area fails correctly", {
  expect_error(area(), "argument \"input\" is missing, with no default")
})
