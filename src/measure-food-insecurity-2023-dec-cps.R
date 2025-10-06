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
