library(tidyverse)

source("R/process_penguin_data.R")
#library(peng)
output <- process_penguin_data("data/penguins.csv", "results")
