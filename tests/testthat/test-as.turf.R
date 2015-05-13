context("as.turf")

rings <- list(list(
   c(-2.275543, 53.464547),
   c(-2.275543, 53.489271),
   c(-2.215118, 53.489271),
   c(-2.215118, 53.464547),
   c(-2.275543, 53.464547)
))

linestring1 <- '[
   [-21.964416, 64.148203],
   [-21.956176, 64.141316],
   [-21.93901, 64.135924],
   [-21.927337, 64.136673]
]'

a <- as.turf(lawn_point(c(-74.5, 40)))
b <- as.turf(lawn_polygon(rings))
d <- as.turf(lawn_linestring(linestring1))
e <- as.turf(lawn_centroid(lawn_polygon(rings)))

# suppressPackageStartupMessages(library("geojsonio", quietly = TRUE))
# f <- as.turf(geojson_list(c(-99.74,32.45)))

test_that("as.turf works", {
  expect_is(a, "character")
  expect_is(b, "character")
  expect_is(d, "character")
  expect_is(e, "character")
  # expect_is(f, "list")
  # expect_is(f[[1]], "character")

  expect_true(grepl("turf.point", a))
  expect_true(grepl("turf.polygon", b))
  expect_true(grepl("turf.linestring", d))
  expect_true(grepl("turf.point", e))
  # expect_true(grepl("turf.point", f))
})

test_that("as.turf fails correctly", {
  expect_error(as.turf(), "no applicable method")
  expect_error(as.turf(""), "no applicable method")
  expect_error(as.turf(mtcars), "no applicable method")
})
