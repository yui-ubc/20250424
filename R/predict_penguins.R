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
#' # Example of predicting penguin classes using a temporary model and data
#' model_path <- tempfile(fileext = ".rds")
#' test_data_path <- tempfile(fileext = ".rds")
#'
#' # Simulating saving a model and data for testing purposes
#' library(tidymodels)
#' data <- palmerpenguins::penguins %>% drop_na()
#' penguin_model <- nearest_neighbor(mode = "classification", neighbors = 5) %>%
#'   set_engine("kknn") %>%
#'   fit(species ~ ., data = data)
#' saveRDS(penguin_model, model_path)
#' saveRDS(data, test_data_path)
#'
#' # Now you can test the prediction function
#' predictions <- predict_penguin_classes(model_path, test_data_path)
predict_penguin_classes <- function(model_path, test_data_path) {
  library(tidyverse)
  library(tidymodels)

  penguin_fit <- readRDS(model_path)
  data <- readRDS(test_data_path)

  test_data <- split_data(data)$test_data


  predictions <- predict(penguin_fit, test_data, type = "class") %>%
    bind_cols(test_data)

  return(predictions)
}
