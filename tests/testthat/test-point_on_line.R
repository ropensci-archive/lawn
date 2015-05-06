context("lawn_point_on_line")

line <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "LineString",
    "coordinates": [
      [-77.031669, 38.878605],
      [-77.029609, 38.881946],
      [-77.020339, 38.884084],
      [-77.025661, 38.885821],
      [-77.021884, 38.889563],
      [-77.019824, 38.892368]
    ]
  }
}'
pt <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Point",
    "coordinates": [-77.037076, 38.884017]
  }
}'
a <- lawn_point_on_line(line, pt)

test_that("lawn_point_on_line works", {
  expect_is(a, "point")
  expect_is(a$type, "character")
  expect_is(a$geometry, "list")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "numeric")
})

test_that("lawn_point_on_line fails correctly", {
  expect_error(lawn_point_on_line(), "argument \"line\" is missing, with no default")
  expect_error(lawn_point_on_line(5, TRUE), "input must be a LineString Feature or Geometry")
})
