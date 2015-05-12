context("lawn_median")

poly <- lawn_data$polygons_average
pt <- lawn_data$points_average

a <- lawn_median(poly, pt, 'population', 'max')

test_that("lawn_median returns correct classes", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates[[1]], "array")
  expect_equal(a$features$geometry$type[1], "Polygon")
})

test_that("in_field and out_field parameter works as expected", {
  expect_equal(length(lawn_median(poly, pt, 'population2', 'median')$features$properties), 1)
  expect_named(lawn_median(poly, pt, 'population', 'bears')$features$properties, 'bears')
})

test_that("lawn_median fails correctly", {
  # missing arguments
  expect_error(lawn_median(), "argument \"polygons\" is missing, with no default")
  # wrong in_field param leads to no ouput for median
  ## FIXME - this should be 0, opened issue in the turf.js repo
  expect_equal(length(lawn_median(poly, pt, 'population2', 'median')$features$properties), 1)
  expect_error(lawn_median(poly, "{}", 'population', 'median'), "Cannot call method")
})
