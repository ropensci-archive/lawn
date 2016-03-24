context("lawn_hex_grid")

a <- lawn_hex_grid(c(-96, 31, -84, 40), 50, 'miles')
b <- lawn_hex_grid(c(-96, 31, -84, 40), 30, 'miles')
d <- lawn_hex_grid(c(-96, 31, -84, 40), 10, 'miles')

test_that("lawn_hex_grid returns correct classes", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates[[1]], "array")
  expect_equal(a$features$geometry$type[1], "Polygon")
})

test_that("cellWidth parameter works as expected", {
  expect_lt(length(a$features$geometry$coordinates),
                   length(b$features$geometry$coordinates))
  expect_lt(length(a$features$geometry$coordinates),
                   length(d$features$geometry$coordinates))
  expect_lt(length(b$features$geometry$coordinates),
                   length(d$features$geometry$coordinates))
})

test_that("lawn_hex_grid fails correctly", {
  # missing arguments
  expect_error(lawn_hex_grid(), "argument \"extent\" is missing, with no default")
  # empty featurecollection if bbox is not correct
  expect_equal(length(lawn_hex_grid(c(-96, 31, -84), 10, 'miles')$features), 0)
  # can't pass in a character string to cellWidth
  expect_error(lawn_hex_grid(c(-96, 31, -84, 40), "the", 'miles'), "the is not defined")
  # can't pass in a character string to cellWidth
  expect_error(lawn_hex_grid(c(-96, 31, -84, 40), 50, 'doesntexist'), "unknown option given to \"units\"")
})
