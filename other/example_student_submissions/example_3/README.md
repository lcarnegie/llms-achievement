# Characteristics of Top Songs Has Changed from Pandemic Brain: An analysis of songs on Billboard's Year-End Hot 100 singles list (2014 to 2023)

## Overview
Music often reflects the current climate of society and there is a growing interest in how hit songs as seen on Billboard's Year-End Hot 100 singles has changed after the COVID-19 pandemic. This paper looks at music characteristics such as tempo, song duration, loudness, and modality of songs from Billboard's Year-End Hot 100 singles list from 2014 to 2023 to reveal patterns and relationships to explain the difference between top songs before 2020 and 2020 onwards. The results show that hit songs from 2020 onwards had become on average quieter but slightly faster with our model revealing that duration does not impact the likelihood of a song being a hit prior to 2020 but songs in a minor key were more likely to be a hit before 2020. These results can support the evaluation of the emotional state of different populations and improve treatments such as music therapy, however further investigation is needed on the influence of lyrics on different music characteristics.

## Shiny app
An application featuring interactive graphs from the paper can be found here: 

## Important Notes
- `raw_playlists_data.csv` was last updated **Tuesday Mar 26 9:46pm EDT**
- Code was styled and checked using lintr and styler. 

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from Spotify.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains the fitted model for hit songs. 
-   `other` contains sketches and the code to create the Shiny app corresponding to the paper.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

No LLMs were used for any aspect of this work.
