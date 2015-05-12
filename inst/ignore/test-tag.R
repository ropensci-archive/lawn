context("lawn_tag")

pts <- lawn_random(n = 30)
polys <- lawn_triangle_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 30, 'miles')
a <- lawn_tag(pts, polys, 'fill', 'marker-color')

test_that("lawn_tag returns correct classes", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates[[1]], "array")
  expect_equal(a$features$geometry$type[1], "Polygon")
})

test_that("polyId, containingPolyId parameters works as expected", {
})

test_that("lawn_tag fails correctly", {
  # missing arguments
  expect_error(lawn_tag(), "argument \"extent\" is missing, with no default")
  # empty featurecollection if bbox is not correct
  expect_equal(length(lawn_tag(c(-96, 31, -84), 10, 'miles')$features), 0)
  # can't pass in a character string to cellWidth
  expect_error(lawn_tag(c(-96, 31, -84, 40), "the", 'miles'), "the is not defined")
  # can't pass in a character string to cellWidth
  expect_error(lawn_tag(c(-96, 31, -84, 40), 50, 'doesntexist'), "unknown option given to \"units\"")
})
