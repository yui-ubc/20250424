source("R/predict_penguins.R")
source("R/train_penguin_model.R")

data <- readRDS("results/modeling-data.rds")

predictions <- predict_penguin_classes(
  model_path = "results/model-fit.rds",
  test_data_path = "results/test-data.rds"
)
test_data <- split_data(data)$test_data

conf_mat <- conf_mat(predictions, truth = species, estimate = .pred_class)
conf_mat

saveRDS(conf_mat, "results/conf-mat.rds")
