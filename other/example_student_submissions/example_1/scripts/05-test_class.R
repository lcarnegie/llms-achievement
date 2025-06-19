#### Preamble ####
# Purpose: Tests the model class
# Author: 
# Date: 12 April 2024
# Contact: 
# Pre-requisites: run 04-model.R to get model

library("testthat")

test_that("Check class", {
  # Check if the model object inherits from any of the expected classes
  expect_true(
    inherits(political_preferences, "stanreg") ||
      inherits(political_preferences, "glm") ||
      inherits(political_preferences, "lm"),
    info = "The class of political_preferences is as expected."
  )
})