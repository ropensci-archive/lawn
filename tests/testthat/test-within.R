context("lawn_within")

a <- lawn_within(lawn_data$points_within, lawn_data$polygons_within)

test_that("lawn_within returns correct classes", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates, "list")
  expect_equal(a$features$geometry$type[1], "Point")
})

test_that("lawn_within fails correctly", {
  # missing arguments
  expect_error(lawn_within(), "argument \"points\" is missing, with no default")
  # empty featurecollection if bbox is not correct
  expect_error(lawn_within(lawn_data$points_within, lawn_data$points_average),
               "Cannot read property 'length' of undefined")
})
