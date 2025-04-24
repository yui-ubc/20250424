#' Train a k-NN Classification Model on Penguin Data
#'
#' This function loads modeling-ready penguin data, splits it into training and testing sets,
#' defines and fits a k-nearest neighbors classification model using `tidymodels`,
#' and saves the model and datasets as RDS files for future use.
#'
#' @param input_file Path to the RDS file containing the preprocessed penguin dataset.
#' @param output_dir Directory to save the output RDS files (train/test data and model).
#' @param seed Random seed for reproducibility. Default is 123.
#' @param neighbors Number of neighbors to use in the k-NN model. Default is 5.
#'
#' @return A list containing the fitted model (`model`), training data (`train`), and testing data (`test`).
#'
#' @examples
#' \dontrun{
#' train_penguin_model("results/modeling-data.rds", "results")
#' }
#'
#' @import tidymodels
#' @export
train_penguin_model <- function(input_file = "results/modeling-data.rds",
                                output_dir = "results",
                                seed = 123,
                                neighbors = 5) {
  library(tidymodels)

  # Set seed for reproducibility
  set.seed(seed)

  # Load modeling-ready data
  data <- readRDS(input_file)

  # Split data
  data_split <- initial_split(data, strata = species)
  train_data <- training(data_split)
  test_data <- testing(data_split)

  # Save splits
  saveRDS(train_data, file.path(output_dir, "train-data.rds"))
  saveRDS(test_data, file.path(output_dir, "test-data.rds"))

  # Define k-NN model
  penguin_model <- nearest_neighbor(mode = "classification", neighbors = neighbors) %>%
    set_engine("kknn")

  # Create workflow
  penguin_workflow <- workflow() %>%
    add_model(penguin_model) %>%
    add_formula(species ~ .)

  # Fit model
  penguin_fit <- penguin_workflow %>%
    fit(data = train_data)

  # Save fitted model
  saveRDS(penguin_fit, file.path(output_dir, "model-fit.rds"))

  return(list(model = penguin_fit, train = train_data, test = test_data))
}
