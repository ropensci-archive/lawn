context("lawn_buffer")

poly <- lawn_data$poly
multi <- lawn_data$multipoly
pt <- lawn_point(c(0, 0))
pt_bff <- lawn_buffer(pt, 100)

test_that("lawn_buffer works", {
  expect_is(lawn_buffer(poly, 100), "featurecollection")
  expect_is(unclass(lawn_buffer(poly, 100)), "list")
  expect_is(lawn_buffer(multi, 100), "featurecollection")
  expect_is(lawn_buffer(pt, 100), "featurecollection")
  expect_is(pt_bff$type, "character")
  expect_is(pt_bff$features, "data.frame")
  expect_is(pt_bff$features$geometry$type, "character")
  expect_is(pt_bff$features$geometry$coordinates[[1]], "array")
})

test_that("lawn_buffer fails correctly", {
  expect_error(lawn_buffer(), "argument \"input\" is missing, with no default")
  expect_error(lawn_buffer(dist = 100), "argument \"input\" is missing, with no default")
  expect_error(lawn_buffer(pt), "argument \"dist\" is missing, with no default")
  expect_error(lawn_buffer(pt, dist = 0), "Cannot read property 'length' of undefined")
  expect_error(lawn_buffer(pt, dist = -100), "Cannot read property 'length' of undefined")
})
