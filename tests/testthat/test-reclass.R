context("lawn_reclass")

dat <- lawn_data$points_average
translations <- list(list(0, 200, "small"), list(200, 400, "medium"), list(400, 600, "large"))
a <- lawn_reclass(dat, 'population', 'size', translations)

test_that("lawn_reclass returns correct classes", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates, "list")
  expect_equal(a$features$geometry$type[1], "Point")
})

test_that("inField and outField parameters works as expected", {
  expect_named(lawn_reclass(dat, 'population', 'stuff', translations)$features$properties,
               c("population", "stuff"))
  # if inField spelled wrong, no reclass output
  expect_named(lawn_reclass(dat, 'not_found', 'stuff', translations)$features$properties,
               "population")
})

test_that("lawn_reclass fails correctly", {
  # missing arguments
  expect_error(lawn_reclass(), "argument \"input\" is missing, with no default")
  # infield not found gives no output
  expect_equal(length(names(lawn_reclass(dat, 'notfound', 'size', translations)$features$properties)), 1)
  # wrong geojson input type
  expect_error(lawn_reclass("{}", 'notfound', 'size', translations), "Cannot call method")
  # wrong geojson input type
  expect_error(lawn_reclass(lawn_point(c(5, 6)), 'notfound', 'size', translations, lint = TRUE),
               "The type property is required")
})
