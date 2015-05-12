context("lawn_average")

poly <- lawn_data$polygons_average
pt <- lawn_data$points_average
a <- lawn_min(poly, pt, 'population', 'min')

test_that("lawn_average works", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_equal(a$type, "FeatureCollection")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates[[1]], "array")
  expect_equal(a$features$properties$min[1], 100)
  expect_equal(a$features$properties$min[2], 200)
})

test_that("lawn_average fails correctly", {
  expect_error(lawn_min(), "argument \"polygons\" is missing, with no default")
  expect_equal(length(names(lawn_min(poly, pt, 'population2', 'min')$features$properties)), 0)
})
