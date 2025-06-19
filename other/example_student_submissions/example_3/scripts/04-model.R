#### Preamble ####
# Purpose: Models information about songs from Billboard Year-End Hot 100
# Author: 
# Date: 2 April 2024
# Contact: 
# License: MIT
# Pre-requisites: 00-install_packages.R, 01-download_data.R,
# 02-data_cleaning.R, and 03-test_data.R has been ran to install
# necessary packages, download raw data, and clean the data,
# and test the data, respectively.
# NOTE: This script was checked through lintr for styling


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)

set.seed(646)

#### Read data ####
analysis_data <-
  read_parquet("data/analysis_data/playlists_analysis_data.parquet")

### Model data ####

# Logistic regression model for hit song before 2020/pandemic
hit_song_model <-
  stan_glm(
    formula =
    before_pandemic ~ track_duration_ms + loudness + tempo + mode_name,
    data = analysis_data,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 646
  )

prior_summary(hit_song_model)

#### Save model ####
saveRDS(hit_song_model, file = "models/hit_song_model.rds")
