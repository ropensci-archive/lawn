context("lawn_tin")

pts <- lawn_random(bbox = c(-70, 40, -60, 60))
pts$features$properties <-
  data.frame(z = round(rnorm(NROW(pts$features$geometry), mean = 3, sd = 1)))

### FIXME - need to replicate eg at http://turfjs.org/static/docs/module-turf_tin.html
# tin <- jsonlite::fromJSON(jsonlite::toJSON(unclass(lawn_tin(pts, "z"))), FALSE)
# tin <- lapply(tin$features, function(x) {
#   modifyList(x, list(properties = list(style = list(fill = paste0("#", paste0(x$properties, collapse = "")) ))))
# })
# jsonlite::toJSON(tin) %>% view

a <- lawn_tin(pts)
b <- lawn_tin(pts, propertyName = "z")

test_that("lawn_tin returns correct classes", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates[[1]], "array")
  expect_equal(a$features$geometry$type[1], "Polygon")

  expect_is(b, "featurecollection")
})

test_that("propertyName parameter works as expected", {
  expect_equal(length(names(a$features$properties)), 0)
  expect_named(b$features$properties, c("a", "b", "c"))
})

test_that("lawn_tin fails correctly", {
  # missing arguments
  expect_error(lawn_tin(), "argument \"pt\" is missing, with no default")
  # bad geojson input
  expect_error(lawn_tin("{}"), "Cannot call method")
})
