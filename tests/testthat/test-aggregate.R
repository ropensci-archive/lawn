context("lawn_aggregate")

ex_polys <- lawn_data$polygons_aggregate
ex_pts <- lawn_data$points_aggregate
ex_agg <- list(c("sum", "population", "pop_sum"), c("average", "population", "pop_average"), c("count", "",
                                                                                               "num_of_pts"))
agg_result <- lawn_aggregate(ex_polys, ex_pts, ex_agg)

test_that("lawn_aggregate works", {
  expect_is(agg_result, "featurecollection")
  expect_is(agg_result$type, "character")
  expect_is(agg_result$features, "data.frame")
  expect_is(agg_result$features$geometry$type, "character")
  expect_is(agg_result$features$geometry$coordinates[[1]], "array")
  expect_equal(agg_result$features$properties$pop_sum[1], 900)
  expect_equal(agg_result$features$properties$pop_average[1], 300)
  expect_equal(agg_result$features$properties$num_of_pts[1], 3)
})

test_that("lawn_aggregate fails correctly", {
  expect_error(lawn_aggregate(), "argument \"polys\" is missing, with no default")
  expect_error(lawn_aggregate(ex_polys), "argument \"pts\" is missing, with no default")
  expect_error(lawn_aggregate(ex_polys, ex_pts, c("count", "", "test")), "'agg' is not a list")
  expect_error(lawn_aggregate(ex_polys, ex_pts, list(c("mean", "testin", "testout"))), "Error: \"mean\" is not a recognized aggregation operation.")
})
