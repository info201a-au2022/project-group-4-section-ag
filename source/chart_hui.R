library(tidyverse)
source("./source/table.R")
age_versus_inappropriate_content_degree <- ggplot(data = final_table) +
  geom_line(mapping = aes(x = final_table$age, y = final_table$inappropriate_content_degree), color = "#4cc1cc", fill = "#9428de") +
  labs(x = "Age", y = "Degree of Severity", title = "Age and the Degree of Severity in Inappropriate Content")
age_versus_inappropriate_content_degree
