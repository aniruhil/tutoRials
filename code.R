
library(tidyverse)
library(tidycensus)
library(patchwork)
library(ggforce)
library(hrbrthemes)

get_acs(
  "state", 2019, variables = "B01001_001", geometry = TRUE
  ) -> mystate_df

