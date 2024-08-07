#### Preamble ####
# Purpose: Cleans the raw survey data recored by Rohan at the end of STA302
# Author: Luca Carnegie
# Date: 16 July 2024
# Contact: luca.carnegie@mail.utoronto.ca or rohan.alexander@utoronto.ca
# Pre-requisites: 01-download_data.R

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(stringr)
library(lintr)


#### Clean data ####
raw_data <- read_csv("data/raw_data/raw_STA302_postcourse_survey_w24.csv")

raw_data <- as_tibble(raw_data)

# CLEAN UP COLUMN NAMES

raw_data <- raw_data |>
  clean_names()

raw_data <- raw_data |>
  rename(
    consent = after_carefully_reading_the_informed_consent_document_please_indicate_below_whether_you_consent_to_have_your_anonymized_responses_included_in_the_research_study,
    student_name = what_is_your_full_name_on_quercus,
    student_id = what_is_your_student_id,
    year = what_year_are_you,
    program_of_study = what_is_your_specialization,
    major = what_is_are_your_major_s,
    minor = what_is_are_your_minor_s,
    gpa = what_is_your_gpa,
    ai_familiarity = how_familiar_are_you_with_using_generative_ai_tools_such_as_open_a_is_chat_gpt_or_equivalents,
    used_ai_any_reason = have_you_used_any_generative_ai_tools_such_as_open_a_is_chat_gpt_or_equivalents_for_any_reason_personal_or_educational,
    ai_use_cases = if_you_have_used_generative_ai_tools_such_as_open_a_is_chat_gpt_or_equivalents_in_what_ways_have_you_used_it_select_all_that_apply,
    ai_schoolwork_appropriate = to_what_extent_do_you_think_using_generative_ai_tools_such_as_chat_gpt_by_open_ai_or_equivalents_is_ethical_and_appropriate_for_schoolwork,
    ai_schoolwork_appropriate_comments = please_elaborate_on_your_answer_above,
    used_ai_in_sta302 = did_you_use_any_generative_ai_tools_such_as_open_a_is_chat_gpt_or_equivalents_for_sta302,
    ai_helpful_weekly_quiz = weekly_quiz,
    ai_helpful_weekly_mini_essay = weekly_mini_essay,
    ai_helpful_papers_generating_ideas = papers_generating_ideas,
    ai_helpful_papers_writing_code = papers_writing_code,
    ai_helpful_papers_writing_content = papers_writing_content,
    ai_helpful_papers_improving_content = papers_improving_content,
    recs_for_ai_sta302 = what_is_your_recommendation_for_how_generative_ai_tools_such_as_chat_gpt_by_open_ai_or_equivalents_should_be_used_in_the_course_in_future,
    other_comments = optional_any_other_comments
  )

# CALCULATE TIME TO COMPLETE SURVEY

raw_data <- raw_data |>
  mutate(
    mins_complete = round(as.numeric(difftime(as.POSIXct(completion_time), as.POSIXct(start_time), units = "mins")), 2)
  )

# CLEAN YEARS

raw_data <- raw_data |>
  mutate(
    year = str_sub(year, 1, 3)
  )


# Standardize program names

# Description: Go through each row. If you find a program that matchs a standard
#             program, then put it in a string, do this until all matches are
#             found, after which you put a string with the programs separated by
#             semi-colons.

# Define the mapping to standard names.
standard_programs <- list(
  "Statistics" = c("Statistics", "Stats", "Sta", "sta", "Stat", "statistics", "STAT", "STATS", "STATISTICS"),
  "Economics" = c("Economics", "Economiccs", "Econ", "Eco", "eco", "economics", "ECONOMICS", "ECON", "ECO", "Focus in Data Analytics", "Focus in data analytics"),
  "Computer Science" = c("Computer science", "Computer Science", "CS", "cs", "computer science", "COMPUTER SCIENCE", "CompSci", "comp sci", "COMP SCI"),
  "Education" = c("Education", "education", "EDUCATION", "Edu", "edu", "EDU"),
  "Mathematics" = c("Mathematics", "Math", "math", "Mathematical Applications in Economics and Finance", "mathematical applications in econ and finance", "MATH", "MATHEMATICS", "Mathematical applications in economics and finance"),
  "Commerce" = c("Accounting", "Management", "Finance and Economics", "commerce", "COMM", "accounting", "management", "finance and economics", "ACCOUNTING", "MANAGEMENT", "FINANCE AND ECONOMICS", "Finance & Economics", "finance & economics"),
  "Human Resources" = c("Human Resources", "HR", "hr", "human resources", "HUMAN RESOURCES", "Hr", "Hr Resources", "human resources"),
  "Cognitive Science" = c("Cognitive Science", "Cog Sci", "Cogsci", "cognitive science", "COGNITIVE SCIENCE", "COG SCI", "cogsci", "Cogsci", "cog sci"),
  "Engineering" = c("Engineering Science", "engineering science", "ENGINEERING SCIENCE", "Engineering", "engineering", "ENGINEERING"),
  "Life Sciences" = c("Life Sciences", "Life science", "Life Science", "Physiology", "life sciences", "life science", "LIFE SCIENCES", "LIFE SCIENCE", "physiology", "PHYSIOLOGY"),
  "Physics" = c("Chemical Physics Specialist", "chemical physics", "CHEMICAL PHYSICS", "Physics", "physics", "PHYSICS"),
  "Data Science" = c("Data science", "data science", "DATA SCIENCE", "Data Science", "Data sci", "data sci")
)

