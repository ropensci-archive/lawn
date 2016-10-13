context("lawn_remove")

dat <- lawn_data$remove_features
a <- lawn_remove(dat, 'marker-color', '#00f')
b <- lawn_remove(dat, 'marker-color', '#0f0')

test_that("lawn_remove returns correct classes", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates, "list")

  expect_is(b, "featurecollection")
  expect_is(a$features, "data.frame")
})

test_that("property parameter works as expected", {
  expect_gt(length(a$features$geometry$coordinates),
                   length(b$features$geometry$coordinates))
})

test_that("lawn_remove fails correctly", {
  # missing arguments
  expect_error(lawn_remove(), "argument \"features\" is missing, with no default")
  # not found property param gives back empty feature collection
  expect_equal(length(unclass(lawn_remove(dat, 'stuff', '#0f0'))$features), 0)
  # not found value param gives back empty feature collection
  expect_equal(length(unclass(lawn_remove(dat, 'marker-color', '#zzz'))$features), 0)
  # can't pass in a character string to cellWidth
  expect_error(lawn_remove(lawn_point(c(4, 5)), 'marker-color', '#0f0', lint = TRUE),
               "Cannot read property 'length' of undefined")
})
