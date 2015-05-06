context("lawn_flip")

suppressMessages(require("jsonlite", quietly = TRUE))

a <- lawn_flip(lawn_data$points_average)
b <- lawn_flip(lawn_data$polygons_average)

test_that("lawn_flip works", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates[[1]], "numeric")

  pts1 <- fromJSON(lawn_data$points_average)$features$geometry$coordinates[[1]]
  apts1 <- a$features$geometry$coordinates[[1]]
  expect_equal(apts1[1], pts1[2])
})

test_that("lawn_flip fails correctly", {
  expect_equal(lawn_flip(5, FALSE), 5)
  expect_error(lawn_flip(5, TRUE), "Line 0 - The root of a GeoJSON object must be an object")
  expect_error(lawn_flip("adfdfasds"), "ReferenceError")

  bad1 <- '{"type":"Feature","properties":{},"geometry":{"type":"point","coordinates":[20.566406,43.421008]}}'
  expect_error(lawn_flip(bad1, TRUE), "The type point is unknown")

  bad2 <- '{"type":"Feature","properties":{},"geometry":{"type":"Point","cordinates":[20.566406,43.421008]}}'
  expect_error(lawn_flip(bad2, TRUE), '"coordinates" property required')

  bad3 <- '{"type":"Feature","properties":{},"geometry":{"type":"Point","coordinates":[20.566406 43.421008]}}'
  expect_error(lawn_flip(bad3, TRUE), 'parse error')

  bad4 <- '{"typ":"Feature","properties":{},"geometry":{"type":"Point","coordinates":[20.566406, 43.421008]}}'
  expect_error(lawn_flip(bad4, TRUE), 'The type property is required and was not found')
})
