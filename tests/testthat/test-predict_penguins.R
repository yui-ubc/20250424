# tests/testthat/test-predict_penguin_classes.R

test_that("predict_penguin_classes returns predictions with correct structure", {
  skip_if_not_installed("palmerpenguins")
  library(tidymodels)
  library(palmerpenguins)

  # Prepare data
  data <- penguins %>% drop_na()

  # Fit and save model
  model <- nearest_neighbor(mode = "classification", neighbors = 5) %>%
    set_engine("kknn") %>%
    fit(species ~ ., data = data)

  model_path <- tempfile(fileext = ".rds")
  test_data_path <- tempfile(fileext = ".rds")

  saveRDS(model, model_path)
  saveRDS(data, test_data_path)

  # Run prediction
  predictions <- predict_penguin_classes(model_path, test_data_path)

  # Tests
  expect_s3_class(predictions, "tbl_df")
  expect_true("species" %in% colnames(predictions))
  expect_true(".pred_class" %in% colnames(predictions))
})

test_that("predict_penguin_classes handles invalid file paths", {
  expect_error(
    predict_penguin_classes("non_existent_model.rds", "non_existent_data.rds"),
    "cannot open the connection"
  )
})

test_that("predict_penguin_classes works with minimal dataset", {
  library(tidymodels)
  data <- palmerpenguins::penguins %>% drop_na() %>% slice(1:10)

  model <- nearest_neighbor(mode = "classification", neighbors = 3) %>%
    set_engine("kknn") %>%
    fit(species ~ ., data = data)

  model_path <- tempfile(fileext = ".rds")
  test_data_path <- tempfile(fileext = ".rds")

  saveRDS(model, model_path)
  saveRDS(data, test_data_path)

  predictions <- predict_penguin_classes(model_path, test_data_path)

  expect_equal(nrow(predictions), nrow(split_data(data)$test_data))
  expect_true(".pred_class" %in% names(predictions))
})
