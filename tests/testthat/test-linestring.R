context("lawn_hex_grid")

linestring1 <- '[
   [-21.964416, 64.148203],
   [-21.956176, 64.141316],
   [-21.93901, 64.135924],
   [-21.927337, 64.136673]
]'
linestring2 <- '[
   [-21.929054, 64.127985],
   [-21.912918, 64.134726],
   [-21.916007, 64.141016],
   [-21.930084, 64.14446]
]'

a <- lawn_linestring(linestring1)
b <- lawn_linestring(linestring2)

pts <- list(
   c(-21.964416, 64.148203),
   c(-21.956176, 64.141316),
   c(-21.93901, 64.135924),
   c(-21.927337, 64.136673)
)

d <- lawn_linestring(pts, properties = list(name = 'line1', distance = 145))

test_that("lawn_linestring returns correct classes", {
  expect_is(a, "linestring")
  expect_is(b, "linestring")
  expect_is(d, "linestring")

  expect_is(a$type, "character")
  expect_is(a$geometry$coordinates, "matrix")
})

test_that("properties parameter works as expected", {
  expect_equal(length(a$properties), 0)
  expect_equal(length(d$properties), 2)
  expect_equal(d$properties$name, "line1")
})

test_that("lawn_linestring fails correctly", {
  # missing arguments
  expect_error(lawn_linestring(), "argument \"coordinates\" is missing, with no default")
})
