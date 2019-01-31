context("lawn_count")

pts <- lawn_data$points_count
ply <- lawn_data$polygons_count
a <- lawn_count(polygons = ply, points = pts, "population")

test_that("lawn_count works", {
  expect_is(a, "featurecollection")
  expect_equal(a$type, "FeatureCollection")
  expect_is(a$features, "data.frame")
  expect_named(a$features$properties, c("values", "count"))

  expect_equal(sum(
    lawn_count(lawn_data$polygons_average,
      lawn_data$points_average, "population")$features$properties$count), 5)
})

test_that("count fails correctly", {
  expect_error(lawn_count(),
    "argument \"polygons\" is missing, with no default")
  expect_error(lawn_count(polygons = ply, points = 4, "population"))
  expect_error(
    lawn_count(polygons = ply, points = 4, "population", lint = TRUE),
    "Polygons and MultiPolygons should follow the right-hand rule")
})
