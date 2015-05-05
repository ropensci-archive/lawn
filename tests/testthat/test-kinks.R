context("lawn_kinks")

poly <- '{
 "type": "Feature",
 "properties": {},
 "geometry": {
   "type": "Polygon",
   "coordinates": [[
     [-12.034835, 8.901183],
     [-12.060413, 8.899826],
     [-12.03638, 8.873199],
     [-12.059383, 8.871418],
     [-12.034835, 8.901183]
    ]]
  }
}'
a <- lawn_kinks(poly)

test_that("lawn_kinks works", {
  expect_is(a, "list")
  expect_is(a$intersections, "list")
  expect_null(a$fixed)
  expect_is(a$intersections$features, "data.frame")
  expect_is(a$intersections$features$type, "character")
  expect_is(a$intersections$features$geometry, "data.frame")
  expect_equivalent(round(a$intersections$features$geometry$coordinates[[1]][1]), -12)
})

test_that("lawn_kinks fails correctly", {
  expect_error(lawn_kinks(), "argument \"input\" is missing, with no default")
  expect_error(lawn_kinks(5, TRUE), "Line 0 - The root of a GeoJSON object must be an object")
  expect_error(lawn_kinks("adfadfs"), "ReferenceError")

  bad1 <- '{"type":"Featureadf","properties":{},"geometry":{"type":"Polygon","coordinates":[[[-12.034835,8.901183],[-12.060413,8.899826],[-12.03638,8.873199],[-12.059383,8.871418],[-12.034835,8.901183]]]}}'
  expect_error(lawn_kinks(bad1, TRUE), "The type Featureadf is unknown")

  bad2 <- '{"type":"Feature","properties":{},"geometry":{"type":"Polygan","coordinates":[[[-12.034835,8.901183],[-12.060413,8.899826],[-12.03638,8.873199],[-12.059383,8.871418],[-12.034835,8.901183]]]}}'
  expect_error(lawn_kinks(bad2, TRUE), "The type Polygan is unknown")
})
