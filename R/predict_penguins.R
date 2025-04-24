#' Generate Predictions from Fitted Penguin Model
#'
#' Loads a fitted model and test dataset, makes class predictions,
#' and returns the test data with appended predictions.
#'
#' @param model_path Path to the RDS file containing the fitted model.
#' @param test_data_path Path to the RDS file containing the test dataset.
#'
#' @return A tibble with predictions and original test data.
#' @export
#'
#' @examples
#' predictions <- predict_penguin_classes("results/model-fit.rds", "results/test-data.rds")
predict_penguin_classes <- function(model_path, test_data_path) {
  library(tidyverse)
  library(tidymodels)

  penguin_fit <- readRDS(model_path)
  test_data <- readRDS(test_data_path)

  predictions <- predict(penguin_fit, test_data, type = "class") %>%
    bind_cols(test_data)

  return(predictions)
}
