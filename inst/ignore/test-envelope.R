context("lawn_envelope")

fc <- '{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "properties": {
        "name": "Location A"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [-75.343, 39.984]
      }
    }, {
      "type": "Feature",
      "properties": {
        "name": "Location B"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [-75.833, 39.284]
      }
    }, {
      "type": "Feature",
      "properties": {
        "name": "Location C"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [-75.534, 39.123]
      }
    }
  ]
}'

a <- lawn_envelope(fc)

test_that("lawn_envelope works", {
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

test_that("lawn_envelope fails correctly", {
  expect_error(lawn_envelope(), "argument \"fc\" is missing, with no default")
  expect_error(lawn_envelope(), "Unknown Geometry Type")
  expect_error(lawn_envelope(), "Unknown Geometry Type")
})
