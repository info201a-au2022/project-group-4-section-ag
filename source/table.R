# Loading
library("readxl")
library("dplyr")
library("stringr")
# xlsx files

# dataset 1
my_data <- read_excel("./data/Effects_of_social_media_d1.xlsx")
#dataset 2
bd <- read_excel("./data/Bangladesh.xlsx")
# dataset 3
mental_data <- read_excel("./data/SM_on_Mental_Health.xls")

time_sm <- my_data %>% pull(`How much time do you spend on social media in a day?`) %>% str_sub(start = -7)
time_sm <- as.numeric(gsub(".*?([0-9]+).*", "\\1", time_sm)) %>% replace(is.na(.), 0)
time_ex <- my_data %>% pull(`How much time do you spend on physical activities in a day?`) %>% str_sub(start = -7)
time_ex <- as.numeric(gsub(".*?([0-9]+).*", "\\1", time_ex)) %>% replace(is.na(.), 0)
num_sm <- my_data %>% pull(`Which social media platform/s do you like the most or use the most?`) %>% strsplit(", ") %>% sapply(length)

num_of_entries <- my_data %>%
  group_by(`What is your age?`) %>%
  count() %>%
  pull(n)

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

# simplified bangladesh dataset
# bangladesh dataset: bangla
bangla <- data.frame(age= bd$`21. Please write your age in years (number).`, 
                     body_weight = bd$`30. Body weight (Kg)`, 
                     height = bd$`31. Height (m)`, 
                     time_on_sm = bd$`7. How much time do you spend daily in social media?`, 
                     friends_on_social_media = bd$`9. How many friends do you have on social media?`, 
                     personal_friends_on_sm = bd$`10. How many friends do you know personally in social media?`, 
                     if_sm_is_good_thing = bd$`14.Do you believe social media is a good thing?`, 
                     emotion_influence_by_other_post = bd$`17. Does your emotion get influenced by other's posts (success, failure, loss)?`, 
                     if_no_sm_better_mental_health = bd$`19. Do you think, your mental wellbeing would be better if you do not use social media?`, 
                     p30_feeling_down_depress_hopeless = bd$`2. In the last 30 days, feeling down, depressed or hopeless.`, 
                     p30_poor_appetite_over_eating = bd$`5. In the last 30 days, poor appetite or over-eating.`,
                     p30_worry_to_much = bd$`3. In the last 30 days, I am worrying too much about different things.`, 
                     p30_sleep_quality_rate = bd$`19. During the past month, how would you rate your sleep quality overall?`) %>%
  mutate(location = "bangladesh")


# combine the age, time on social media and location data from india and bangladesh dataset 
dataset2 <- data.frame(age = bangla$age, 
                       time_on_sm = bangla$time_on_sm, 
                       location = bangla$location)
dataset3 <- data.frame(age = mental_data$`Age Range`, 
                       time_on_sm = mental_data$`How much time did you spend in Social media during the Lockdown?`, 
                       location = "India")

ds2_3 <- rbind(dataset2, dataset3)
t_sm <- ds2_3$time_on_sm %>% str_sub(start = -7)
t_sm <- as.numeric(gsub(".*?([0-9]+).*", "\\1", t_sm)) %>% replace(is.na(.), 0)
ds2_3 <- ds2_3 %>%
  mutate(time_on_sm = t_sm)

#test code
#testt <- overall_datasets$age %>% unique()
#print(testt)

# three datasets 
# dataset 1: my_data <- read_excel("../data/Effects_of_social_media_d1.xlsx")
# dataset 2: bd <- read_excel("../data/Bangladesh.xlsx")
# dataset 3: mental_data <- read_excel("../data/SM_on_Mental_Health.xls")

# dataframe after wrangling 
my_data # all data about youth (came from dataset 1)
bangla_data <- bangla # selected data about social media from bangladesh dataset (came from dataset 2)
combined_data <- ds2_3 # age, time on social media, and locatioin datasets (came from dataset 2, 3)

replace <- bangla_data %>%
  select(p30_worry_to_much) %>%
  str_replace_all("Half days", "Half of days")
bangla_data <- bangla_data %>%
  mutate(p30_worry_too_much = str_replace_all(bangla_data$p30_worry_to_much, "Half days", "Half of days")) %>%
  select(-p30_worry_to_much)
