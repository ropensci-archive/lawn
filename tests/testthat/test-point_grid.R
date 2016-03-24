context("lawn_point_grid")

a <- lawn_point_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 30, 'miles')
b <- lawn_point_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 10, 'miles')
d <- lawn_point_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 3, 'miles')

test_that("lawn_point_grid returns correct classes", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates, "list")
  expect_equal(a$features$geometry$type, "Point")

  expect_is(b, "featurecollection")
  expect_is(d, "featurecollection")
})

test_that("cellWidth parameter works as expected", {
  expect_lt(NROW(a$features$geometry), NROW(b$features$geometry))
  expect_lt(NROW(b$features$geometry), NROW(d$features$geometry))
  expect_lt(NROW(a$features$geometry), NROW(d$features$geometry))
})

test_that("lawn_point_grid fails correctly", {
  # missing arguments
  expect_error(lawn_point_grid(), "argument \"extent\" is missing, with no default")
  # units value not allowed
  expect_error(lawn_point_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 3, 'adf'),
               "unknown option given to \"units\"")
})
