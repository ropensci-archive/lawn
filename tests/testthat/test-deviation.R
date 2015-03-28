context("deviation")

ex_polys <- lawn_data$polygons_aggregate
ex_pts <- lawn_data$points_aggregate
dev_result <- deviation(ex_polys,ex_pts,"population","pop_sd")

test_that("deviation works", {
  expect_is(dev_result, "list")
  expect_is(dev_result$type, "character")
  expect_is(dev_result$features, "data.frame")
  expect_is(dev_result$features$geometry$type, "character")
  expect_is(dev_result$features$geometry$coordinates[[1]], "array")
  expect_equal(dev_result$features$properties$pop_sd[1], sd(c(200,600,100))*sqrt(2/3))
})

test_that("deviation fails correctly", {
  expect_error(deviation(), "argument \"polys\" is missing, with no default")
  expect_error(deviation(ex_polys), "argument \"pts\" is missing, with no default")
  expect_error(deviation(ex_polys, ex_pts), "argument \"inField\" is missing, with no default")
  expect_error(deviation(ex_polys, ex_pts, "population"), "argument \"outField\" is missing, with no default")
})