context("lawn_tag")

pts <- lawn_random(n = 30)
polys <- lawn_triangle_grid(c(-77.3876, 38.7198, -76.9482, 39.0277), 30, 'miles')
polys$features$properties <-
    data.frame(fill = c("#f92", "#295"), stroke = 1:2, `fill-opacity` = 2:3)
a <- lawn_tag(pts, polys, 'fill', 'marker-color')

test_that("lawn_tag returns correct classes", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates, "list")
  expect_equal(a$features$geometry$type[1], "Point")
})

test_that("polyId, containingPolyId parameters works as expected", {
  # no properties given
  expect_equal(length(lawn_tag(pts, polys, 'fill', 'marker-color')$features$properties), 0)
})

test_that("lawn_tag fails correctly", {
  # missing arguments
  expect_error(lawn_tag(), "argument \"points\" is missing, with no default")
  # wrong geojson input
  expect_error(lawn_tag(pts, "{}", 'fill', 'marker-color'), "Cannot call method")
})

### FIX ME - need to add more tests here, including after fixing
### https://github.com/ropensci/lawn/issues/30