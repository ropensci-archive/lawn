context("lawn_inside")

point1 <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Point",
    "coordinates": [-111.467285, 40.75766]
  }
}'
point2 <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Point",
    "coordinates": [-111.873779, 40.647303]
  }
}'
point3 <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Point",
    "coordinates": [-111.973879, 40.647303]
  }
}'
poly <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Polygon",
    "coordinates": [[
      [-112.074279, 40.52215],
      [-112.074279, 40.853293],
      [-111.610107, 40.853293],
      [-111.610107, 40.52215],
      [-112.074279, 40.52215]
    ]]
  }
}'

a <- lawn_inside(point1, poly)
b <- lawn_inside(point2, poly)
d <- lawn_inside(point3, poly)

test_that("lawn_inside returns correct classes", {
  expect_is(a, "logical")
  expect_is(b, "logical")
  expect_is(d, "logical")
})

test_that("lawn_inside returns correct values", {
  expect_false(a)
  expect_true(b)
  expect_true(d)
})

test_that("lawn_inside fails correctly", {
  expect_error(lawn_inside(), "argument \"point\" is missing, with no default")
  expect_error(lawn_inside("{}", poly), "Cannot read property 'coordinates' of undefined")
  expect_error(lawn_inside(point1, point2), "Cannot read property 'length' of undefined")
})
