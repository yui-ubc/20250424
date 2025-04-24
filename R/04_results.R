library(tidyverse)
library(tidymodels)

penguin_fit <- readRDS("results/model-fit.rds")
test_data <- readRDS("results/test-data.rds")

predictions <- predict(penguin_fit, test_data, type = "class") %>%
  bind_cols(test_data)

# Confusion matrix
conf_mat <- conf_mat(predictions, truth = species, estimate = .pred_class)
conf_mat

saveRDS(conf_mat, "results/conf-mat.rds")
