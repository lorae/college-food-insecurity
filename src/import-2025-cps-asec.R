# import-2025-cps-asec.R
#
# This script processes raw IPUMS data and saves it in a DuckDB file.
#
# Input:
# -  makes API call to IPUMS USA. Be sure to follow Part B of project set-up
#    in README.md before running - this script reads an environment variable from 
#    .Renviron
#

# ----- Step 0: Configuration ----- #
library("dplyr")
library("duckdb")
library("ipumsr")
library("glue")

if (!file.exists(".Renviron")) {
  stop(".Renviron file needed for this code to run. Please refer to Part B of the README file for configuration instructions.")
} 

# Read API key from project-local .Renviron
readRenviron(".Renviron") # Force a re-read each run
api_key <- Sys.getenv("IPUMS_API_KEY")

if (api_key == "" || api_key == "your_ipums_api_key") {
  stop(".Renviron file exists, but IPUMS API key has not been added. Please refer to Part B of the README file for configuration instructions.")
}

print(paste0("IPUMS API key: ", api_key))
set_ipums_api_key(api_key)

# Set the destination directories for the IPUMS data pull
download_dir <- "data/ipums-microdata"
db_dir <- "data/db"

# ----- Step 1: Define, submit, and wait for data extract ----- #
# Browse available samples and their aliases
get_sample_info("cps") |> print(n=1000) 

# Extact simple 2025 CPS ASEC: super recent county-level view of college students
# on food stamps
ipums_extract_2025_asec <- define_extract_micro(
  description = "Food insecurity: 2025 ASEC",
  collection = "cps",
  samples = c(
    "cps2025_03s"
  ),
  variables = c(
    "COUNTY", "GQ", "FOODSTMP", "AGE", "SCHLCOLL"
  )
)

# Submit extract request
submitted <- submit_extract(ipums_extract_2025_asec)

# Poll until extract is ready
wait_for_extract(submitted) 

# ----- Step 2: Download and save extract ----- #

# Once ready, download the extract ZIP
download_extract(
  submitted,
  download_dir = download_dir,
  overwrite = TRUE,
  api_key = api_key
)

extract_num <- sprintf("%05d", submitted$number)

ddi_path <- glue("{download_dir}/usa_{extract_num}.xml")
dat_path <- glue("{download_dir}/usa_{extract_num}.dat.gz")

