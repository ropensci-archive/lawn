context("featurecollection")

# points
features <- list(
   point(c(-75.343, 39.984), properties = list(name = 'Location A')),
   point(c(-75.833, 39.284), properties = list(name = 'Location B')),
   point(c(-75.534, 39.123), properties = list(name = 'Location C'))
)
a <- featurecollection(features)

# polygons
rings <- list(list(
   c(-2.275543, 53.464547),
   c(-2.275543, 53.489271),
   c(-2.215118, 53.489271),
   c(-2.215118, 53.464547),
   c(-2.275543, 53.464547)
))
rings2 <- list(list(
   c(-2.775543, 54.464547),
   c(-2.775543, 54.489271),
   c(-2.245118, 54.489271),
   c(-2.245118, 54.464547),
   c(-2.775543, 54.464547)
))
features <- list(
   polygon(rings, properties = list(name = 'poly1', population = 400)),
   polygon(rings2, properties = list(name = 'poly2', population = 5000))
)
b <- featurecollection(features)

# linestrings
pts1 <- list(
   c(-2.364416, 53.448203),
   c(-2.356176, 53.441316),
   c(-2.33901, 53.435924),
   c(-2.327337, 53.436673)
)
pts2 <- rapply(pts1, function(x) x + 0.1, how = "list")
features <- list(
   linestring(pts1, properties = list(name = 'line1', distance = 145)),
   linestring(pts2, properties = list(name = 'line2', distance = 145))
)
c <- featurecollection(features)

test_that("featurecollection works", {
  expect_is(a, "featurecollection")
  expect_is(unclass(a), "list")
  expect_is(a$type, "character")
  expect_equal(a$type, "FeatureCollection")
  expect_is(a$features, "data.frame")
  expect_is(a$features$geometry$type, "character")
  expect_is(a$features$geometry$coordinates[[1]], "numeric")
  expect_equal(a$features$properties$name[1], "Location A")

  expect_is(b, "featurecollection")
  expect_is(unclass(b), "list")
  expect_is(b$type, "character")
  expect_is(b$features, "data.frame")
  expect_is(b$features$geometry$type, "character")
  expect_is(b$features$geometry$coordinates[[1]], "array")
  expect_equal(b$features$properties$population[1], 400)

  expect_is(c, "featurecollection")
  expect_is(unclass(c), "list")
  expect_is(c$type, "character")
  expect_is(c$features, "data.frame")
  expect_is(c$features$geometry$type, "character")
  expect_is(c$features$geometry$coordinates[[1]], "matrix")
  expect_equal(c$features$properties$distance[1], 145)
})

test_that("featurecollection fails correctly", {
  expect_error(featurecollection(), "no applicable method")
  expect_error(featurecollection(5), "applied to an object of class")
  expect_error(featurecollection(rings), "applied to an object of class \"list\"")
})
