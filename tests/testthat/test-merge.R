context("lawn_merge")

polygons <- '{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "properties": {
        "fill": "#0f0"
      },
      "geometry": {
        "type": "Polygon",
        "coordinates": [[
          [9.994812, 53.549487],
          [10.046997, 53.598209],
          [10.117721, 53.531737],
          [9.994812, 53.549487]
        ]]
      }
    }, {
      "type": "Feature",
      "properties": {
        "fill": "#00f"
      },
      "geometry": {
        "type": "Polygon",
        "coordinates": [[
          [10.000991, 53.50418],
          [10.03807, 53.562539],
          [9.926834, 53.551731],
          [10.000991, 53.50418]
        ]]
      }
    }
  ]
}'

a <- lawn_merge(polygons)

test_that("lawn_merge returns correct classes", {
  expect_is(a, "polygon")
  expect_is(a$type, "character")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "array")
  expect_equal(a$geometry$type, "Polygon")
})

test_that("lawn_merge fails correctly", {
  # missing arguments
  expect_error(lawn_merge(), "argument \"fc\" is missing, with no default")
})
