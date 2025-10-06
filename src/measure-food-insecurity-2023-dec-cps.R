# snap-2025-asec.R
# ----- Step 0: Configuration ----- #
library("dplyr")
library("duckdb")
library("ipumsr")
library("dbplyr")

devtools::load_all("../demographr")

# ----- Step 1: Connect to the database ----- #

con <- dbConnect(duckdb::duckdb(), "data/db/ipums.duckdb")
ipums_db <- tbl(con, "ipums_2023_dec")
ipums_db <- ipums_db |>
  mutate(
    in_college = 
      SCHLCOLL == 3 | # college full time
      SCHLCOLL == 4 # college part time
  )

# ----- Step 2: Analyze ----- #

# Enough food / foods they wanted to eat
crosstab_percent(
  data = ipums_db |> filter(
    AGE >= 18 & 
      in_college &
      FSFOODS != 99 # Not in Universe. See https://cps.ipums.org/cps-action/variables/FSFOODS#universe_section
    ),
  wt_col = "WTFINL",
  group_by = c("FSFOODS"),
  percent_group_by = c()
)

# Food insecurity
crosstab_percent(
  data = ipums_db |> filter(
    AGE >= 18 & 
      in_college &
      FSSTATUSD != 99 
  ),
  wt_col = "WTFINL",
  group_by = c("FSSTATUSD"),
  percent_group_by = c()
)

# Received food from food bank / pantry in past month
# Something must be wrong because I can't fathom 61% of students got food from a 
# food bank/pantry. Maybe they are counting dining halls?
# (Replaces SC3) In the last 12 months, did (you/you or anyone in your household) 
# ever get free groceries from a food pantry, food bank, church, or other place 
# that helps with free food?
crosstab_percent(
  data = ipums_db |> filter(
    AGE >= 18 & 
      in_college &
    FSFDBNKMO != 99 
  ),
  wt_col = "WTFINL",
  group_by = c("FSFDBNKMO"),
  percent_group_by = c()
)

