context("onload")

obj_names <- c('eval', 'assign', 'validate', 'call',
               'reset', 'source', 'console', 'get')

test_that("onload for turf.js worked", {
  expect_is(ct, "V8")
  expect_true(all(obj_names %in% ls(ct)))
  expect_true(grepl("function", ct$eval("turf.min")))
})

test_that("onload for geojson-random worked", {
  expect_is(rand, "V8")
  expect_true(all(obj_names %in% ls(rand)))
  expect_true(grepl("function", rand$eval("georandom.point")))
})

test_that("onload for geojsonhint worked", {
  expect_is(ht, "V8")
  expect_true(all(obj_names %in% ls(ht)))
  expect_true(grepl("function", ht$eval("geojsonhint.hint")))
})
