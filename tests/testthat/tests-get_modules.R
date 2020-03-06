context("retrieve modules")

modules <- get_modules()

test_that("Retrieve modules", {
  expect_equal(class(modules), "list")
  expect_equal(length(modules), 8)
  expect_true("upload" %in% names(modules))
  expect_true("recruitplot" %in% names(modules))
  expect_true("recruittable" %in% names(modules))
  expect_true("recruitplot" %in% names(modules))
  expect_true("formcomplete" %in% names(modules))
  expect_true("visitplan" %in% names(modules))
  expect_true("monitorcn" %in% names(modules))
  expect_true("recruitplot" %in% names(modules))
  expect_true("export" %in% names(modules))
})
