#### Preamble ####
# Purpose: Simulates data of songs from different playlists on Spotify.
# Author: 
# Date: 2 April 2024
# Contact: 
# License: MIT
# Pre-requisites: 00-install_packages.R has been ran to install necessary
# packages.
# NOTE: This script was checked through lintr for styling
#### Workspace setup ####
library(tidyverse)
library(testthat)

set.seed(646)

#### Simulate data ####
### Expected Columns: hit_year, track_duration_ms, tempo, loudness, mode_name,
### key_mode, period, before_pandemic, major, minor
num_of_top_songs <- 1000

simulated_data <-
  tibble(
    hit_year = sample(x = c(2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021,
                            2022, 2023), size = num_of_top_songs,
                      replace = TRUE),
    track_duration_ms = round(runif(num_of_top_songs, min = 0, max = 10000000)),
    tempo = runif(n = num_of_top_songs, min = 1, max = 10000000),
    loudness = runif(n = num_of_top_songs, min = -60, max = 0),
    mode_name = sample(x = c("minor", "major"), size = num_of_top_songs, replace
                       = TRUE),
    key_mode = sample(x = c("F minor", "F# major", "G# major", "A# minor",
                            "C# minor", "C# major", "A major", "C major",
                            "B major", "G major", "D major", "D# major",
                            "C minor", "F major", "E minor", "E major",
                            "G minor", "A minor", "B minor", "F# minor",
                            "G# minor", "A# major", "D minor", "D# minor"),
                      size = num_of_top_songs, replace = TRUE),
    period = sample(x = c("Before Pandemic", "During and After Pandemic"),
                    size = num_of_top_songs, replace = TRUE),
    before_pandemic = round(runif(n = num_of_top_songs, min = 0, max = 1)),
    major = round(runif(n = num_of_top_songs, min = 0, max = 1)),
    minor = round(runif(n = num_of_top_songs, min = 0, max = 1))
  )
#### Test simulated data ####
stopifnot(
  # If all the conditions in here are True, then it will return NULL
  # 1. hit_year is numeric
  class(simulated_data$hit_year) == "numeric",
  # 2. hit_year contains 2014, 2015, 2016, 2017, 2018, 2019,
  # 2020, 2021, 2022, 2023
  simulated_data$hit_year |> sort() |> unique() == c(2014, 2015, 2016, 2017,
                                                     2018, 2019, 2020, 2021,
                                                     2022, 2023),
  # 6. Check tempo is numeric
  class(simulated_data$tempo) == "numeric",
  # 7. tempo has a min number that is greater than 0
  simulated_data$tempo |> min() > 0,
  # 8. energy has a max number that is less than or equal to 1.0
  # (OLD) simulated_data$energy |> max() <= 1.0,
  # 9. Check loudness is numeric
  class(simulated_data$loudness) == "numeric",
  # 10. loudness has a min number that is equal or greater than -60
  simulated_data$loudness |> min() >= -60,
  # 11. loudness has a max number that is less than or equal to 0
  simulated_data$loudness |> max() <= 0,
  # 15. track_duration_ms is numeric
  class(simulated_data$track_duration_ms) == "numeric",
  # 16. track_duration_ms has a min number that is greater than 0
  simulated_data$track_duration_ms |> min() > 0,
  # 17. before_pandemic is numeric
  class(simulated_data$before_pandemic) == "numeric",
  # 18. before_pandemic's min is either 0 or 1
  simulated_data$before_pandemic |> min() %in% c(0, 1),
  # 19. before_pandemic's max is either 0 or 1
  simulated_data$before_pandemic |> max() %in% c(0, 1),
  # 20. major is numeric
  class(simulated_data$major) == "numeric",
  # 21. major's min is either 0 or 1
  simulated_data$major |> min() %in% c(0, 1),
  # 22. major's max is either 0 or 1
  simulated_data$major |> max() %in% c(0, 1),
  # 20. major is numeric
  class(simulated_data$major) == "numeric",
  # 21. major's min is either 0 or 1
  simulated_data$major |> min() %in% c(0, 1),
  # 22. major's max is either 0 or 1
  simulated_data$major |> max() %in% c(0, 1),
  # 23. minor is numeric
  class(simulated_data$minor) == "numeric",
  # 24. minor's min is either 0 or 1
  simulated_data$minor |> min() %in% c(0, 1),
  # 25. minor's max is either 0 or 1
  simulated_data$minor |> max() %in% c(0, 1)
)

# 26. mode_name's class is character
expect_equal(class(simulated_data$mode_name), "character")
# 27. mode_name's unique observations are: "major", "minor"
expect_equal(sort(unique(simulated_data$mode_name)), sort(c("major", "minor")))
# 28. key_mode's class is character
expect_equal(class(simulated_data$key_mode), "character")
# 29. key_mode's unique observations are "F minor", "F# major", "G# major",
# "A# minor", "C# minor", "C# major",
# "A major", "C major", "B major", "G major", "D major", "D# major",
# "C minor", "F major", "E minor", "E major", "G minor", "A minor",
# "B minor", "F# minor", "G# minor", "A# major", "D minor", "D# minor"
expect_equal(sort(unique(simulated_data$key_mode)),
             sort(c("F minor", "F# major", "G# major", "A# minor", "C# minor",
                    "C# major", "A major", "C major", "B major", "G major",
                    "D major", "D# major", "C minor", "F major", "E minor",
                    "E major", "G minor", "A minor", "B minor", "F# minor",
                    "G# minor", "A# major", "D minor", "D# minor")))

# 30. Check that there are 1000 observations in the dataset total
expect_length(simulated_data$hit_year, 1000)
