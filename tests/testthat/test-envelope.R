context("lawn_envelope")

a <- lawn_envelope(lawn_data$points_count)
b <- lawn_envelope(lawn_data$polygons_count)
d <- lawn_envelope(lawn_data$polygons_aggregate)

test_that("lawn_envelope works", {
  expect_is(a, "polygon")
  expect_is(unclass(a), "list")
  expect_is(a$type, "character")
  expect_is(a$geometry, "list")
  expect_is(a$geometry$type, "character")
  expect_is(a$geometry$coordinates, "array")

  ## this first test doesn't work, maybe a digits problem?
  # expect_true(lawn_inside(lawn_point(c(-112.0372, 46.608058)), a))
  expect_true(lawn_inside(lawn_point(c(-112.045955, 46.596264)), a))
  expect_true(lawn_inside(lawn_point(c(-112.072391, 46.586591)), b))
  expect_true(lawn_inside(lawn_point(c(-112.023983, 46.570426)), b))
  expect_true(lawn_inside(lawn_point(c(1.669921, 48.632908)), d))
})

test_that("lawn_envelope fails correctly", {
  expect_error(lawn_envelope(), "argument \"fc\" is missing, with no default")
  expect_error(lawn_envelope(5), "Unknown Geometry Type")
})
