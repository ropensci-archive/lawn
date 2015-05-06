context("lawn_average")

a <- lawn_average(polygons = lawn_data$polygons_average,
                  points = lawn_data$points_average, 'population')

b <- lawn_average(polygons = lawn_data$polygons_average,
                  points = sub("600", "6000", lawn_data$points_average), 'population')

c <- lawn_average(lawn_data$polygons_average, lawn_data$points_average, "pumpkin")

test_that("lawn_average works", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_equal(a$type, "FeatureCollection")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates[[1]], "array")
  expect_equal(a$features$properties$average[1], 300)
  expect_equal(a$features$properties$average[2], 250)

  expect_equal(b$features$properties$average[1], 2100)
  expect_equal(b$features$properties$average[2], 250)

  expect_true(is.na(c$features$properties$average[1]))
})

test_that("lawn_average fails correctly", {
  expect_error(lawn_average(), "argument \"polygons\" is missing, with no default")
  expect_error(lawn_average(lawn_data$polygons_average), "argument \"points\" is missing, with no default")
  expect_error(lawn_average(lawn_data$polygons_average, lawn_data$points_average), "argument \"field\" is missing, with no default")
  expect_error(lawn_average(lawn_data$polygons_average, "styff", "population"), "ReferenceError: styff is not defined")
})
