#### Preamble ####

# Purpose: Simulating data related to the City of Austin, Texas
# "2020 Racial Profiling (RP) dataset" (Austin Police Department 2023a).
# Author: 
# Date: April 18, 2024
# Contact: 
# Pre-requisites: Installation of the tidyverse (Wickham et al. 2019) and
# janitor (Firke 2023) packages.

#### Load Packages ####

# Installation of tidyverse: install.packages("tidyverse")
# Installation of janitor: install.packages("janitor")
library(tidyverse)
library(janitor)

#### Simulate Data ####

# Portions of the code below were adapted based on Alexander (2023).

# To make this code reproducible, a seed is set
set.seed(3)

# Simulating a total of 1,000 entries
simulated_profiling_data <-
  tibble(type = rep("Arrests", 1000),
         sex = sample(x = c("Male", "Female"),
                      size = 1000,
                      replace = TRUE),
         race = sample(x = c("Asian",
                             "Black",
                             "White",
                             "Hawaiian/Pacific Islander",
                             "Middle Eastern",
                             "Hispanic or Latino",
                             "American Indian/Alaskan Native"),
                       size = 1000,
                       replace = TRUE),
         search = sample(x = c("Yes", "No"),
                         size = 1000,
                         replace = TRUE),
         custody = sample(x = c("Custody", "Non-Custody"),
                          size = 1000,
                          replace = TRUE))

# Creating columns to make binary variables for the characteristics
simulated_profiling_data <- simulated_profiling_data |>
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

# Converting columns to factors
simulated_profiling_data <- simulated_profiling_data |>
  mutate(sex = as_factor(sex),
         race = as_factor(race),
         search = as_factor(search),
         custody = as_factor(custody))

#### Test Simulated Data ####

# Portions of the code below were adapted based on Alexander (2023).

# Verifying the class of each column
simulated_profiling_data$type |> class() == "character"
simulated_profiling_data$sex |> class() == "factor"
simulated_profiling_data$race |> class() == "factor"
simulated_profiling_data$search |> class() == "factor"
simulated_profiling_data$custody |> class() == "factor"
simulated_profiling_data$male |> class() == "numeric"
simulated_profiling_data$female |> class() == "numeric"
simulated_profiling_data$asian |> class() == "numeric"
simulated_profiling_data$black |> class() == "numeric"
simulated_profiling_data$white |> class() == "numeric"
simulated_profiling_data$hawaiian_or_pacific_islander |> class() == "numeric"
simulated_profiling_data$middle_eastern |> class() == "numeric"
simulated_profiling_data$hispanic_or_latino |> class() == "numeric"
simulated_profiling_data$american_indian_or_alaskan_native |>
  class() == "numeric"
simulated_profiling_data$search_binary |> class() == "numeric"
simulated_profiling_data$custody_binary |> class() == "numeric"

# Verifying the contents of each column
sort(unique(simulated_profiling_data$type |> na.omit())) == sort(c("Arrests"))
sort(unique(simulated_profiling_data$sex |> na.omit())) == factor(c("Male",
                                                                    "Female"))
sort(unique(simulated_profiling_data$race |> na.omit())) ==
  factor(c("Middle Eastern", "Hispanic or Latino", "Hawaiian/Pacific Islander",
           "White", "Asian", "American Indian/Alaskan Native", "Black"))
sort(unique(simulated_profiling_data$search |> na.omit())) == factor(c("No",
                                                                       "Yes"))
sort(unique(simulated_profiling_data$custody |> na.omit())) ==
  factor(c("Non-Custody", "Custody"))
sort(unique(simulated_profiling_data$male |> na.omit())) == sort(c(0, 1))
sort(unique(simulated_profiling_data$female |> na.omit())) == sort(c(0, 1))
sort(unique(simulated_profiling_data$asian |> na.omit())) == sort(c(0, 1))
sort(unique(simulated_profiling_data$black |> na.omit())) == sort(c(0, 1))
sort(unique(simulated_profiling_data$white |> na.omit())) == sort(c(0, 1))
sort(unique(simulated_profiling_data$hawaiian_or_pacific_islander |>
              na.omit())) == sort(c(0, 1))
sort(unique(simulated_profiling_data$middle_eastern |> na.omit())) ==
  sort(c(0, 1))
sort(unique(simulated_profiling_data$hispanic_or_latino |> na.omit())) ==
  sort(c(0, 1))
sort(unique(simulated_profiling_data$american_indian_or_alaskan_native |>
              na.omit())) == sort(c(0, 1))
sort(unique(simulated_profiling_data$search_binary |> na.omit())) ==
  sort(c(0, 1))
sort(unique(simulated_profiling_data$custody_binary |> na.omit())) ==
  sort(c(0, 1))
