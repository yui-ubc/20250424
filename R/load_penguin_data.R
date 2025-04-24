#' Load and Clean Penguin Data
#'
#' This function loads the penguin dataset, performs initial cleaning by removing
#' missing values, and saves the cleaned data to a CSV file.
#'
#' @param output_file The path where the cleaned CSV data should be saved. Defaults to "data/penguins.csv".
#'
#' @return A data frame of cleaned penguin data.
#' @export
#'
#' @examples
#' load_penguin_data("data/penguins.csv")
load_penguin_data <- function(output_file = "data/penguins.csv") {
  # Load required packages
  library(tidyverse)
  library(palmerpenguins)

  # Load the penguin data
  data <- penguins

  # Initial cleaning: Remove missing values
  data <- data %>% drop_na()

  # Save the cleaned data to a CSV file
  write_csv(data, output_file)

  # Return the cleaned data frame
  return(data)
}
