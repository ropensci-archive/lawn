context("lawn_explode")

poly <- '{
 "type": "Feature",
 "properties": {},
 "geometry": {
   "type": "Polygon",
   "coordinates": [[
     [177.434692, -17.77517],
     [177.402076, -17.779093],
     [177.38079, -17.803937],
     [177.40242, -17.826164],
     [177.438468, -17.824857],
     [177.454948, -17.796746],
     [177.434692, -17.77517]
    ]]
 }
}'
a <- lawn_explode(poly)

test_that("lawn_explode works", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates[[1]], "numeric")
  expect_equal(a$features$geometry$type[1], "Point")
})

test_that("lawn_explode fails correctly", {
  expect_error(lawn_explode(), "argument \"input\" is missing, with no default")
  expect_error(lawn_explode(5), "Unknown Geometry Type")
  expect_error(lawn_explode(5, TRUE), "Line 0 - The root of a GeoJSON object must be an object")
})