# Helper Function to standardize the program name
standardize_program <- function(input_string, mapping) {
  if (is.na(input_string)) {
    return("Undeclared")
  }

  for (standard_name in names(mapping)) { # for every standard name
    for (variation in mapping[[standard_name]]) { # for each 'permutation' of standard name
      if (!is.na(variation) && str_detect(variation, input_string)) {
        # check if the input string matches any part of the permutation
        # return the standard name if matching
        return(standard_name)
      }
    }
  }

  return("Undeclared") # Return "Undeclared" if no match is found
}

# Doing the mutation
raw_data <- raw_data |>
  mutate(program_of_study = sapply(program_of_study, function(x) standardize_program(x, standard_programs)))

# CLEAN GPA COLUMN
raw_data <- raw_data |>
  mutate(
    gpa = ifelse(str_detect(gpa, "[0-9]"), as.numeric(gpa), NA)
  )

# FIX ERRORS IN SELF PERCEPTION QUESTIONS
assign_likert_value <- function(x) {
  case_when(
    x == "\"This is very different to me\"" ~ "This is very different to me",
    x == "\"This somewhat describes me\"" ~ "This somewhat describes me",
    x == "\"This is a lot like me\"" ~ "This is a lot like me",
    x == 1 ~ "This is very different to me",
    x == 2 ~ "This somewhat describes me",
    x == 3 ~ "This is a lot like me",
    x == 4 ~ NA_character_,
  )
}

raw_data <- raw_data |>
  mutate(
    writing_is_easy_for_me = assign_likert_value(writing_is_easy_for_me),
    i_like_to_write = assign_likert_value(i_like_to_write),
    i_believe_it_is_important_to_be_a_good_writer = assign_likert_value(i_believe_it_is_important_to_be_a_good_writer),
    when_i_edit_it_is_easy_for_me_to_catch_my_mistakes = assign_likert_value(when_i_edit_it_is_easy_for_me_to_catch_my_mistakes),
    i_feel_confident_sharing_my_writing = assign_likert_value(i_feel_confident_sharing_my_writing),
    i_am_confident_in_my_overall_writing_ability = assign_likert_value(i_am_confident_in_my_overall_writing_ability),
    coding_is_easy_for_me = assign_likert_value(coding_is_easy_for_me),
    i_like_to_code = assign_likert_value(i_like_to_code),
    i_believe_it_is_important_to_be_a_good_coder = assign_likert_value(i_believe_it_is_important_to_be_a_good_coder),
    when_i_check_my_code_it_is_easy_for_me_to_catch_my_mistakes = assign_likert_value(when_i_check_my_code_it_is_easy_for_me_to_catch_my_mistakes),
    i_feel_confident_sharing_my_code = assign_likert_value(i_feel_confident_sharing_my_code),
    i_am_confident_in_my_overall_coding_ability = assign_likert_value(i_am_confident_in_my_overall_coding_ability),
  )

# CLEAN UP AI HELPFULNESS

remove_quotes <- function(x) {
  str_remove_all(x, "\"")
}

raw_data <- raw_data |>
  mutate(
    ai_helpful_weekly_quiz = remove_quotes(ai_helpful_weekly_quiz),
    ai_helpful_weekly_mini_essay = remove_quotes(ai_helpful_weekly_mini_essay),
    ai_helpful_papers_generating_ideas = remove_quotes(ai_helpful_papers_generating_ideas),
    ai_helpful_papers_writing_code = remove_quotes(ai_helpful_papers_writing_code),
    ai_helpful_papers_writing_content = remove_quotes(ai_helpful_papers_writing_content),
    ai_helpful_papers_improving_content = remove_quotes(ai_helpful_papers_improving_content)
  )


