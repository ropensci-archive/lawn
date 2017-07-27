context("lawn_deviation")

ex_polys <- lawn_data$polygons_aggregate
ex_pts <- lawn_data$points_aggregate
dev_result <- lawn_deviation(ex_polys, ex_pts, "population")

test_that("lawn_deviation works", {
  expect_is(dev_result, "featurecollection")
  expect_is(dev_result$type, "character")
  expect_is(dev_result$features, "data.frame")
  expect_is(dev_result$features$geometry$type, "character")
  expect_is(dev_result$features$geometry$coordinates[[1]], "array")
  expect_equal(dev_result$features$properties$deviation[1], sd(c(200, 600, 100)) * sqrt(2/3))
})

test_that("lawn_deviation fails correctly", {
  expect_error(lawn_deviation(), "argument \"in_field\" is missing, with no default")
  expect_error(lawn_deviation(ex_polys), "argument \"in_field\" is missing, with no default")
  expect_error(lawn_deviation(ex_polys, ex_pts), "argument \"in_field\" is missing, with no default")
})