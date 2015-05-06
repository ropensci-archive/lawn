context("lawn_combine")

# combine points
fc1 <- '{
 "type": "FeatureCollection",
 "features": [
   {
     "type": "Feature",
     "properties": {},
     "geometry": {
       "type": "Point",
       "coordinates": [19.026432, 47.49134]
     }
   }, {
     "type": "Feature",
     "properties": {},
     "geometry": {
       "type": "Point",
       "coordinates": [19.074497, 47.509548]
     }
   }
 ]
}'

# combine linestrings
fc2 <- '{
 "type": "FeatureCollection",
 "features": [
   {
     "type": "Feature",
     "properties": {},
     "geometry": {
       "type": "LineString",
       "coordinates": [
         [-21.964416, 64.148203],
         [-21.956176, 64.141316],
         [-21.93901, 64.135924],
         [-21.927337, 64.136673]
       ]
     }
   }, {
     "type": "Feature",
     "properties": {},
     "geometry": {
       "type": "LineString",
       "coordinates": [
         [-21.929054, 64.127985],
         [-21.912918, 64.134726],
         [-21.916007, 64.141016],
         [-21.930084, 64.14446]
       ]
     }
   }
 ]
}'

a <- lawn_combine(fc1)
b <- lawn_combine(fc2)

test_that("lawn_combine works", {
  expect_is(a, "multipoint")
  expect_is(a$type, "character")
  expect_is(a$geometry$coordinates, "matrix")
  expect_is(a$geometry$type, "character")
  expect_equal(a$geometry$type, "MultiPoint")
  expect_equal(jsonlite::fromJSON(fc1)$features$geometry$type[1], "Point")

  expect_is(b, "multilinestring")
  expect_is(b$type, "character")
  expect_is(b$geometry$coordinates, "array")
  expect_is(b$geometry$type, "character")
  expect_equal(b$geometry$type, "MultiLineString")
  expect_equal(jsonlite::fromJSON(fc2)$features$geometry$type[1], "LineString")
})

test_that("lawn_combine fails correctly", {
  expect_error(lawn_combine(5, TRUE), "Line 0 - The root of a GeoJSON object must be an object")
  expect_error(lawn_combine("ex_polys", TRUE), "invalid char in json text")
  expect_error(lawn_combine("{}", TRUE), "Line 1 - The type property is required and was not found")
  expect_error(lawn_combine(sub("FeatureCollection", "adfadf", fc1), TRUE), "The type adfadf is unknown")
})
