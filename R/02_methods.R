library(tidyverse)

data <- read_csv("data/penguins.csv")

glimpse(data)
summary_stats <- summarise(data, mean_bill_length = mean(bill_length_mm), mean_bill_depth = mean(bill_depth_mm))

saveRDS(summary_stats, "results/summary-stats.rds")

# Visualizations
penguin_plot <- ggplot(data, aes(x = species, y = bill_length_mm, fill = species)) +
  geom_boxplot() +
  theme_minimal()

ggsave("results/penguin_boxplot.png", penguin_plot, width = 6, height = 4, dpi = 300)

# Prepare data for modeling
data <- data %>%
  select(species, bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g) %>%
  mutate(species = as.factor(species))

saveRDS(data, "results/modeling-data.rds")
