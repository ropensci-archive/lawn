context("lawn_max")

poly <- lawn_data$polygons_average
pt <- lawn_data$points_average

a <- lawn_max(poly, pt, 'population', 'max')

test_that("lawn_max returns correct classes", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates[[1]], "array")
  expect_equal(a$features$geometry$type[1], "Polygon")
})

test_that("in_field and out_field parameter works as expected", {
  expect_null(lawn_max(poly, pt, 'population2')$features$properties$max)
  expect_named(lawn_max(poly, pt, 'population', 'bears')$features$properties,
               c('values', 'bears'))
})

test_that("lawn_max fails correctly", {
  # missing arguments
  expect_error(lawn_max(), "argument \"in_field\" is missing, with no default")
  # wrong in_field param leads to no ouput for max
  expect_null(lawn_max(poly, pt, 'population2')$features$properties$max)
  # can't pass in a character string to cellWidth
  expect_error(lawn_max(poly, "{}", 'population', 'max'))
  # can't pass in a character string to cellWidth
  expect_error(lawn_max(poly, "{}", 'population', 'max', lint = TRUE),
               'Line 1 - "type" member required')
})
