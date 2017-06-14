context("lint")

poly1 <- '{
 "type": "Feature",
  "properties": {
    "fill": "#0f0"
  },
  "geometry": {
    "type": "Polygon",
    "coordinates": [[
      [-46.738586, -23.596711],
      [-46.560058, -23.596711],
      [-46.560058, -23.458207],
      [-46.738586, -23.458207],
      [-46.738586, -23.596711]
    ]]
  }
}'

test_that("lint parameter works correctly", {
  # linting isn't envoked b/c missing parameter
  expect_error(lawn_erase(lint = TRUE), "argument \"poly1\" is missing, with no default")
  # linting isn't envoked b/c bad JSON
  expect_error(lawn_erase("A", "B", lint = TRUE), "invalid char in json text")
  # lint: everything missing
  expect_error(lawn_erase(poly1, "{}", lint = TRUE), "Line 1 - \"type\" member required")
  # lint: properties and geometry slots missing
  expect_error(lawn_erase(poly1, '{"type": "Feature"}', lint = TRUE),
               '"properties" member required \nLine 1 - "geometry" member required')
  # lint: properties missing, and type within geometry slot missing
  expect_error(lawn_erase(poly1, '{"type": "Feature", "geometry": {}}', lint = TRUE),
               'Line 1 - \"properties\" member required \nLine 1 - \"type\" member required')
  # lint: type member within geometry slot missing
  expect_error(lawn_erase(poly1, '{"type": "Feature", "properties": {}, "geometry": {}}', lint = TRUE),
               'Line 1 - "type" member required')
  # lint: object within geometry slot missing
  expect_error(lawn_erase(poly1, '{"type": "Feature", "properties": {}, "geometry": {"type": {}}}', lint = TRUE),
               'Line 1 - "type" member should be string, but is an object instead')

  # lint: coordinates data within geometry slot missing
  expect_error(lawn_erase(poly1, '{"type": "Feature", "properties": {}, "geometry": {"type": "Point", "coordinates": []}}', lint = TRUE),
               'Line 1 - position must have 2 or more elements')
  # lint: coordinates data within geometry slot missing
  expect_error(lawn_erase(poly1, '{"type": "Feature", "properties": {}, "geometry": {"type": "Point", "coordinates": [1]}}', lint = TRUE),
               'Line 1 - position must have 2 or more elements')
  # json error, linting not invoked
  expect_error(lawn_erase(poly1, '{"type": "Feature", "properties": {}, "geometry": {"type": "Point", "coordinates": [1,]}}', lint = TRUE),
               'unallowed token')
  # json error b/c letter not quoted, linting not invoked
  expect_error(lawn_erase(poly1, '{"type": "Feature", "properties": {}, "geometry": {"type": "Point", "coordinates": [1, a]}}', lint = TRUE),
               'invalid char in json text')
  # lint: must be a number
  expect_error(lawn_erase(poly1, '{"type": "Feature", "properties": {}, "geometry": {"type": "Point", "coordinates": [1, "a"]}}', lint = TRUE),
               'Line 1 - each element in a position must be a number')
})
