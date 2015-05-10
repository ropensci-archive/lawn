context("lawn_convex")

a <- lawn_convex(lawn_data$points_average)
b <- lawn_convex(lawn_data$points_within)
d <- lawn_convex(lawn_data$points_aggregate)

test_that("lawn_convex works", {
  expect_is(a, "polygon")
  expect_is(unclass(a), "list")
  expect_is(a$type, "character")
  expect_is(a$geometry, "list")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "array")

  expect_is(b, "polygon")
  expect_is(unclass(b), "list")
  expect_equal(length(b$properties), 0)
})

test_that("lawn_convex fails correctly", {
  expect_error(lawn_convex(), "argument \"input\" is missing, with no default")
  expect_error(lawn_convex("stuff"), "stuff is not defined")
})
