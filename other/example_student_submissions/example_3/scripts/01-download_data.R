#### Preamble ####
# Purpose: Downloads and saves the data from Spotify.
# Author: 
# Date: 2 April 2024
# Contact: 
# License: MIT
# Pre-requisites: 00-install_packages.R has been ran to install the necessary
# packages.
# IMPORTANT NOTES:
# 1. This script was checked through lintr for styling

# 2. If this script does not run it is likely because you need to create a
# Spotify Developer Account and a new app for spotifyr. After doing this,
# call library("usethis") in your console in your RStudio environment,
# call edit_r_environ() to open the .Renviron file and add in the following
# with the values changed to your new app's Client ID and Client Secret, which
# can be found in your new app's settings:

# (Spotify Client ID) SPOTIFY_CLIENT_ID = 'PUT_YOUR_CLIENT_ID_HERE'
# (Spotify Client Secret) SPOTIFY_CLIENT_SECRET = 'PUT_YOUR_SECRET_HERE'

# For more detail, please see https://www.rcharlie.com/spotifyr/

#### Workspace setup ####
library(tidyverse)
library(spotifyr)

#### Download data ####
wickeddreamer96_username <- "wickeddreamer96"
antoniomendoza_username <- "antoniomendoza_"

# 2014 Playlist: 2014 Billboard Year End Hot 100
playlist_2014_path <- "2trgZsxRpWX7sq28yHC40u"

# 2015 Playlist: 2015 Billboard Year End Hot 100
playlist_2015_path <- "6LYxiUgw87zsDPqU0sdalZ"

# 2016 Playlist: 2016 Billboard Year End Hot 100
playlist_2016_path <- "3JbWD8OGutoTKUbR3RvR8u"

# 2017 Playlist: 2017 Billboard Year End Hot 100
playlist_2017_path <- "2XPEN88QyrPQ9zGqS8uS2x"

# 2018 Playlist: Billboard Year-End Hot 100: 2018
playlist_2018_path <- "5xAvbn5TP986st1UQde2vb"

# 2019 Playlist: Billboard Year-End Hot 100: 2019
playlist_2019_path <- "4IW60StVl1GdNOLA3PsZNv"

# 2020 Playlist: Billboard Year-End Hot 100: 2020
playlist_2020_path <- "2RJLA3wtfY6WdxVAmZtLVM"

# 2021 Playlist: Billboard Year-End Hot 100: 2021
playlist_2021_path <- "0CtM3UOXjhFSnKISn7FG4u"

# 2022 Playlist: Billboard Year-End Hot 100: 2022
playlist_2022_path <- "78xbP3FhfATJrpV89eT4RB"

# 2023 Playlist: Billboard Year-End Hot 100: 2022
playlist_2023_path <- "2FVuVMe3WUkfxUXnfwNxpS"

# Vector containing all the playlist paths
playlist_paths_antoniomendoza <- c(
  playlist_2018_path, playlist_2019_path,
  playlist_2020_path, playlist_2021_path,
  playlist_2022_path, playlist_2023_path
)
playlist_paths_wickeddreamer96 <- c(
  playlist_2014_path, playlist_2015_path,
  playlist_2016_path, playlist_2017_path
)

# Get data on playlists' audio features
raw_playlists_data_1 <- get_playlist_audio_features(
  wickeddreamer96_username, playlist_paths_wickeddreamer96
)
raw_playlists_data_2 <- get_playlist_audio_features(
  antoniomendoza_username, playlist_paths_antoniomendoza
)

raw_playlists_data <- rbind(raw_playlists_data_1, raw_playlists_data_2)

#### Save data ####
write_csv(raw_playlists_data, "data/raw_data/raw_playlists_data.csv")
