context("lawn_transform_scale")

x <- '{
 "type": "Feature",
 "properties": {},
 "geometry": {
   "type": "Polygon",
   "coordinates": [
    [
      [ 0, 29 ], [ 3.5, 29 ], [ 2.5, 32 ], [ 0, 29 ]
    ]
  ]
 }
}'
xl <- jsonlite::fromJSON(x)

test_that("lawn_transform_scale works", {
  a <- lawn_transform_scale(x, 3)

  expect_is(a, "feature")
  expect_is(unclass(a), "list")
  expect_is(a$type, "character")
  expect_is(a$geometry, "list")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "array")
  # points are not identical to original
  expect_false(identical(xl$geometry$coordinates, a$geometry$coordinates))

  b <- lawn_transform_scale(x, 4)
  expect_true(lawn_area(b) > lawn_area(a))
})

test_that("lawn_transform_scale: origin param works", {
  expect_is(lawn_transform_scale(x, 3, origin = "centroid"), "feature")
  expect_is(lawn_transform_scale(x, 3, origin = "sw"), "feature")
  expect_is(lawn_transform_scale(x, 3, origin = "se"), "feature")
  expect_is(lawn_transform_scale(x, 3, origin = "nw"), "feature")
  expect_is(lawn_transform_scale(x, 3, origin = "ne"), "feature")
  expect_is(lawn_transform_scale(x, 3, origin = "center"), "feature")
})

test_that("lawn_transform_scale fails correctly", {
  expect_error(lawn_transform_scale(), "argument \"x\" is missing, with no default")
  expect_error(lawn_transform_scale(5), "argument \"factor\" is missing, with no default")
  expect_error(lawn_transform_scale(x, 5, "asdfasf"), "invalid origin")
  expect_error(lawn_transform_scale(list(), 100), "unknown GeoJSON type")

  expect_error(lawn_transform_scale(x, "adf"), "adf is not defined")
  expect_error(lawn_transform_scale(x, 34, c(1, "ad")),
               "invalid origin")
})
