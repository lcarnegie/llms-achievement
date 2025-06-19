#### Preamble ####

# Purpose: Downloading and saving the City of Austin, Texas
# "2020 Racial Profiling (RP) dataset" (Austin Police Department 2023a).
# Author: 
# Date: April 18, 2024
# Contact: 
# Pre-requisites: Installation of the tidyverse (Wickham et al. 2019) package.
# Downloading of the dataset as per the "Data Access" section of the GitHub
# Repository's README file and uploading of the dataset to the GitHub
# Repository (since the dataset was unable to be directly downloaded from the
# original source).

#### Load Packages ####

# Installation of tidyverse: install.packages("tidyverse")
library(tidyverse)

#### Download Dataset ####

raw_profiling_data <-
  read_csv(file =
           "data/raw_data/2020_Racial_Profiling__RP__dataset_20240411.csv")

#### Save Dataset ####

write_csv(raw_profiling_data, "data/raw_data/raw_profiling_data.csv")
