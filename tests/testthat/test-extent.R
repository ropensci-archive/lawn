context("lawn_extent")

# From a FeatureCollection
a <- lawn_extent(lawn_data$points_average)

# From a Feature
dat <- '{
 "type": "Feature",
 "properties": {},
 "geometry": {
     "type": "Polygon",
     "coordinates": [[
       [-112.072391,46.586591],
       [-112.072391,46.61761],
       [-112.028102,46.61761],
       [-112.028102,46.586591],
       [-112.072391,46.586591]
     ]]
   }
}'
b <- lawn_extent(dat)

test_that("lawn_extent returns correct classes", {
  expect_is(a, "numeric")
  expect_is(a[1], "numeric")
  expect_is(b, "numeric")
  expect_is(b[1], "numeric")
})

test_that("lawn_extent returns correct values", {
  expect_equal(length(a), 4)
  expect_lt(a[1], 20)
  expect_lt(a[2], 60)

  expect_equal(length(b), 4)
  expect_lt(b[1], 0)
  expect_lt(b[2], 50)
})

test_that("lawn_extent fails correctly", {
  expect_error(lawn_extent(), "argument \"input\" is missing, with no default")
  expect_error(lawn_extent(5), "Unknown Geometry Type")
  expect_error(lawn_extent("{}", TRUE), "The type property is required and was not found")
})
