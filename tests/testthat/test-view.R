context("view")

skip_if_not_installed <- function(pkg) {
  if (requireNamespace(pkg, quietly = TRUE))
    return()
  testthat::skip(paste0(pkg, " not installed"))
}

# from character string  ----------------
test_that("view works with character input", {
  skip_if_not_installed("leaflet")

  ch1 <- view(lawn_data$polygons_average)
  ch2 <- view(lawn_data$filter_features)
  ch3 <- view(lawn_data$polygons_within)
  ch4 <- view(lawn_data$polygons_count)

  expect_is(ch1, c("leaflet", "htmlwidget"))
  expect_is(ch1$x, "list")
  expect_is(ch1$x$fitBounds, "list")
  expect_is(ch1$x$calls, "list")

  expect_is(ch2, c("leaflet", "htmlwidget"))
  expect_is(ch3, c("leaflet", "htmlwidget"))
  expect_is(ch4, c("leaflet", "htmlwidget"))
})

# from json (a jsonlite class) ----------------
suppressPackageStartupMessages(library("jsonlite", quietly = TRUE))
x <- jsonlite::minify(lawn_data$points_count)

test_that("view works with json input", {
  skip_if_not_installed("leaflet")

  json1 <- view(x)
  expect_is(json1, c("leaflet", "htmlwidget"))
  expect_is(json1$x, "list")
  expect_is(json1$x$fitBounds, "list")
  expect_is(json1$x$calls, "list")
})

# from a list (a single object)  ----------------
x <- jsonlite::fromJSON(lawn_data$polygons_average, FALSE)

test_that("view works with list input", {
  skip_if_not_installed("leaflet")

  list1 <- view(x)
  expect_is(list1, c("leaflet", "htmlwidget"))
  expect_is(list1$x, "list")
  expect_is(list1$x$fitBounds, "list")
  expect_is(list1$x$calls, "list")
})

# From a list of many objects  ----------------
x <- list(
 lawn_point(c(-75.343, 39.984), properties = list(name = 'Location A')),
 lawn_point(c(-75.833, 39.284), properties = list(name = 'Location B')),
 lawn_point(c(-75.534, 39.123), properties = list(name = 'Location C'))
)

test_that("view works with list of many objects input", {
  skip_if_not_installed("leaflet")

  listmany <- view(x)
  expect_is(listmany, c("leaflet", "htmlwidget"))
  expect_is(listmany$x, "list")
  expect_is(listmany$x$fitBounds, "list")
  expect_is(listmany$x$calls, "list")
})

# view_  --------------------------------

test_that("view_ works as expected", {
  skip_if_not_installed("leaflet")

  viewdots <- view_(
    lawn_point(c(-75.343, 39.984), properties = list(name = 'Location A')),
    lawn_point(c(-75.833, 39.284), properties = list(name = 'Location B')),
    lawn_point(c(-75.534, 39.123), properties = list(name = 'Location C'))
  )

  expect_is(viewdots, c("leaflet", "htmlwidget"))
  expect_is(viewdots$x, "list")
  expect_is(viewdots$x$fitBounds, "list")
  expect_is(viewdots$x$calls, "list")
})

# fails well -----------------------------
test_that("view fails correctly", {
  skip_if_not_installed("leaflet")

  # missing arguments
  expect_error(view(), "no applicable method")
  # wrong input
  expect_error(view("a"), "a is not defined")
  # no method for data.frame's
  expect_error(view(mtcars), "no applicable method")
})
