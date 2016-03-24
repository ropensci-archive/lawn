context("lawn_planepoint")

pt <- lawn_point(c(-75.3221, 39.529))
triangle <- '{
  "type": "Feature",
  "properties": {
    "a": 11,
    "b": 122,
    "c": 44
  },
  "geometry": {
    "type": "Polygon",
    "coordinates": [[
      [-75.1221, 39.57],
      [-75.58, 39.18],
      [-75.97, 39.86],
      [-75.1221, 39.57]
    ]]
  }
}'

a <- lawn_planepoint(pt, triangle)

test_that("lawn_planepoint returns correct classes", {
  expect_is(a, "numeric")
})

test_that("give right values", {
  expect_lt(lawn_planepoint(lawn_point(c(-75.3221, 39.229)), triangle), 90)
  expect_lt(lawn_planepoint(lawn_point(c(-75.3221, 39.129)), triangle), 106)
  expect_lt(lawn_planepoint(lawn_point(c(-75.3221, 39.029)), triangle), 125)
})

test_that("lawn_planepoint fails correctly", {
  # missing arguments
  expect_error(lawn_planepoint(), "argument \"pt\" is missing, with no default")
})
