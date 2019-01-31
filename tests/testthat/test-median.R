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
  expect_equal(
    length(
      na.omit(
        lawn_median(
          poly, pt, 'population2', 'median')$features$properties$median)),
    0
  )
  expect_named(
    lawn_median(poly, pt, 'population', 'bears')$features$properties,
    c('values', 'bears'))
})

test_that("lawn_median fails correctly", {
  # missing arguments
  expect_error(lawn_median(), 
    "argument \"in_field\" is missing, with no default")
  # wrong in_field param leads to no ouput for median
  expect_equal(
    length(
      na.omit(
        lawn_median(poly, pt,
          'population2', 'median')$features$properties$median)), 0)
  expect_error(lawn_median(poly, "{}", 'population', 'median'))
})
