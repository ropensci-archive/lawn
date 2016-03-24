context("lawn_bearing")

start <- '{
 "type": "Feature",
 "properties": {
   "marker-color": "#f00"
 },
 "geometry": {
   "type": "Point",
   "coordinates": [-75.343, 39.984]
 }
}'

end <- '{
  "type": "Feature",
  "properties": {
    "marker-color": "#0f0"
  },
  "geometry": {
    "type": "Point",
    "coordinates": [-75.534, 39.123]
  }
}'

test_that("lawn_bearing works", {
  expect_is(lawn_bearing(start, end), "numeric")
  expect_lt(lawn_bearing(start, end), 0)
})

start_bad1 <- '{
 "type": "Feature",
 "properties": {
   "marker-color": "#f00"
 },
 "geometry": {
   "type": "Point"
 }
}'

start_bad2 <- '{
 "type": "Feature",
 "properties": {
   "marker-color": "#f00"
 },
 "limousine": {
   "type": "Point",
   "coordinates": [-75.343, 39.984]
 }
}'

test_that("lawn_bearing linting works correctly", {
  expect_error(lawn_bearing(start_bad1, end, lint = TRUE), "Line 1 - \"coordinates\" property required")
  expect_error(lawn_bearing(start_bad2, end, lint = TRUE), "Line 1 - \"geometry\" property required")
})

test_that("lawn_bearing fails correctly", {
  expect_error(lawn_bearing(), "argument \"start\" is missing, with no default")
  expect_error(lawn_bearing(start), "argument \"end\" is missing, with no default")
  expect_error(lawn_bearing(4, 5), "Cannot read property 'coordinates' of undefined")
})
