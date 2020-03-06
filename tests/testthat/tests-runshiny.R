context("Run shiny")

shiny_app <- run_shiny()

test_that("Run shiny", {
  expect_equal(class(shiny_app), "shiny.appobj")
})
