context("lawn_concave")

points <- '{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "type": "Point",
        "coordinates": [-63.601226, 44.642643]
      }
    }, {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "type": "Point",
        "coordinates": [-63.591442, 44.651436]
      }
    }, {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "type": "Point",
        "coordinates": [-63.580799, 44.648749]
      }
    }, {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "type": "Point",
        "coordinates": [-63.573589, 44.641788]
      }
    }, {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "type": "Point",
        "coordinates": [-63.587665, 44.64533]
      }
    }, {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "type": "Point",
        "coordinates": [-63.595218, 44.64765]
      }
    }
    ]
}'

a <- lawn_concave(points, 1)
b <- lawn_concave(points, 5)
d <- lawn_concave(points, 5, "kilometers")
e <- lawn_concave(points, 20)

test_that("lawn_concave works", {
  expect_is(a, "linestring")
  expect_is(unclass(a), "list")
  expect_is(a$type, "character")
  expect_is(a$geometry, "list")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "array")

  expect_is(b, "linestring")
  expect_is(unclass(b), "list")
  expect_equal(length(b$properties), 0)

  expect_is(d, "linestring")
  expect_true(identical(b, d))

  expect_is(e, "linestring")
  expect_false(identical(a, e))
})

test_that("lawn_concave fails correctly", {
  expect_error(lawn_concave(), "argument \"points\" is missing, with no default")
  expect_error(lawn_concave("a"), "a is not defined")
  expect_error(lawn_concave(points, "stuff"), "stuff is not defined")
  expect_error(lawn_concave(points, 1, "stuff"), "unknown option given to \"units\"")
})
