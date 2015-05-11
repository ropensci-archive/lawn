context("lawn_erase")

poly1 <- '{
 "type": "Feature",
  "properties": {
    "fill": "#0f0"
  },
  "geometry": {
    "type": "Polygon",
    "coordinates": [[
      [-46.738586, -23.596711],
      [-46.738586, -23.458207],
      [-46.560058, -23.458207],
      [-46.560058, -23.596711],
      [-46.738586, -23.596711]
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
      [-46.650009, -23.631314],
      [-46.650009, -23.5237],
      [-46.509246, -23.5237],
      [-46.509246, -23.631314],
      [-46.650009, -23.631314]
    ]]
  }
}'

poly3 <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Polygon",
    "coordinates": [[
      [2.2264480590820312, 48.8428024034655],
      [2.2264480590820312, 48.88007028454358],
      [2.3115921020507812, 48.88007028454358],
      [2.3115921020507812, 48.8428024034655],
      [2.2264480590820312, 48.8428024034655]
    ]]
  }
}'

poly4 <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Polygon",
    "coordinates": [[
      [2.2834396362304688, 48.818393853998344],
      [2.2834396362304688, 48.85884228699205],
      [2.3672103881835938, 48.85884228699205],
      [2.3672103881835938, 48.818393853998344],
      [2.2834396362304688, 48.818393853998344]
    ]]
  }
}'

a <- lawn_erase(poly1, poly2)
b <- lawn_erase(poly3, poly4)

test_that("lawn_erase works", {
  expect_is(a, "polygon")
  expect_is(unclass(a), "list")
  expect_is(a$type, "character")
  expect_is(a$geometry, "list")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "array")

  expect_is(b, "polygon")
})

test_that("lawn_erase fails correctly", {
  expect_error(lawn_erase(), "argument \"poly1\" is missing, with no default")
  expect_error(lawn_erase("A", "B"), "A is not defined")
  expect_error(lawn_erase(poly1, "{}", lint = TRUE), "The type property is required and was not found")
  expect_error(lawn_erase(poly1, '{"type": "Feature"}', lint = TRUE),
               '"properties" property required \nLine 1 - "geometry" property required')
  expect_error(lawn_erase(poly1, '{"type": "Feature", "geometry": {}}', lint = TRUE),
               'Line 1 - "properties" property required \nLine 1 - The type property is required and was not found')
  expect_error(lawn_erase(poly1, '{"type": "Feature", "properties": {}, "geometry": {}}', lint = TRUE),
               'The type property is required and was not found')
  expect_error(lawn_erase(poly1, '{"type": "Feature", "properties": {}, "geometry": {"type": {}}}', lint = TRUE),
               'Line 1 - The type \\[object Object\\] is unknown')
  expect_error(lawn_erase(poly1, '{"type": "Feature", "properties": {}, "geometry": {"type": "Point", "coordinates": []}}', lint = TRUE),
               'Line 1 - position must have 2 or more elements')
})
