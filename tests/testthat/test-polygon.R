context("polygon")

test_that("polygon works", {
  rings <- list(list(
    c(-2.275543, 53.464547),
    c(-2.275543, 53.489271),
    c(-2.215118, 53.489271),
    c(-2.215118, 53.464547),
    c(-2.275543, 53.464547)
  ))
  a <- polygon(rings)
  b <- polygon(rings, properties = list(name = 'poly1', population = 400))

  expect_is(a, "polygon")
  expect_is(unclass(a), "list")
  expect_equal(a$type, "Feature")
  expect_is(a$geometry, "list")
  expect_is(a$geometry$coordinates, "array")
  expect_equal(length(a$geometry$coordinates), 10)
  expect_equal(length(a$properties), 0)

  expect_is(b, "polygon")
  expect_is(unclass(b), "list")
  expect_equal(b$type, "Feature")
  expect_is(b$geometry, "list")
  expect_is(b$properties, "list")
  expect_equal(length(b$properties), 2)

  # passing NULL gives empty polygon geometry
  expect_is(polygon(NULL), "polygon")
})

test_that("polygon fails correctly", {
  expect_error(polygon(), "argument \"rings\" is missing, with no default")
  expect_error(polygon(5), "Cannot read property")
  expect_error(polygon("stuff"), "First and last Position are not equivalent")
})
