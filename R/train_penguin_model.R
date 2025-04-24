#' Split Data into Training and Test Sets
#'
#' This function splits a dataset into training and testing sets using stratified sampling
#' based on a specified variable (default is `"species"`). It ensures reproducibility by
#' setting a random seed.
#'
#' @param data A data frame or tibble containing the data to split.
#' @param stratify_var A character string specifying the variable to stratify by.
#'   Default is `"species"`.
#' @param seed An integer to set the random seed for reproducibility. Default is `123`.
#'
#' @return A list containing:
#' \describe{
#'   \item{train_data}{A data frame of the training data.}
#'   \item{test_data}{A data frame of the test data.}
#' }
#'
#' @examples
#' # Assuming `penguins` dataset is available
#' split <- split_data(penguins)
#' head(split$train_data)
#' head(split$test_data)
#'
#' @export
split_data <- function(data, stratify_var = "species", seed = 123) {
  set.seed(seed)
  library(tidymodels)
  data_split <- initial_split(data, strata = stratify_var)
  list(
    train_data = training(data_split),
    test_data = testing(data_split)
  )
}
