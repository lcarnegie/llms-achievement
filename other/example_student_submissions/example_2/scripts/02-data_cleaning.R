#### Preamble ####

# Purpose: Cleaning the City of Austin, Texas "2020 Racial Profiling (RP)
# dataset" (Austin Police Department 2023a).
# Author: 
# Date: April 18, 2024
# Contact: 
# Pre-requisites: Installation of the tidyverse (Wickham et al. 2019) and
# arrow (Richardson et al. 2024) packages. Running of the file titled
# "01-download_data.R".

#### Load Packages ####

# Installation of tidyverse: install.packages("tidyverse")
# This method of installing the arrow package was obtained from:
# https://github.com/apache/arrow/issues/41050
# Installation of arrow: install.packages("arrow",
#                                         repos =
#                                         c("https://apache.r-universe.dev"))
library(tidyverse)
library(arrow)

#### Clean Dataset ####

# Loading the raw data
raw_profiling_data <- read_csv("data/raw_data/raw_profiling_data.csv")

# Choosing only the columns that are needed
cleaned_profiling_data <- raw_profiling_data |>
  select(Type, `TCOLE Sex`, `Standardized Race`, `Search Yes or No`, Custody)

# Renaming columns in the dataset
cleaned_profiling_data <- cleaned_profiling_data |>
  rename(type = Type,
         sex = `TCOLE Sex`,
         race = `Standardized Race`,
         search = `Search Yes or No`,
         custody = Custody)

# Renaming entries in the dataset
cleaned_profiling_data <- cleaned_profiling_data |>
  mutate(sex =
           case_match(sex,
                      "M" ~ "Male",
                      "F" ~ "Female")) |>
  mutate(race =
           case_match(race,
                      "ASIAN" ~ "Asian",
                      "BLACK" ~ "Black",
                      "WHITE" ~ "White",
                      "HAWAIIAN/PACIFIC ISLANDER" ~ "Hawaiian/Pacific Islander",
                      "MIDDLE EASTERN" ~ "Middle Eastern",
                      "HISPANIC OR LATINO" ~ "Hispanic or Latino",
                      "AMERICAN INDIAN/ALASKAN NATIVE" ~
                        "American Indian/Alaskan Native")) |>
  mutate(search =
           case_match(search,
                      "YES = 1" ~ "Yes",
                      "NO = 2" ~ "No")) |>
  mutate(custody =
           case_match(custody,
                      "custody" ~ "Custody",
                      "non-custody" ~ "Non-Custody"))

# Adding columns to the dataset
cleaned_profiling_data <- cleaned_profiling_data |>
  mutate(male = if_else(sex == "Male", 1, 0),
         female = if_else(sex == "Female", 1, 0),
         asian = if_else(race == "Asian", 1, 0),
         black = if_else(race == "Black", 1, 0),
         white = if_else(race == "White", 1, 0),
         hawaiian_or_pacific_islander =
           if_else(race == "Hawaiian/Pacific Islander", 1, 0),
         middle_eastern = if_else(race == "Middle Eastern", 1, 0),
         hispanic_or_latino = if_else(race == "Hispanic or Latino", 1, 0),
         american_indian_or_alaskan_native =
           if_else(race == "American Indian/Alaskan Native", 1, 0),
         search_binary = if_else(search == "Yes", 1, 0),
         custody_binary = if_else(custody == "Custody", 1, 0))

# Filtering entries in the dataset
cleaned_profiling_data <- cleaned_profiling_data |>
  filter(type == "Arrests") |>
  filter(!is.na(sex)) |>
  filter(!is.na(custody)) |>
  filter(!is.na(male)) |>
  filter(!is.na(female)) |>
  filter(!is.na(custody_binary))

# Converting columns to factors
cleaned_profiling_data <- cleaned_profiling_data |>
  mutate(sex = as_factor(sex),
         race = as_factor(race),
         search = as_factor(search),
         custody = as_factor(custody),
         sex = factor(
           sex,
           levels = c(
             "Female",
             "Male"
           )
         ),
         race = factor(
           race,
           levels = c(
             "White",
             "Asian",
             "Black",
             "Hawaiian/Pacific Islander",
             "Middle Eastern",
             "Hispanic or Latino",
             "American Indian/Alaskan Native"
           )
         ),
         search = factor(
           search,
           levels = c(
             "No",
             "Yes"
           )
         ),
         custody = factor(
           custody,
           levels = c(
             "Non-Custody",
             "Custody"
           )
         ))

#### Save Cleaned Dataset ####

write_parquet(cleaned_profiling_data,
              "data/analysis_data/cleaned_profiling_data.parquet")
