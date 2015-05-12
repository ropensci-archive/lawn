context("lawn_intersect")

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

a <- lawn_intersect(poly1, poly2)

test_that("works returns correct classes", {
  expect_is(a, "polygon")
  expect_is(a$type, "character")
  expect_is(a$geometry, "list")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "array")
  expect_equal(a$geometry$type[1], "Polygon")
})

test_that("fails correctly", {
  expect_error(lawn_intersect(), "argument \"poly1\" is missing, with no default")
  expect_error(lawn_intersect(lawn_data$points_average, lawn_data$points_count),
               "has no method 'intersection'")
  expect_error(lawn_intersect(poly1, sub("Polygon", "polygon", poly2)), "Unknown GeoJSON type: polygon")
  expect_error(lawn_intersect(poly1, sub("Feature", "feature", poly2)), "Unknown GeoJSON type: feature")
  expect_error(lawn_intersect(poly1, sub("coordinates", "cordinates", poly2)), "Cannot read property '0' of undefined")
})
