context("lawn_square")

bbox <- c(-20, -20, -15, 0)
a <- lawn_square(bbox)

test_that("lawn_square returns correct classes", {
  expect_is(a, "numeric")
  expect_equal(length(a), 4)
})

test_that("lawn_square fails correctly", {
  # missing arguments
  expect_error(lawn_square(), "argument \"bbox\" is missing, with no default")
  # only length 3 input gives NAs
  expect_true(is.na(lawn_square(c(1, 2, 4))[1]))
  # can't pass in a character string to cellWidth
  expect_error(lawn_square(c(1, 2, 4, "a")), "a is not defined")
})
