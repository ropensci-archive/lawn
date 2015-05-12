context("lawn_midpoint")

pt1 <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Point",
    "coordinates": [144.834823, -37.771257]
  }
}'
pt2 <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Point",
    "coordinates": [145.14244, -37.830937]
  }
}'

a <- lawn_midpoint(pt1, pt2)

test_that("lawn_midpoint returns correct classes", {
  expect_is(a, "point")
  expect_is(a$type, "character")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "numeric")
  expect_equal(a$geometry$type, "Point")
})

test_that("lawn_midpoint fails correctly", {
  # missing arguments
  expect_error(lawn_midpoint(), "argument \"pt1\" is missing, with no default")
})
