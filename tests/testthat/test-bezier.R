context("lawn_bezier")

pts <- '[
   [-21.964416, 64.148203],
   [-21.956176, 64.141316],
   [-21.93901, 64.135924],
   [-21.927337, 64.136673]
]'
a <- lawn_bezier(lawn_linestring(pts))
b <- lawn_bezier(lawn_linestring(pts), 9000L)
d <- lawn_bezier(lawn_linestring(pts), 3000L)

test_that("lawn_bezier works", {
  expect_is(a, "linestring")
  expect_is(a$type, "character")
  expect_is(a$geometry, "list")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "matrix")
  expect_equal(length(a$properties), 0)
  expect_equal(NROW(a$geometry$coordinates), 500)

  expect_is(b, "linestring")
  expect_is(b$type, "character")
  expect_is(b$geometry, "list")
  expect_is(b$geometry$type, "character")
  expect_is(b$geometry$coordinates, "matrix")
  expect_equal(length(b$properties), 0)
  expect_equal(NROW(b$geometry$coordinates), 450)

  expect_is(d, "linestring")
  expect_is(d$type, "character")
  expect_is(d$geometry, "list")
  expect_is(d$geometry$type, "character")
  expect_is(d$geometry$coordinates, "matrix")
  expect_equal(length(d$properties), 0)
  expect_equal(NROW(d$geometry$coordinates), 150)
})

test_that("lawn_bezier fails correctly", {
  expect_error(lawn_bezier(), "argument \"line\" is missing, with no default")
  expect_error(lawn_bezier(lawn_linestring(pts), "bean"), "ReferenceError: bean is not defined")
  expect_error(lawn_bezier(lawn_linestring(pts), sharpness = "bean"), "ReferenceError: bean is not defined")
})
