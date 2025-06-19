#### Preamble ####

# Purpose: Testing the City of Austin, Texas "2020 Racial Profiling (RP)
# dataset" (Austin Police Department 2023a).
# Author: 
# Date: April 18, 2024
# Contact: 
# Pre-requisites: Installation of the tidyverse (Wickham et al. 2019) and
# arrow (Richardson et al. 2024) packages. Running of the files titled
# "01-download_data.R" and "02-data_cleaning.R".

#### Load Packages ####

# Installation of tidyverse: install.packages("tidyverse")
# This method of installing the arrow package was obtained from:
# https://github.com/apache/arrow/issues/41050
# Installation of arrow: install.packages("arrow",
#                                         repos =
#                                         c("https://apache.r-universe.dev"))
library(tidyverse)
library(arrow)

#### Test Dataset ####

# Portions of the code below were adapted based on Alexander (2023).
# The tests below were adapted from the file titled "00-simulate_data.R".

# Loading the cleaned dataset
cleaned_profiling_data <-
  read_parquet("data/analysis_data/cleaned_profiling_data.parquet")

# Verifying the class of each column
cleaned_profiling_data$type |> class() == "character"
cleaned_profiling_data$sex |> class() == "factor"
cleaned_profiling_data$race |> class() == "factor"
cleaned_profiling_data$search |> class() == "factor"
cleaned_profiling_data$custody |> class() == "factor"
cleaned_profiling_data$male |> class() == "numeric"
cleaned_profiling_data$female |> class() == "numeric"
cleaned_profiling_data$asian |> class() == "numeric"
cleaned_profiling_data$black |> class() == "numeric"
cleaned_profiling_data$white |> class() == "numeric"
cleaned_profiling_data$hawaiian_or_pacific_islander |> class() == "numeric"
cleaned_profiling_data$middle_eastern |> class() == "numeric"
cleaned_profiling_data$hispanic_or_latino |> class() == "numeric"
cleaned_profiling_data$american_indian_or_alaskan_native |>
  class() == "numeric"
cleaned_profiling_data$search_binary |> class() == "numeric"
cleaned_profiling_data$custody_binary |> class() == "numeric"

# Verifying the contents of each column
sort(unique(cleaned_profiling_data$type |> na.omit())) == sort(c("Arrests"))
sort(unique(cleaned_profiling_data$sex |> na.omit())) == factor(c("Female",
                                                                  "Male"))
sort(unique(cleaned_profiling_data$race |> na.omit())) ==
  factor(c("White", "Asian", "Black",
           "Hawaiian/Pacific Islander", "Middle Eastern", "Hispanic or Latino",
           "American Indian/Alaskan Native"))
sort(unique(cleaned_profiling_data$search |> na.omit())) == factor(c("No",
                                                                     "Yes"))
sort(unique(cleaned_profiling_data$custody |> na.omit())) ==
  factor(c("Non-Custody", "Custody"))
sort(unique(cleaned_profiling_data$male |> na.omit())) == sort(c(0, 1))
sort(unique(cleaned_profiling_data$female |> na.omit())) == sort(c(0, 1))
sort(unique(cleaned_profiling_data$asian |> na.omit())) == sort(c(0, 1))
sort(unique(cleaned_profiling_data$black |> na.omit())) == sort(c(0, 1))
sort(unique(cleaned_profiling_data$white |> na.omit())) == sort(c(0, 1))
sort(unique(cleaned_profiling_data$hawaiian_or_pacific_islander |>
              na.omit())) == sort(c(0, 1))
sort(unique(cleaned_profiling_data$middle_eastern |> na.omit())) ==
  sort(c(0, 1))
sort(unique(cleaned_profiling_data$hispanic_or_latino |> na.omit())) ==
  sort(c(0, 1))
sort(unique(cleaned_profiling_data$american_indian_or_alaskan_native |>
              na.omit())) == sort(c(0, 1))
sort(unique(cleaned_profiling_data$search_binary |> na.omit())) ==
  sort(c(0, 1))
sort(unique(cleaned_profiling_data$custody_binary |> na.omit())) ==
  sort(c(0, 1))
