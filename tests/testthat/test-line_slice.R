context("lawn_line_slice")

start <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Point",
    "coordinates": [-77.029609, 38.881946]
  }
}'
stop <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Point",
    "coordinates": [-77.021884, 38.889563]
  }
}'
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

a <- lawn_line_slice(start, stop, line)

test_that("lawn_line_slice works", {
  expect_is(a, "linestring")
  expect_is(a$type, "character")
  expect_is(a$geometry$coordinates, "matrix")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates[[1]], "numeric")
})

test_that("lawn_line_slice fails correctly", {
  expect_error(lawn_line_slice(), "argument \"point1\" is missing, with no default")
  expect_error(lawn_line_slice(5, 5, 6, TRUE), "Line 0 - The root of a GeoJSON object must be an object")
})