# EXPAND OUT AI USE CASES FROM ai_use_case.

# If they put "never used it" then all other columns should be 0
check_use_case <- function(use_case, use_cases) {
  if (str_detect(use_cases, use_case)) {
    return(1)
  } else {
    return(0)
  }
}

raw_data <- raw_data |>
  mutate(
    not_used = sapply(ai_use_cases, function(x) check_use_case("Never used it", x))
  ) |>
  mutate(
    used_technical_q = ifelse(not_used == 1, 0, sapply(ai_use_cases, function(x) check_use_case("Asking technical questions", x))),
    used_conversation = ifelse(not_used == 1, 0, sapply(ai_use_cases, function(x) check_use_case("Carrying on a conversation out of curiosity", x))),
    used_general_knowledge = ifelse(not_used == 1, 0, sapply(ai_use_cases, function(x) check_use_case("Asking general knowledge questions", x))),
    used_solving_hmk = ifelse(not_used == 1, 0, sapply(ai_use_cases, function(x) check_use_case("Solving homework", x))),
    used_check_soln = ifelse(not_used == 1, 0, sapply(ai_use_cases, function(x) check_use_case("Checking solutions", x))),
    used_quick_q = ifelse(not_used == 1, 0, sapply(ai_use_cases, function(x) check_use_case("Asking quick questions when stuck", x))),
    used_expl_concepts = ifelse(not_used == 1, 0, sapply(ai_use_cases, function(x) check_use_case("Explaining concepts", x))),
    used_writing_content = ifelse(not_used == 1, 0, sapply(ai_use_cases, function(x) check_use_case("Writing essays or paragraphs", x))),
    used_writing_code = ifelse(not_used == 1, 0, sapply(ai_use_cases, function(x) check_use_case("Writing code", x)))
  )

# FIX ai_schoolwork_appropriate

# Other answers than Appropriate and Inappropriate are marked as "It depends"

raw_data <- raw_data |>
  mutate(
    ai_schoolwork_appropriate = case_when(
      ai_schoolwork_appropriate == "Appropriate" ~ "Appropriate",
      ai_schoolwork_appropriate == "Inappropriate" ~ "Inappropriate",
      TRUE ~ "It depends"
    )
  )


# DROP ROWS FOR UNCONSENTING STUDENT OR TA
raw_data <- raw_data |>
  filter(
    consent == "Yes, I authorize the use of the data collected about me for the STA302 course survey to be used. I will be compensated 1% of my course grade for completing the survey.",
    year != "TA"
  )


# DROP UNECESSARY OR EMPTY COLUMNS
raw_data <- raw_data |>
  select(-c(
    email,
    name,
    last_modified_time,
    consent,
    student_name,
    student_id,
    ai_use_cases,
    start_time,
    completion_time
  ))

# RE-ARRANGE COLUMNS

raw_data <- raw_data |>
  select(
    id,
    mins_complete,
    year,
    program_of_study,
    major,
    minor,
    gpa,
    writing_is_easy_for_me,
    i_like_to_write,
    i_believe_it_is_important_to_be_a_good_writer,
    when_i_edit_it_is_easy_for_me_to_catch_my_mistakes,
    i_feel_confident_sharing_my_writing,
    i_am_confident_in_my_overall_writing_ability,
    coding_is_easy_for_me,
    i_like_to_code,
    i_believe_it_is_important_to_be_a_good_coder,
    when_i_check_my_code_it_is_easy_for_me_to_catch_my_mistakes,
    i_feel_confident_sharing_my_code,
    i_am_confident_in_my_overall_coding_ability,
    ai_familiarity,
    used_ai_any_reason,
    used_ai_in_sta302,
    not_used,
    used_technical_q,
    used_conversation,
    used_general_knowledge,
    used_solving_hmk,
    used_check_soln,
    used_quick_q,
    used_expl_concepts,
    used_writing_content,
    used_writing_code,
    ai_helpful_weekly_quiz,
    ai_helpful_weekly_mini_essay,
    ai_helpful_papers_generating_ideas,
    ai_helpful_papers_writing_code,
    ai_helpful_papers_writing_content,
    ai_helpful_papers_improving_content,
    ai_schoolwork_appropriate,
    ai_schoolwork_appropriate_comments,
    recs_for_ai_sta302,
    other_comments
  )


#### Save data ####
cleaned_data <- raw_data
write_csv(cleaned_data, "data/analysis_data/clean_STA302_postcourse_survey_w24.csv")
