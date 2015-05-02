context("count")

pts <- lawn_data$points_count
ply <- lawn_data$polygons_count
a <- count(polygons = ply, points = pts)

test_that("count works", {
  expect_is(a, "list")
  expect_equal(a$type, "FeatureCollection")
  expect_is(a$features, "data.frame")
  expect_named(a$features$properties, "pt_count")

  expect_equal(base::sum(count(lawn_data$polygons_average, lawn_data$points_average)$features$properties$pt_count), 5)
})

test_that("count fails correctly", {
  expect_error(count(), "argument \"polygons\" is missing, with no default")
  expect_error(count(polygons = ply, points = 4), "Cannot read property")
  expect_error(count(polygons = ply, points = pts, NULL), "ReferenceError: NA is not defined")
})
