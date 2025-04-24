source("R/predict_penguins.R")

predictions <- predict_penguin_classes(
  model_path = "results/model-fit.rds",
  test_data_path = "results/test-data.rds"
)

conf_mat <- conf_mat(predictions, truth = species, estimate = .pred_class)
conf_mat

saveRDS(conf_mat, "results/conf-mat.rds")
