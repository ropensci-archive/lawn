context("lawn_buffer")


test_that("lawn_buffer works", {
  skip_on_fedora()

  poly <- lawn_data$poly
  multi <- lawn_data$multipoly
  pt <- lawn_point(c(0, 0))
  pt_bff <- lawn_buffer(pt, 100)

  expect_is(lawn_buffer(poly, 100), "feature")
  expect_is(unclass(lawn_buffer(poly, 100)), "list")
  expect_is(lawn_buffer(multi, 100), "featurecollection")
  expect_is(lawn_buffer(pt, 100), "feature")
  expect_is(pt_bff$type, "character")
  expect_null(pt_bff$features)
})

test_that("lawn_buffer fails correctly", {
  skip_on_fedora()

  pt <- lawn_point(c(0, 0))

  expect_error(lawn_buffer(), "argument \"input\" is missing, with no default")
  expect_error(lawn_buffer(dist = 100), "argument \"input\" is missing, with no default")
  expect_error(lawn_buffer(pt), "argument \"dist\" is missing, with no default")
  expect_null(lawn_buffer(pt, dist = 0))
  expect_null(lawn_buffer(pt, dist = -100))
})
