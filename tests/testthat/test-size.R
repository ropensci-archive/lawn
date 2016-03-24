context("lawn_size")

bbox <- c(0, 0, 10, 10)
a <- lawn_size(bbox, factor = 1)
b <- lawn_size(bbox, factor = 10)
d <- lawn_size(bbox, factor = 50)
e <- lawn_size(bbox, factor = 100)

test_that("lawn_size returns correct classes", {
  expect_is(a, "integer")
  expect_is(b, "integer")
  expect_is(d, "integer")
  expect_is(e, "integer")
})

test_that("factor parameter works as expected", {
  expect_lt(max(abs(a)), max(abs(b)))
  expect_lt(max(abs(a)), max(abs(d)))
  expect_lt(max(abs(b)), max(abs(d)))
  expect_lt(max(abs(d)), max(abs(e)))
})

test_that("lawn_size fails correctly", {
  # missing arguments
  expect_error(lawn_size(), "argument \"bbox\" is missing, with no default")
  # bad in put in bbox
  bad1 <- lawn_size(c(0, 0, 10, "adf"), 10)
  expect_is(bad1, "character")
  # can't pass in a character string to cellWidth
  expect_error(lawn_size(c(0, 0, 10, 10), "adf"), "adf is not defined")
})
