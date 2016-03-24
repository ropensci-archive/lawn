context("lawn_nearest")

point <- '{
  "type": "Feature",
  "properties": {
    "marker-color": "#0f0"
  },
  "geometry": {
    "type": "Point",
    "coordinates": [28.965797, 41.010086]
  }
}'
against <- '{
 "type": "FeatureCollection",
 "features": [
   {
     "type": "Feature",
     "properties": {},
     "geometry": {
       "type": "Point",
       "coordinates": [28.973865, 41.011122]
     }
   }, {
     "type": "Feature",
     "properties": {},
     "geometry": {
       "type": "Point",
       "coordinates": [28.948459, 41.024204]
     }
   }, {
     "type": "Feature",
     "properties": {},
     "geometry": {
       "type": "Point",
       "coordinates": [28.938674, 41.013324]
     }
   }
 ]
}'

a <- lawn_nearest(point, against)

test_that("lawn_nearest returns correct classes", {
  expect_is(a, "point")
  expect_is(a$type, "character")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "numeric")
  expect_equal(a$geometry$type, "Point")
})

test_that("expected values", {
  expect_lt(lawn_nearest(point, lawn_data$points_average)$geometry$coordinates[1], 20)
  expect_lt(lawn_nearest(point, lawn_data$points_aggregate)$geometry$coordinates[1], 5)
})

test_that("lawn_nearest fails correctly", {
  # missing arguments
  expect_error(lawn_nearest(), "argument \"point\" is missing, with no default")
})
