context("lawn_jenks")

a <- lawn_jenks(lawn_data$points_average, 'population', 0)
b <- lawn_jenks(lawn_data$points_average, 'population', 1)
d <- lawn_jenks(lawn_data$points_average, 'population', 2)
e <- lawn_jenks(lawn_data$points_average, 'population', 3)
f <- lawn_jenks(lawn_data$points_average, 'population', 4)

test_that("lawn_jenks returns correct class types", {
  expect_is(a, "integer")
  expect_is(b, "integer")
  expect_is(d, "integer")
  expect_is(e, "integer")
  expect_is(f, "integer")
})

test_that("lawn_jenks returns correct class values", {
  expect_equal(a, 100)
  expect_equal(b, c(100, 600))
  expect_equal(d, c(100, 100, 600))
  expect_equal(e, c(100, 100, 200, 600))
})

test_that("lawn_jenks fails correctly", {
  expect_error(lawn_jenks(), "argument \"input\" is missing, with no default")
  expect_error(lawn_jenks(5, 4, 3), "Cannot call method")
  expect_null(lawn_jenks(lawn_data$points_average, 'stuff', 1))
})
