#### Preamble ####
# Purpose: Tests the clean dataset of top songs.
# Author: 
# Date: 2 April 2024
# Contact: 
# License: MIT
# Pre-requisites: 00-install_packages.R, 01-download_data.R,
# and 02-data_cleaning.R has been ran to install necessary packages,
# download raw data, and clean the data, respectively.
# NOTE: This script was checked through lintr for styling

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(testthat)

#### Test data ####
analysis_data <-
  read_parquet("data/analysis_data/playlists_analysis_data.parquet")

stopifnot(
  # If all the conditions in here are True, then it will return NULL
  # 1. hit_year is numeric
  class(analysis_data$hit_year) == "numeric",
  # 2. hit_year contains 2014, 2015, 2016, 2017, 2018, 2019, 2020,
  # 2021, 2022, 2023
  analysis_data$hit_year |> sort() |> unique() ==
    c(2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023),
  # 3. Check tempo is numeric
  class(analysis_data$tempo) == "numeric",
  # 4. tempo has a min number that is greater than 0
  analysis_data$tempo |> min() > 0,
  # 5. energy has a max number that is less than or equal to 1.0
  # (OLD) analysis_data$energy |> max() <= 1.0,
  # 6. Check loudness is numeric
  class(analysis_data$loudness) == "numeric",
  # 7. loudness has a min number that is equal or greater than -60
  analysis_data$loudness |> min() >= -60,
  # 8. loudness has a max number that is less than or equal to 0
  analysis_data$loudness |> max() <= 0,
  # 12. track_duration_ms is numeric
  class(analysis_data$track_duration_ms) == "numeric",
  # 13. track_duration_ms has a min number that is greater than 0
  analysis_data$track_duration_ms |> min() > 0,
  # 14. before_pandemic is numeric
  class(analysis_data$before_pandemic) == "numeric",
  # 15. before_pandemic's min is either 0 or 1
  analysis_data$before_pandemic |> min() %in% c(0, 1),
  # 16. before_pandemic's max is either 0 or 1
  analysis_data$before_pandemic |> max() %in% c(0, 1),
  # 17. major is numeric
  class(analysis_data$major) == "numeric",
  # 18. major's min is either 0 or 1
  analysis_data$major |> min() %in% c(0, 1),
  # 19. major's max is either 0 or 1
  analysis_data$major |> max() %in% c(0, 1),
  # 20. major is numeric
  class(analysis_data$major) == "numeric",
  # 21. major's min is either 0 or 1
  analysis_data$major |> min() %in% c(0, 1),
  # 22. major's max is either 0 or 1
  analysis_data$major |> max() %in% c(0, 1),
  # 23. minor is numeric
  class(analysis_data$minor) == "numeric",
  # 24. minor's min is either 0 or 1
  analysis_data$minor |> min() %in% c(0, 1),
  # 25. minor's max is either 0 or 1
  analysis_data$minor |> max() %in% c(0, 1)
)

# 26. mode_name's class is character
expect_equal(class(analysis_data$mode_name), "character")
# 27. mode_name's unique observations are: "major", "minor"
expect_equal(sort(unique(analysis_data$mode_name)),
             sort(c("major", "minor")))
# 28. key_mode's class is character
expect_equal(class(analysis_data$key_mode), "character")
# 29. key_mode's unique observations are "F minor", "F# major", "G# major",
# "A# minor", "C# minor", "C# major",
# "A major", "C major", "B major", "G major", "D major", "D# major",
# "C minor", "F major", "E minor", "E major", "G minor", "A minor",
# "B minor", "F# minor", "G# minor", "A# major", "D minor", "D# minor"
expect_equal(sort(unique(analysis_data$key_mode)),
             sort(c("F minor", "F# major", "G# major", "A# minor", "C# minor",
                    "C# major", "A major", "C major", "B major", "G major",
                    "D major", "D# major", "C minor", "F major", "E minor",
                    "E major", "G minor", "A minor", "B minor", "F# minor",
                    "G# minor", "A# major", "D minor", "D# minor")))

# 30. Check that there are 1000 observations in the dataset total
expect_length(analysis_data$hit_year, 1000)
