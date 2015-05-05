context("lawn_point")

test_that("lawn_point works", {
  a <- lawn_point(c(40, -74.50))
  b <- lawn_point(c(40, -74.50), properties = list(name = 'poly1', population = 400))

  expect_is(a, "point")
  expect_is(unclass(a), "list")
  expect_equal(a$type, "Feature")
  expect_is(a$geometry, "list")
  expect_equal(length(a$properties), 0)

  expect_is(b, "point")
  expect_is(unclass(b), "list")
  expect_is(b$geometry, "list")
  expect_is(b$properties, "list")
  expect_equal(b$type, "Feature")
  expect_equal(length(b$properties), 2)
})

test_that("lawn_point fails correctly", {
  expect_error(lawn_point(), "argument \"x\" is missing, with no default")
  expect_error(lawn_point(x = 5), "Coordinates must be an array")
  expect_error(lawn_point(NULL), "Coordinates must be an array")
})
