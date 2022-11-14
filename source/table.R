# Loading
library("readxl")
library("dplyr")
library("stringr")
# xlsx files
my_data <- read_excel("../data/Effects_of_social_media_d1.xlsx")
time_sm <- my_data %>% pull(`How much time do you spend on social media in a day?`) %>% str_sub(start = -7)
time_sm <- as.numeric(gsub(".*?([0-9]+).*", "\\1", time_sm)) %>% replace(is.na(.), 0)
time_ex <- my_data %>% pull(`How much time do you spend on physical activities in a day?`) %>% str_sub(start = -7)
time_ex <- as.numeric(gsub(".*?([0-9]+).*", "\\1", time_ex)) %>% replace(is.na(.), 0)
num_sm <- my_data %>% pull(`Which social media platform/s do you like the most or use the most?`) %>% strsplit(", ") %>% sapply(length)

num_of_entries <- my_data %>%
  group_by(`What is your age?`) %>%
  count() %>%
  pull(`What is your age?`)

final_table <- data.frame(age = as.integer(my_data$`What is your age?`), 
                          hours_on_social_media = time_sm, 
                          hours_on_exercise = time_ex, 
                          number_of_social_media_platforms = num_sm, 
                          inappropriate_content_degree = my_data$`How much do you feel that you are exposed to inappropriate content on these platforms (out of 10)?`)
final_table <- final_table %>%
  group_by(age) %>%
  summarise(time_on_social_media = round(mean(hours_on_social_media), digits = 2), 
            time_on_exercise = round(mean(hours_on_exercise), digits = 2), 
            number_of_social_media_platforms = round(mean(number_of_social_media_platforms), digits = 1), 
            inappropriate_content_degree = round(mean(inappropriate_content_degree), digits = 2)) %>%
  mutate(how_much_more_hours_spend_on_social_media_compared_to_exercise = time_on_social_media - time_on_exercise) 

final_table <- final_table %>%
  mutate(num_entries = num_of_entries) %>%
  select(age, 
         num_entries, 
         number_of_social_media_platforms, 
         inappropriate_content_degree, 
         time_on_social_media, 
         time_on_exercise, 
         how_much_more_hours_spend_on_social_media_compared_to_exercise)
final_table