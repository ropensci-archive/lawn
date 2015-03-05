context("distance")

from <- '{
 "type": "Feature",
 "properties": {},
 "geometry": {
   "type": "Point",
   "coordinates": [-75.343, 39.984]
 }
}'
to <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Point",
    "coordinates": [-75.534, 39.123]
  }
}'

test_that("distance works", {
  expect_is(distance(from, to), "numeric")
  expect_equal(round(distance(from, to, "kilometers"), 0), 97)
  expect_equal(round(distance(from, to, "miles"), 0), 60)
  expect_equal(round(distance(from, to, "radians"), 2), 0.02)
  expect_equal(round(distance(from, to, "degrees"), 2), 0.87)
})

test_that("distance fails correctly", {
  expect_error(distance(), "missing, with no default")
  expect_error(distance(4, 5), "Invalid input to distance, Feature with geometry required")
  expect_error(distance(from, to, "km"), "unknown option given to \"units\"")
})
