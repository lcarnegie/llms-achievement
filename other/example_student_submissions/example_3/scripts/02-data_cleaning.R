#### Preamble ####
# Purpose: Cleans the dataset on Spotify playlists and outputs a parquet file.
# Author: 
# Date: 2 April 2024
# Contact: 
# License: MIT
# Pre-requisites: 00-install_packages.R and 01-download_data.R has been ran
# to install necessary packages and download raw data.
# NOTE: This script was checked through lintr for styling

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(arrow)
library(dplyr)

#### Clean data ####
# Read in raw data
raw_data <- read_csv("data/raw_data/raw_playlists_data.csv",
                     show_col_types = FALSE)

# Clean column names
cleaned_data <-
  raw_data |>
  clean_names()

# Select columns: playlist_name, track_name, track_album_name,
# track_duration_ms, tempo, loudness, mode_name, key_mode
cleaned_data <-
  cleaned_data |>
  select(playlist_name, track_name, track_album_name,
         track_duration_ms, tempo, loudness, mode_name, key_mode)

# Create hit_year, period, before_pandemic, major, and minor columns
# and remove playlist_name column
cleaned_data <-
  cleaned_data |>
  mutate(
    hit_year = case_when(
      (playlist_name == "2014 Billboard Year End Hot 100") ~ 2014,
      (playlist_name == "2015 Billboard Year End Hot 100") ~ 2015,
      (playlist_name == "2016 Billboard Year End Hot 100") ~ 2016,
      (playlist_name == "2017 Billboard Year End Hot 100") ~ 2017,
      (playlist_name == "Billboard Year-End Hot 100: 2018") ~ 2018,
      (playlist_name == "Billboard Year-End Hot 100: 2019") ~ 2019,
      (playlist_name == "Billboard Year-End Hot 100: 2020") ~ 2020,
      (playlist_name == "Billboard Year-End Hot 100: 2021") ~ 2021,
      (playlist_name == "Billboard Year-End Hot 100: 2022") ~ 2022,
      (playlist_name == "Billboard Year-End Hot 100: 2023") ~ 2023,
      TRUE ~ 0
    )
  ) |>
  mutate(
    period = case_when(
      (hit_year == "2014") ~ "Before Pandemic",
      (hit_year == "2015") ~ "Before Pandemic",
      (hit_year == "2016") ~ "Before Pandemic",
      (hit_year == "2017") ~ "Before Pandemic",
      (hit_year == "2018") ~ "Before Pandemic",
      (hit_year == "2019") ~ "Before Pandemic",
      (hit_year == "2020") ~ "During and After Pandemic",
      (hit_year == "2021") ~ "During and After Pandemic",
      (hit_year == "2022") ~ "During and After Pandemic",
      (hit_year == "2023") ~ "During and After Pandemic",
      TRUE ~ "None"
    )
  ) |>
  mutate(
    before_pandemic = case_when((period == "Before Pandemic") ~ 1,
                                (period == "During and After Pandemic")
                                ~ 0,
                                TRUE ~ 1)
  ) |>
  mutate(
    major = case_when(
      (mode_name == "major") ~ 1,
      (mode_name == "minor") ~ 0,
      TRUE ~ 0
    )
  ) |>
  mutate(
    minor = case_when(
      (mode_name == "minor") ~ 1,
      (mode_name == "major") ~ 0,
      TRUE ~ 0
    )
  ) |>
  select(
    hit_year, track_name, track_album_name, track_duration_ms,
    tempo, loudness, mode_name, key_mode, period, before_pandemic,
    major, minor
  )

# Remove duplicate rows and then remove track_name and track_album_name
cleaned_data <- distinct(cleaned_data)
cleaned_data <-
  cleaned_data |>
  select(hit_year, track_duration_ms, tempo, loudness,
    mode_name, key_mode, period, before_pandemic, major, minor
  )

#### Save data ####
# Save as a Parquet file
write_parquet(cleaned_data,
              "data/analysis_data/playlists_analysis_data.parquet")
# Save as a CSV file for Shiny App only
write_csv(cleaned_data,
          "other/top-songs-characteristics-app/shiny_app_data.csv")
