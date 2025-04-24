test_that("process_penguin_data works as expected", {
  library(tidyverse)

  # Create temporary input and output
  temp_input <- tempfile(fileext = ".csv")
  temp_output <- tempdir()

  # Create sample data
  sample_data <- tibble(
    species = c("Adelie", "Chinstrap", "Gentoo"),
    bill_length_mm = c(39.1, 46.5, 50.0),
    bill_depth_mm = c(18.7, 17.5, 15.0),
    flipper_length_mm = c(181, 195, 210),
    body_mass_g = c(3750, 3800, 5000)
  )

  write_csv(sample_data, temp_input)

  # Run function
  result <- process_penguin_data(input_file = temp_input, output_dir = temp_output)

  # Check that output is a list with expected names
  expect_type(result, "list")
  expect_named(result, c("summary", "model_data"))

  # Check summary stats
  expected_summary <- sample_data %>%
    summarise(
      mean_bill_length = mean(bill_length_mm),
      mean_bill_depth = mean(bill_depth_mm)
    )
  expect_equal(result$summary, expected_summary)

  # Check modeling data structure
  expect_true(all(c("species", "bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g") %in%
                    names(result$model_data)))
  expect_s3_class(result$model_data$species, "factor")

  # Check files were saved
  expect_true(file.exists(file.path(temp_output, "summary-stats.rds")))
  expect_true(file.exists(file.path(temp_output, "modeling-data.rds")))
  expect_true(file.exists(file.path(temp_output, "penguin_boxplot.png")))
})
