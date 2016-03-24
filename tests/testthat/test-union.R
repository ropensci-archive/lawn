context("lawn_union")

poly1 <- '{
 "type": "Feature",
 "properties": {
   "fill": "#0f0"
 },
 "geometry": {
   "type": "Polygon",
   "coordinates": [[
     [-122.801742, 45.48565],
     [-122.801742, 45.60491],
     [-122.584762, 45.60491],
     [-122.584762, 45.48565],
     [-122.801742, 45.48565]
    ]]
 }
}'

poly2 <- '{
 "type": "Feature",
 "properties": {
   "fill": "#00f"
 },
 "geometry": {
   "type": "Polygon",
   "coordinates": [[
     [-122.520217, 45.535693],
     [-122.64038, 45.553967],
     [-122.720031, 45.526554],
     [-122.669906, 45.507309],
     [-122.723464, 45.446643],
     [-122.532577, 45.408574],
     [-122.487258, 45.477466],
     [-122.520217, 45.535693]
     ]]
 }
}'

test_that("lawn_union works", {
  a <- lawn_union(poly1, poly2)

  expect_is(a, "polygon")
  expect_is(a$type, "character")
  expect_is(a$geometry, "list")
  expect_is(a$geometry$coordinates, "array")
})

test_that("lawn_union fails correctly", {
  expect_error(lawn_union(), "missing, with no default")
  expect_error(lawn_union("afa", "asd"), "ReferenceError: afa is not defined")
  expect_error(lawn_union(stuff = "adf"), "unused argument")
})
