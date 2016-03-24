context("lawn_sample")

dat <- lawn_data$points_average
a <- lawn_sample(dat, 1)
b <- lawn_sample(dat, 2)
d <- lawn_sample(dat, 3)

test_that("lawn_sample returns correct classes", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")

  expect_is(b, "featurecollection")
  expect_is(b$features, "data.frame")
  expect_is(b$features$geometry$coordinates, "list")

  expect_is(d, "featurecollection")
  expect_is(d$features, "data.frame")
})

test_that("n parameter works as expected", {
  expect_lt(NROW(a$features), NROW(b$features))
  expect_lt(NROW(a$features), NROW(d$features))
  expect_lt(NROW(b$features), NROW(d$features))
})

test_that("lawn_sample fails correctly", {
  # n of negative number gives back no data
  expect_equal(length(lawn_sample(dat, -1)$features), 0)
  # n of character string errors
  expect_error(lawn_sample(dat, "a"), "a is not defined")
})
