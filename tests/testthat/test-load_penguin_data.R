test_that("load_penguin_data saves cleaned data correctly", {
  # Temporary file path for the cleaned data
  temp_file <- tempfile(fileext = ".csv")

  # Call the load_penguin_data function
  cleaned_data <- load_penguin_data(temp_file)

  # Check that the output is a data frame
  expect_s3_class(cleaned_data, "data.frame")

  # Check that the file was created and is not empty
  expect_true(file.exists(temp_file))
  expect_gt(file.info(temp_file)$size, 0)

  # Check if the cleaned data has no missing values
  expect_false(any(is.na(cleaned_data)))

  # Cleanup: Remove the temporary file
  unlink(temp_file)
})
