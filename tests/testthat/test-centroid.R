context("centroid")

poly <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Polygon",
    "coordinates": [[
      [105.818939,21.004714],
      [105.818939,21.061754],
      [105.890007,21.061754],
      [105.890007,21.004714],
      [105.818939,21.004714]
     ]]
  }
}'
serbia <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Point",
    "coordinates": [20.566406, 43.421008]
   }
}'
a <- centroid(poly)
b <- centroid(serbia)

test_that("centroid works", {
  expect_is(a, "centroid")
  expect_is(unclass(a), "list")
  expect_is(a$type, "character")
  expect_is(a$geometry, "list")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "numeric")

  expect_is(b, "centroid")
  expect_is(unclass(b), "list")
  expect_equal(length(b$properties), 0)
})

test_that("point_on_line fails correctly", {
  expect_error(centroid(), "argument \"features\" is missing, with no default")
  expect_error(centroid(5), "Unknown Geometry Type")
  expect_error(centroid(list()), "Unknown Geometry Type")

  wrong1 <- '{"type":"Feature","properties":{adfad},"geometry":{"type":"Point","coordinates":[20.566406,43.421008]}}'
  expect_error(centroid(wrong1), "Unexpected token }")

  wrong2 <- '{"type":"Feature","properties":{},"geometry":{"type":"Point","coordinates":[20.566406 43.421008]}}'
  expect_error(centroid(wrong2), "Unexpected number")

  wrong3 <- '{"type":"Feature","properties":{},"geometry":{"type":"Point","coordinatez":[20.566406, 43.421008]}}'
  expect_error(centroid(wrong3), "Cannot read property '0' of undefined")
})
