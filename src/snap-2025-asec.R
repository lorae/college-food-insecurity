# snap-2025-asec.R
# ----- Step 0: Configuration ----- #
library("dplyr")
library("duckdb")
library("ipumsr")
library("dbplyr")

devtools::load_all("../demographr")

# ----- Step 1: Connect to the database ----- #

con <- dbConnect(duckdb::duckdb(), "data/db/ipums.duckdb")
ipums_db <- tbl(con, "ipums_2025_asec")
ipums_db <- ipums_db |>
  mutate(
    in_college = 
      SCHLCOLL == 3 | # college full time
      SCHLCOLL == 4 # college part time
  )

# For data validation: count number of rows, to ensure none are dropped later
obs_count <- ipums_db |>
  summarise(count = n()) |>
  pull()

# ----- Step 2: Analyze ----- #
# COUNTY == 34021 is Mercer County, NJ
crosstab_percent(
  data = ipums_db |> filter(AGE >= 18 & in_college),
  wt_col = "ASECWT",
  group_by = c("FOODSTMP", "SCHLCOLL"),
  percent_group_by = c("SCHLCOLL")
)
