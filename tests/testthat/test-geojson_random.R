context("geojson_random")

# Random points
pt1 <- gr_point(5)
pt2 <- gr_point(1000)
## with bounding box
pt_bb <- gr_point(5, c(50, 50, 60, 60))

# Random positions
pos1 <- gr_position()
## with bounding box
pos_bb <- gr_position(c(0, 0, 10, 10))

# Random polygons
## number of polygons, default is 1 polygon
poly1 <- gr_polygon()
## number of vertices
poly2 <- gr_polygon(10, 100)
## max radial length, compare the following three
poly3 <- gr_polygon(1, 10, 5)
## use a bounding box
poly_bb <- gr_polygon(1, 5, 5, c(50, 50, 60, 60))

test_that("gr_point works", {
  expect_is(pt1, "featurecollection")
  expect_is(pt2, "featurecollection")
  expect_is(pt_bb, "featurecollection")

  expect_is(pt1$type, "character")
  expect_equal(pt1$type, "FeatureCollection")
  expect_is(pt1$features, "data.frame")

  expect_is(pt2$type, "character")
  expect_equal(pt2$type, "FeatureCollection")
  expect_is(pt2$features, "data.frame")

  expect_is(pt_bb$type, "character")
  expect_equal(pt_bb$type, "FeatureCollection")
  expect_is(pt_bb$features, "data.frame")

  expect_gt(NROW(pt2$features), NROW(pt1$features))
  expect_equal(NROW(pt1$features), NROW(pt_bb$features))

  # fails well
  expect_error(gr_point("a"), "is not TRUE")
  expect_error(gr_point(bbox = "a"), "bbox must be numeric")
  expect_error(gr_point(bbox = c(1, 2, 2, 3, 4)), "bbox must be length 4")
})

test_that("gr_position works", {
  expect_is(pos1, "numeric")
  expect_is(pos_bb, "numeric")

  expect_equal(length(pos1), 2)
  expect_equal(length(pos_bb), 2)

  # fails well
  expect_error(gr_position("a"), "bbox must be numeric")
  expect_error(gr_position(c(1, 2, 3, 4, 5)), "bbox must be length 4")
})

test_that("gr_polygon works", {
  expect_is(poly1, "featurecollection")
  expect_equal(poly1$type, "FeatureCollection")
  expect_is(poly1$features$geometry, "data.frame")
  expect_equal(NROW(poly1$features$geometry), 1)
  expect_equal(length(poly1$features$geometry$coordinates[[1]][,,1]), 11)

  expect_is(poly2, "featurecollection")
  expect_equal(poly2$type, "FeatureCollection")
  expect_is(poly2$features$geometry, "data.frame")
  expect_equal(NROW(poly2$features$geometry), 10)
  expect_equal(length(poly2$features$geometry$coordinates[[1]][,,1]), 101)

  expect_is(poly3, "featurecollection")
  expect_equal(poly3$type, "FeatureCollection")
  expect_is(poly3$features$geometry, "data.frame")
  expect_equal(NROW(poly3$features$geometry), 1)
  expect_equal(length(poly3$features$geometry$coordinates[[1]][,,1]), 11)

  expect_is(poly_bb, "featurecollection")
  expect_equal(poly_bb$type, "FeatureCollection")
  expect_is(poly_bb$features$geometry, "data.frame")
  expect_equal(NROW(poly_bb$features$geometry), 1)
  expect_equal(length(poly_bb$features$geometry$coordinates[[1]][,,1]), 6)

  # fails well
  expect_error(gr_polygon("a"), "a is not defined")
  expect_error(gr_polygon(vertices = "a"), "a is not defined")
  expect_error(gr_polygon(max_radial_length = "a"), "a is not defined")
  expect_error(gr_polygon(bbox = "a"), "bbox must be numeric")
  expect_error(gr_polygon(bbox = c(1, 2, 3, 4, 5)), "bbox must be length 4")
})

