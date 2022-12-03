library(dplyr)
library(readxl)

my_data <- read_excel("./data/Effects_of_social_media_d1.xlsx")
View(my_data)
summary_info <- list()

summary_info$num_observations <- nrow(my_data)

summary_info$min_age <- my_data %>%
  filter(`What is your age?` == min(`What is your age?`, na.rm = T)) %>%
  select(`What is your age?`, `What is your age?`)

summary_info$max_age <- my_data %>%
  filter(`What is your age?` == max(`What is your age?`, na.rm = T)) %>%
  select(`What is your age?`, `What is your age?`)

summary_info$inappropriate_platforms <- my_data %>%
  filter(`How much do you feel that you are exposed to inappropriate content on these platforms (out of 10)?` == max(`How much do you feel that you are exposed to inappropriate content on these platforms (out of 10)?`, na.rm = T)) %>%
  select(`Which social media platform/s do you like the most or use the most?`)

summary_info$inappropriate_content_timeframe <- my_data %>%
  filter(`How much do you feel that you are exposed to inappropriate content on these platforms (out of 10)?` == max(`How much do you feel that you are exposed to inappropriate content on these platforms (out of 10)?`, na.rm = T)) %>%
  select(`How much time do you spend on social media in a day?`)

summary_info$old_gen_preferred_comm <- my_data %>%
  filter(`What is your age?` == max(`What is your age?`, na.rm = T)) %>%
  select(`Which type of communication do you generally prefer?`)

View(summary_info)