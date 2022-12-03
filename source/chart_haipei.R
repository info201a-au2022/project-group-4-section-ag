library(tidyverse)
source("./source/table.R")
age_versus_number_of_sm_plot <- ggplot(data = final_table) +
  geom_point(mapping = aes(x = final_table$age, y = final_table$number_of_social_media_platforms), color = "#6F859E") +
  labs(x = "Age", y = "Number of Social Media", title = "The Number of Social Media Platforms of Youth Aged 14-23")
age_versus_number_of_sm_plot
