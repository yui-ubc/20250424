# tests/testthat/test-split_data.R

test_that("split_data returns a list with train_data and test_data", {
  skip_if_not_installed("palmerpenguins")
  library(palmerpenguins)
  data <- penguins %>% tidyr::drop_na()

  result <- split_data(data)

  expect_type(result, "list")
  expect_named(result, c("train_data", "test_data"))
  expect_s3_class(result$train_data, "data.frame")
  expect_s3_class(result$test_data, "data.frame")
})

test_that("split_data returns reproducible splits with same seed", {
  skip_if_not_installed("palmerpenguins")
  library(palmerpenguins)
  data <- penguins %>% tidyr::drop_na()

  split1 <- split_data(data, seed = 42)
  split2 <- split_data(data, seed = 42)

  expect_equal(split1$train_data, split2$train_data)
  expect_equal(split1$test_data, split2$test_data)
})

test_that("split_data returns different results with different seeds", {
  skip_if_not_installed("palmerpenguins")
  library(palmerpenguins)
  data <- penguins %>% tidyr::drop_na()

  split1 <- split_data(data, seed = 123)
  split2 <- split_data(data, seed = 456)

  expect_false(identical(split1$train_data, split2$train_data))
  expect_false(identical(split1$test_data, split2$test_data))
})


test_that("split_data works with a different stratify variable", {
  skip_if_not_installed("palmerpenguins")
  library(palmerpenguins)
  data <- penguins %>% tidyr::drop_na()

  result <- split_data(data, stratify_var = "island")
  expect_named(result, c("train_data", "test_data"))
})
