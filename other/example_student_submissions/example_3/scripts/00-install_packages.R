#### Preamble ####
# Purpose: Installs packages needed to run scripts and Quarto document
# Author: 
# Date: 2 April 2024
# Contact: 
# License: MIT
# Pre-requisites: -
# NOTE: This script was checked through lintr for styling

#### Workspace setup ####
## Installing packages (only needs to be done once per computer)
install.packages("tidyverse") # Contains data-related packages
install.packages("knitr") # To make tables
install.packages("janitor") # To clean datasets
install.packages("dplyr")
install.packages("ggplot2") # To make graphs
install.packages("spotifyr") # Spotify API
install.packages("usethis") # For storing app info for Spotify API
install.packages("arrow") # To allow Parquet files to be create
install.packages("ggcorrplot") # For correlation matrix
install.packages("testthat") # To test
install.packages("lintr") # To check styling of code
install.packages("styler") # To style code
# For app
install.packages("shiny")
install.packages("shinyWidgets")
install.packages("plotly")

# For models
install.packages("DiagrammeR")
install.packages("rsvg")
install.packages("magrittr")
install.packages("DiagrammeRsvg")
install.packages("png")
install.packages("rstanarm")
install.packages("modelsummary")# modelsummary package
