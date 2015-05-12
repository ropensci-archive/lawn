context("lawn_random")

## set of points
pt_a <- lawn_random(n = 2)
pt_b <- lawn_random(n = 10)
pt_d <- lawn_random(n = 1000)

## set of polygons
ply_a <- lawn_random('polygons', 2)
ply_b <- lawn_random('polygons', 10)
ply_d <- lawn_random('polygons', 1000)

# with options
# lawn_random(bbox = c(-70, 40, -60, 60))
# lawn_random(num_vertices = 5)

test_that("lawn_random returns correct classes", {
  expect_is(pt_a, "featurecollection")
  expect_is(pt_a$type, "character")
  expect_is(pt_a$features$geometry$type, "character")

  expect_is(pt_b, "featurecollection")
  expect_is(pt_b$type, "character")
  expect_is(pt_b$features$geometry$type, "character")

  expect_is(pt_d, "featurecollection")
  expect_is(pt_d$type, "character")
  expect_is(pt_d$features$geometry$type, "character")

  expect_is(ply_a, "featurecollection")
  expect_is(ply_b, "featurecollection")
  expect_is(ply_d, "featurecollection")
})

test_that("cellWidth parameter works as expected", {
  expect_equal(NROW(pt_a$features), 2)
  expect_equal(NROW(pt_b$features), 10)
  expect_equal(NROW(pt_d$features), 1000)

  expect_equal(NROW(ply_a$features), 2)
  expect_equal(NROW(ply_b$features), 10)
  expect_equal(NROW(ply_d$features), 1000)
})

test_that("lawn_random fails correctly", {
  # missing arguments
  expect_error(lawn_random("stuff"), "valid options are points and polygons")
})
