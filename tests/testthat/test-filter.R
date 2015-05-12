context("lawn_filter")

a <- lawn_filter(lawn_data$filter_features, 'species', 'oak')
b <- lawn_filter(lawn_data$filter_features, 'species', 'maple')
d <- lawn_filter(lawn_data$filter_features, 'species', 'redwood')

test_that("lawn_filter returns the correct classes", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates[[1]], "numeric")
  expect_equal(a$features$geometry$type[1], "Point")
})

test_that("lawn_filter returns the correct values", {
  expect_equal(a$type, "FeatureCollection")
  expect_equal(d$features$type, "Feature")
  expect_equal(d$features$geometry$type, "Point")
})

test_that("lawn_filter fails correctly", {
  # missing parameter input
  expect_error(lawn_filter(), "argument \"key\" is missing, with no default")
  # zero length output if no matches
  expect_equal(length(lawn_filter(lawn_data$filter_features, 4, 5)$features), 0)
})
