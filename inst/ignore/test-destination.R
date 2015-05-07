context("lawn_center")

xxx

test_that("lawn_center works", {
  expect_is(a, "centroid")
  expect_is(unclass(a), "list")
  expect_is(a$type, "character")
  expect_is(a$geometry, "list")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "numeric")

  expect_is(b, "centroid")
  expect_is(unclass(b), "list")
  expect_equal(length(b$properties), 0)
})

test_that("lawn_center fails correctly", {
  expect_error(lawn_center(), "argument \"features\" is missing, with no default")
  expect_error(lawn_center(), "Unknown Geometry Type")
  expect_error(lawn_center(), "Unknown Geometry Type")
})
