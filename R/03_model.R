library(tidymodels)

set.seed(123)

data <- readRDS("results/modeling-data.rds")

data_split <- initial_split(data, strata = species)
train_data <- training(data_split)
test_data <- testing(data_split)

saveRDS(train_data, "results/train-data.rds")
saveRDS(test_data, "results/test-data.rds")


# Define model
penguin_model <- nearest_neighbor(mode = "classification", neighbors = 5) %>%
  set_engine("kknn")

# Create workflow
penguin_workflow <- workflow() %>%
  add_model(penguin_model) %>%
  add_formula(species ~ .)

# Fit model
penguin_fit <- penguin_workflow %>%
  fit(data = train_data)

saveRDS(penguin_fit, "results/model-fit.rds")
