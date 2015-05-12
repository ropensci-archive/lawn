context("lawn_point_on_surface")

# polygon
x <- lawn_random("polygon")
a <- lawn_point_on_surface(x)

# point
x <- lawn_random("point")
b <- lawn_point_on_surface(x)

# linestring
linestring <- '[
   [-21.929054, 64.127985],
   [-21.912918, 64.134726],
   [-21.916007, 64.141016],
   [-21.930084, 64.14446]
]'
d <- lawn_point_on_surface(lawn_linestring(linestring))

test_that("lawn_point_on_surface returns correct classes", {
  expect_is(a, "point")
  expect_is(a$type, "character")
  expect_is(b, "point")
  expect_is(b$type, "character")
  expect_is(d, "point")
  expect_is(d$type, "character")

  expect_equal(lawn_point_on_surface(lawn_point(c(1, 2)))$geometry$coordinates[1], 1)
})

test_that("lawn_point_on_surface fails correctly", {
  # missing arguments
  expect_error(lawn_point_on_surface(), "argument \"x\" is missing, with no default")
  expect_error(lawn_point_on_surface("{}"), "Unknown Geometry Type")
})
