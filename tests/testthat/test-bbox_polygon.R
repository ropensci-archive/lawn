context("lawn_bbox_polygon")

bbox <- c(0, 0, 10, 10)
a <- lawn_bbox_polygon(bbox)
b <- lawn_bbox_polygon(c(5, 5, 10, 10))
d <- lawn_bbox_polygon(c(-15, -5, 50, 60))
e <- lawn_bbox_polygon(c(0.1, 1, 0.2, 2))

test_that("lawn_bbox_polygon works", {
  expect_is(a, "polygon")
  expect_is(a$type, "character")
  expect_is(a$geometry$type, "character")
  expect_equal(a$geometry$type, "Polygon")
  expect_is(a$geometry$coordinates, "array")

  expect_is(b, "polygon")
  expect_is(b$type, "character")
  expect_is(b$geometry$type, "character")
  expect_equal(b$geometry$type, "Polygon")
  expect_is(b$geometry$coordinates, "array")

  expect_is(d, "polygon")
  expect_is(d$type, "character")
  expect_is(d$geometry$type, "character")
  expect_equal(d$geometry$type, "Polygon")
  expect_is(d$geometry$coordinates, "array")

  expect_is(e, "polygon")
  expect_is(e$type, "character")
  expect_is(e$geometry$type, "character")
  expect_equal(e$geometry$type, "Polygon")
  expect_is(e$geometry$coordinates, "array")
})

test_that("lawn_bbox_polygon fails correctly", {
  expect_error(lawn_bbox_polygon(), "argument \"bbox\" is missing, with no default")
  expect_true(is.na(lawn_bbox_polygon(1)$geometry$coordinates[,,1][1]))
  expect_error(lawn_bbox_polygon(c("1", 2, 3, 4)), "All values must be numeric")
  expect_error(lawn_bbox_polygon(c("a", "b", "c", "d")), "All values must be numeric")
})
