context("lawn_along")

pts <- '[
   [-21.964416, 64.148203],
   [-21.956176, 64.141316],
   [-21.93901, 64.135924],
   [-21.927337, 64.136673]
]'
a <- lawn_along(lawn_linestring(pts), 1, 'miles')

test_that("lawn_along works", {
  expect_is(a, "point")
  expect_is(a$type, "character")
  expect_is(a$geometry, "list")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "numeric")
  expect_equal(length(a$properties), 0)
})

test_that("lawn_along fails correctly", {
  expect_error(lawn_along(), "argument \"line\" is missing, with no default")
  expect_error(lawn_along(lawn_linestring(pts), units = "miles"), "argument \"distance\" is missing, with no default")
  expect_error(lawn_along(lawn_linestring(pts), 1), "argument \"units\" is missing, with no default")
  expect_error(lawn_along(lawn_linestring(pts), 1, "stuff"), "units is invalid")
  expect_error(lawn_along(lawn_linestring(pts), "asdfadf", "miles"), "distance must be of class numeric, integer")
  expect_error(lawn_along("adsf", "asdfadf", "miles"), "distance must be of class numeric, integer")
  expect_error(lawn_along(5, 1, "miles"), "input must be a LineString Feature or Geometry")
  expect_error(lawn_along(5, 1, "miles", lint = TRUE), "The root of a GeoJSON object must be an object")
})
