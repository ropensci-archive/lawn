context("lawn_line_distance")

line <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "LineString",
    "coordinates": [
      [-77.031669, 38.878605],
      [-77.029609, 38.881946],
      [-77.020339, 38.884084],
      [-77.025661, 38.885821],
      [-77.021884, 38.889563],
      [-77.019824, 38.892368]
    ]
  }
}'
a <- lawn_line_distance(line, 'kilometers')
b <- lawn_line_distance(line, 'miles')
d <- lawn_line_distance(line, 'radians')
e <- lawn_line_distance(line, 'degrees')

test_that("lawn_line_distance returns correct classes", {
  expect_is(a, "numeric")
  expect_is(b, "numeric")
  expect_is(d, "numeric")
  expect_is(e, "numeric")
})

test_that("right dimensions", {
  expect_lt(d, e)
  expect_lt(e, b)
  expect_lt(b, a)
  expect_equal(length(lawn_line_distance(line, 'miles')), 1)
})

test_that("lawn_line_distance fails correctly", {
  # missing arguments
  expect_error(lawn_line_distance(), "argument \"line\" is missing, with no default")
  # can't pass in a character string to cellWidth
  expect_error(lawn_line_distance(line, 'stuff'), "unknown option given to \"units\"")
  # can't pass in a character string to cellWidth
  expect_error(lawn_line_distance("{}", "miles"), "input must be a LineString Feature or Geometry")
})
