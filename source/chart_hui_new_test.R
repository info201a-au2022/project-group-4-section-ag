library(tidyverse)
source("../source/table.R")
cleaned_data <- ds2_3 %>% 
  group_by(age) %>% 
  summarise(time_on_sm = mean(time_on_sm)) %>% 
  arrange(age) %>% 
  slice(-c(1,7,9,10,11,12,16,23,28,38)) %>% 
  as.data.frame()

age_versus_inappropriate_content_degree <- ggplot(data = cleaned_data) +
  geom_line(mapping = aes(x = cleaned_data$age, y = cleaned_data$time_on_sm)) +
  labs(x = "Age", y = "Hours", title = "Age and Hours")
age_versus_inappropriate_content_degree
