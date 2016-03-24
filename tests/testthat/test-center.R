context("lawn_center")

a <- lawn_center(lawn_data$points_average)

test_that("lawn_center works", {
  expect_is(a, "point")
  expect_is(unclass(a), "list")
  expect_is(a$type, "character")
  expect_is(a$geometry, "list")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "numeric")

  expect_lt(lawn_center(lawn_data$filter_features)$geometry$coordinates[1], 0)
  expect_lt(lawn_center(lawn_data$polygons_within)$geometry$coordinates[1], 0)
})

test_that("lawn_center fails correctly", {
  expect_error(lawn_center(), "argument \"features\" is missing, with no default")
  expect_error(lawn_center(4), "Unknown Geometry Type")
  expect_error(lawn_center("a"), "a is not defined")
})
