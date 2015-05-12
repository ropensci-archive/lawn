context("lawn_variance")

poly <- lawn_data$polygons_average
pt <- lawn_data$points_average

a <- lawn_variance(poly, pt, 'population', 'variance')

test_that("lawn_variance returns correct classes", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates[[1]], "array")
  expect_equal(a$features$geometry$type[1], "Polygon")
})

test_that("cellWidth parameter works as expected", {
  expect_equal(length(lawn_variance(poly, pt, 'population2', 'max')$features$properties), 1)
  expect_named(lawn_variance(poly, pt, 'population', 'bears')$features$properties, 'bears')
})

test_that("lawn_variance fails correctly", {
  # missing arguments
  expect_error(lawn_variance(), "argument \"polygons\" is missing, with no default")
  # wrong in_field param leads to no ouput for max
  expect_equal(length(lawn_variance(poly, pt, 'population2', 'max')$features$properties), 1)
  # can't pass in a character string to cellWidth
  expect_error(lawn_variance(poly, "{}", 'population', 'max'), "Cannot call method")
  # can't pass in a character string to cellWidth
  expect_error(lawn_variance(poly, "{}", 'population', 'max', lint = TRUE), "The type property is required")
})
