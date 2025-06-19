#### Preamble ####

# Purpose: Modeling whether an individual underwent a custody arrest
# based on their sex, race, and whether a search was performed using
# the City of Austin, Texas "2020 Racial Profiling (RP) dataset" (Austin Police
# Department 2023a).
# Author: 
# Date: April 18, 2024
# Contact: 
# Pre-requisites: Installation of the tidyverse (Wickham et al. 2019), arrow
# (Richardson et al. 2024), and rstanarm (Goodrich et al. 2024) packages.
# Running of the files titled "01-download_data.R" and "02-data_cleaning.R".

#### Load Packages ####

# Installation of tidyverse: install.packages("tidyverse")
# This method of installing the arrow package was obtained from:
# https://github.com/apache/arrow/issues/41050
# Installation of arrow: install.packages("arrow",
#                                         repos =
#                                         c("https://apache.r-universe.dev"))
# Installation of rstanarm: install.packages("rstanarm")
library(tidyverse)
library(arrow)
library(rstanarm)

#### Load Data ####

cleaned_profiling_data <-
  read_parquet("data/analysis_data/cleaned_profiling_data.parquet")

### Model Data ####

# To make this code reproducible, a seed is set
set.seed(3)

# Storing the model
profiling_model <-
  stan_glm(
    formula = custody ~ sex + race + search,
    data = cleaned_profiling_data,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 3
  )

#### Save Model ####

saveRDS(
  profiling_model,
  file = "models/profiling_model.rds"
)
