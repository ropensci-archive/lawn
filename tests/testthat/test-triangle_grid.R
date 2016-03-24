context("lawn_triangle_grid")

a <- lawn_triangle_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 30, 'miles')
b <- lawn_triangle_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 10, 'miles')
d <- lawn_triangle_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 3, 'miles')

test_that("lawn_triangle_grid returns correct classes", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates[[1]], "array")
  expect_equal(a$features$geometry$type[1], "Polygon")

  expect_is(b, "featurecollection")
  expect_is(b$features, "data.frame")

  expect_is(d, "featurecollection")
  expect_is(d$features, "data.frame")
})

test_that("cellWidth parameter works as expected", {
  expect_lt(length(a$features$geometry$coordinates),
                   length(b$features$geometry$coordinates))
  expect_lt(length(b$features$geometry$coordinates),
                   length(d$features$geometry$coordinates))
})

test_that("lawn_triangle_grid fails correctly", {
  # missing arguments
  expect_error(lawn_triangle_grid(), "argument \"extent\" is missing, with no default")
  # empty featurecollection if bbox is not correct
  expect_equal(length(lawn_triangle_grid(c(-96, 31, -84), 10, 'miles')$features), 0)
  # can't pass in a character string to cellWidth
  expect_error(lawn_triangle_grid(c(-96, 31, -84, 40), "the", 'miles'), "the is not defined")
  # can't pass in a character string to cellWidth
  expect_error(lawn_triangle_grid(c(-96, 31, -84, 40), 50, 'doesntexist'), "unknown option given to \"units\"")
})
