context("lawn_tag")

bbox <- c(0, 0, 10, 10)
pts <- lawn_random(n = 30, bbox = bbox)
polys <- lawn_triangle_grid(bbox, 50, 'miles')
polys$features$properties$fill <- "#f92"
polys$features$properties$stroke <- 0
polys$features$properties$`fill-opacity` <- 1

a <- lawn_tag(pts, polys, 'fill', 'marker-color')

test_that("lawn_tag returns correct classes", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates, "list")
  expect_equal(a$features$geometry$type[1], "Point")

  expect_is(a$features$properties, "data.frame")
  expect_named(a$features$properties, "marker-color")
  expect_equal(a$features$properties$`marker-color`[1], "#f92")
})

test_that("polyId, out_field parameters works as expected", {
  expect_named(lawn_tag(pts, polys, 'fill', 'stuff')$features$properties,
    "stuff")
})

test_that("lawn_tag fails correctly", {
  # missing arguments
  expect_error(lawn_tag(), "argument \"points\" is missing, with no default")
  # wrong geojson input
  expect_error(lawn_tag(pts, "{}", 'fill', 'marker-color'))
})
