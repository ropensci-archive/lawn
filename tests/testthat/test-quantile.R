context("lawn_quantile")

pts <- '{
 "type": "FeatureCollection",
 "features": [
   {
     "type": "Feature",
     "properties": {
       "population": 5
     },
     "geometry": {
       "type": "Point",
       "coordinates": [5, 5]
     }
   }, {
     "type": "Feature",
     "properties": {
       "population": 40
     },
     "geometry": {
       "type": "Point",
       "coordinates": [1, 3]
     }
   }, {
     "type": "Feature",
     "properties": {
       "population": 80
     },
     "geometry": {
       "type": "Point",
       "coordinates": [14, 2]
     }
   }, {
     "type": "Feature",
     "properties": {
       "population": 90
     },
     "geometry": {
       "type": "Point",
       "coordinates": [13, 1]
     }
   }, {
     "type": "Feature",
     "properties": {
       "population": 100
     },
     "geometry": {
       "type": "Point",
       "coordinates": [19, 7]
     }
   }
 ]
}'

a <- lawn_quantile(pts, 'population', c(25, 50, 75, 99))
b <- lawn_quantile(pts, 'population', c(25, 50, 75, 95))
d <- lawn_quantile(pts, 'population', c(25, 50, 75))
e <- lawn_quantile(pts, 'population', c(1, 50, 99.9))

test_that("lawn_quantile returns correct classes", {
  expect_is(a, "integer")
  expect_is(b, "integer")
  expect_is(d, "integer")
  expect_is(e, "integer")
})

test_that("cellWidth parameter works as expected", {
  expect_equal(length(a), 4)
  expect_equal(length(b), 4)
  expect_equal(length(d), 3)
  expect_equal(length(e), 3)
})

test_that("lawn_quantile fails correctly", {
  # missing arguments
  expect_error(lawn_quantile(), "argument \"input\" is missing, with no default")
  # empty featurecollection if bbox is not correct
  expect_true(is.na(lawn_quantile(pts, 'population2', c(25, 50, 75, 99))[1]))
})
