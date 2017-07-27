context("lawn_collect")

ex_polys <- lawn_data$polygons_aggregate
ex_pts <- lawn_data$points_aggregate
agg_result <- lawn_collect(ex_polys, ex_pts, 'population', 'stuff')

test_that("lawn_collect works", {
  expect_is(agg_result, "featurecollection")
  expect_is(agg_result$type, "character")
  expect_is(agg_result$features, "data.frame")
  expect_is(agg_result$features$geometry$type, "character")
  expect_is(agg_result$features$geometry$coordinates[[1]], "array")
  expect_equal(agg_result$features$properties$stuff[[1]][1], 200)
  expect_equal(agg_result$features$properties$stuff[[1]][2], 600)
})

test_that("lawn_collect fails correctly", {
  expect_error(lawn_collect(), "argument \"polygons\" is missing, with no default")
  expect_error(lawn_collect(ex_polys), "argument \"points\" is missing, with no default")
  expect_error(lawn_collect(ex_polys, ex_pts, 5), "\"out_field\" is missing")
})
