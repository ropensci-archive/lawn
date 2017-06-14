context("lawn_unkinkpolygon")

x <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Polygon",
      "coordinates": [[[0, 0], [2, 0], [0, 2], [2, 2], [0, 0]]]
   }
}'
xl <- jsonlite::fromJSON(x)

test_that("lawn_unkinkpolygon works", {
  aa <- lawn_unkinkpolygon(x)

  expect_is(aa, "featurecollection")
  expect_equal(aa$type, "FeatureCollection")
  expect_is(aa$features, "data.frame")
  expect_is(aa$features$properties, "data.frame")
  expect_equal(aa$features$geometry$type, c("Polygon", "Polygon"))

  ## aa has features slot for each polygon created, while original
  ## has one polygon
  expect_false("features" %in% names(xl))
  expect_true("features" %in% names(aa))
})

test_that("lawn_unkinkpolygon fails correctly", {
  expect_error(lawn_unkinkpolygon(),
               "argument \"x\" is missing, with no default")
})
