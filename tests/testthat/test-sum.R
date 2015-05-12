context("lawn_sum")

poly <- lawn_data$polygons_average
pt <- lawn_data$points_average
a <- lawn_sum(poly, pt, 'population', 'sum')

test_that("lawn_sum returns correct classes", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates[[1]], "array")
  expect_equal(a$features$geometry$type[1], "Polygon")
})

test_that("in_field and out_field parameters works as expected", {
  expect_named(lawn_sum(poly, pt, 'population', 'sum')$features$properties, "sum")
  expect_named(lawn_sum(poly, pt, 'population', 'stuff')$features$properties, "stuff")
  expect_true(is.na(lawn_sum(poly, pt, 'population2', 'sum')$features$properties$sum[1]))
})

test_that("lawn_sum fails correctly", {
  # missing arguments
  expect_error(lawn_sum(), "argument \"polygons\" is missing, with no default")
  # can't pass in a character string to cellWidth
  expect_error(lawn_sum(poly, "{}", 'population', 'sum'), "Cannot call method")
})
