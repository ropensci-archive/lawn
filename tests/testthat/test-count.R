context("lawn_count")

pts <- lawn_data$points_count
ply <- lawn_data$polygons_count
a <- lawn_count(polygons = ply, points = pts)

test_that("lawn_count works", {
  expect_is(a, "featurecollection")
  expect_equal(a$type, "FeatureCollection")
  expect_is(a$features, "data.frame")
  expect_named(a$features$properties, "pt_count")

  expect_equal(sum(lawn_count(lawn_data$polygons_average, lawn_data$points_average)$features$properties$pt_count), 5)
})

test_that("count fails correctly", {
  expect_error(lawn_count(), "argument \"polygons\" is missing, with no default")
  expect_error(lawn_count(polygons = ply, points = 4), "Cannot read property")
})
