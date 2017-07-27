context("lawn_transform_rotate")

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

test_that("lawn_transform_rotate works", {
  a <- lawn_transform_rotate(x, angle = 100, pivot = c(15, 15))

  expect_is(a, "feature")
  expect_is(unclass(a), "list")
  expect_is(a$type, "character")
  expect_is(a$geometry, "list")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "array")
  # points are not identical to original
  expect_false(identical(xl$geometry$coordinates, a$geometry$coordinates))
})

test_that("lawn_transform_rotate fails correctly", {
  expect_error(lawn_transform_rotate(), "argument \"x\" is missing, with no default")
  expect_error(lawn_transform_rotate(5), "argument \"angle\" is missing, with no default")
  expect_error(lawn_transform_rotate(list(), 100), "Unknown Geometry Type")

  expect_error(lawn_transform_rotate(x, "adf"), "angle must be")
  expect_error(lawn_transform_rotate(x, 34, c(1, "ad")),
               "class numeric")
})
