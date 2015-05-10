context("lawn_destination")

pt <- '{
  "type": "Feature",
  "properties": {
    "marker-color": "#0f0"
  },
  "geometry": {
    "type": "Point",
    "coordinates": [-75.343, 39.984]
  }
}'

a <- lawn_destination(pt, 50, 90, "miles")
b <- lawn_destination(pt, 100, 90, "miles")
d <- lawn_destination(pt, 2, 45, "kilometers")
e <- lawn_destination(pt, 2, 30, "degrees")

test_that("lawn_destination works", {
  expect_is(a, "point")
  expect_is(unclass(a), "list")
  expect_is(a$type, "character")
  expect_is(a$geometry, "list")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "numeric")

  expect_is(b, "point")
  expect_is(unclass(b), "list")
  expect_equal(length(b$properties), 0)

  expect_equal(round(lawn_distance(pt, a, units = "miles")), 50)
  expect_equal(round(lawn_distance(pt, b, units = "miles")), 100)
  expect_equal(round(lawn_distance(pt, d, units = "kilometers")), 2)
  expect_equal(round(lawn_distance(pt, e, units = "degrees")), 2)
})

test_that("lawn_destination fails correctly", {
  expect_error(lawn_destination(), "argument \"bearing\" is missing, with no default")
  expect_error(lawn_destination(pt, 5), "argument \"bearing\" is missing, with no default")
  expect_error(lawn_destination(pt, 5, 5, "things"), "should be one of")
  expect_error(lawn_destination(pt, 5, 200, "miles"), "bearing must be between -180 and 180")
})
