library(tidyverse)
source("./source/table.R")
social_media_versus_exercise_plot <- ggplot(data = final_table) +
  geom_col(mapping = aes(x = final_table$age, y = final_table$how_much_more_hours_spend_on_social_media_compared_to_exercise), color = "#C4961A", fill = "#FFDB6D") +
  labs(x = "Age", y = "Hours", title = "Difference Between Time spend Social Media and Exercises for Young People in Various Age")
social_media_versus_exercise_plot