context("lawn_isolines")

file <- system.file("examples", "isolines_data.json", package = "lawn")
pts <- jsonlite::fromJSON(file)
pts$features$properties <- data.frame(z = round(rnorm(100, mean = 5)), stringsAsFactors = FALSE)
breaks <- c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
a <- lawn_isolines(pts, 'z', 15, breaks)
b <- lawn_isolines(pts, 'z', 15, breaks)
d <- lawn_isolines(pts, 'z', 15, breaks)

test_that("lawn_isolines returns correct class", {
  expect_is(a, "featurecollection")
  expect_is(a$type, "character")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates, "list")
  expect_is(a$features$geometry$coordinates[[1]], "matrix")
})

test_that("lawn_isolines returns correct values", {
  expect_equal(a$features$geometry$type[1], "LineString")
  expect_equal(a$features$geometry$type[1], "LineString")
})

# test_that("resolution parameter works as expected", {
#   expect_lt(length(lawn_isolines(pts, 'z', 30, breaks)$features$geometry$coordinates),
#                    length(lawn_isolines(pts, 'z', 50, breaks)$features$geometry$coordinates))
# })

test_that("lawn_isolines fails correctly", {
  expect_error(lawn_isolines(), "argument \"points\" is missing, with no default")
})
