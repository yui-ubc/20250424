library(tidyverse)
library(palmerpenguins)

data <- penguins

# Initial cleaning: Remove missing values
data <- data %>% drop_na()

write_csv(data, "data/penguins.csv")
