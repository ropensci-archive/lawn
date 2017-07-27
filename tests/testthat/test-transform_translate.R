context("lawn_transform_translate")

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

test_that("lawn_transform_translate works", {
  a <- lawn_transform_translate(x, distance = 100, direction = 35)

  expect_is(a, "feature")
  expect_is(unclass(a), "list")
  expect_is(a$type, "character")
  expect_is(a$geometry, "list")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "array")
  # points are not identical to original
  expect_false(identical(xl$geometry$coordinates, a$geometry$coordinates))
})

test_that("lawn_transform_translate: units param works", {
  expect_is(lawn_transform_translate(x, 100, 5, "kilometers"), "feature")
  expect_is(lawn_transform_translate(x, 100, 5, "miles"), "feature")
  expect_is(lawn_transform_translate(x, 100, 5, "degrees"), "feature")
  expect_is(lawn_transform_translate(x, 100, 5, "radians"), "feature")
})

test_that("lawn_transform_translate fails correctly", {
  expect_error(lawn_transform_translate(), "argument \"x\" is missing, with no default")
  expect_error(lawn_transform_translate(5), "argument \"distance\" is missing, with no default")
  expect_error(lawn_transform_translate(x, 100), "argument \"direction\" is missing, with no default")

  expect_error(lawn_transform_translate(x, "Asdf", 5), "must be of class")
  expect_error(lawn_transform_translate(x, 100, "ad"), "must be of class")
  expect_error(lawn_transform_translate(x, 100, 4, "aas"), "units is invalid")

  expect_error(lawn_transform_translate(list(), 100, 4), "Unknown Geometry Type")
})
