#' Process and Summarize Penguin Data
#'
#' This function loads cleaned penguin data, summarizes it, creates a boxplot,
#' and saves all relevant outputs for further modeling.
#'
#' @param input_file Path to the CSV file containing cleaned penguin data.
#' @param output_dir Directory path where results will be saved (RDS and PNG).
#'
#' @return A list containing the summary statistics and modeling dataset.
#' @export
process_penguin_data <- function(input_file = "data/penguins.csv",
                                 output_dir = "results") {
  library(tidyverse)

  # Load data
  data <- read_csv(input_file)

  # Glimpse the data
  glimpse(data)

  # Summarize data
  summary_stats <- summarise(
    data,
    mean_bill_length = mean(bill_length_mm, na.rm = TRUE),
    mean_bill_depth = mean(bill_depth_mm, na.rm = TRUE)
  )

  # Save summary statistics
  saveRDS(summary_stats, file.path(output_dir, "summary-stats.rds"))

  # Create and save boxplot
  penguin_plot <- ggplot(data, aes(x = species, y = bill_length_mm, fill = species)) +
    geom_boxplot() +
    theme_minimal()

  ggsave(filename = file.path(output_dir, "penguin_boxplot.png"),
         plot = penguin_plot,
         width = 6, height = 4, dpi = 300)

  # Prepare data for modeling
  modeling_data <- data %>%
    select(species, bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g) %>%
    mutate(species = as.factor(species))

  # Save modeling-ready data
  saveRDS(modeling_data, file.path(output_dir, "modeling-data.rds"))

  # Return output as a list
  return(list(summary = summary_stats, model_data = modeling_data))
}
