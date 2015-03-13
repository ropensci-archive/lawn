context("buffer")

poly <- lawn_data$poly
multi <- lawn_data$multipoly
pt <- point(c(0,0))
pt_bff <- buffer(pt,100)

test_that("buffer works", {
  expect_is(buffer(poly,100), "list")
  expect_is(buffer(multi, 100), "list")
  expect_is(buffer(pt,100), "list")
  expect_is(pt_bff$type, "character")
  expect_is(pt_bff$features, "data.frame")
  expect_is(pt_bff$features$geometry$type, "character")
  expect_is(pt_bff$features$geometry$coordinates[[1]], "array")
  expect_equal(area(buffer(pt,1)),expected=pi,tolerance = 0.003)
})

test_that("buffer fails correctly", {
  expect_error(buffer(), "argument \"input\" is missing, with no default")
  expect_error(buffer(dist=100), "argument \"input\" is missing, with no default")
  expect_error(buffer(pt), "argument \"dist\" is missing, with no default")
  expect_error(buffer(pt,dist=0), "Cannot read property 'length' of undefined")
  expect_error(buffer(pt,dist=-100), "Cannot read property 'length' of undefined")
})
