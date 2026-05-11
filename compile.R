# Install and load necessary packages
source("scripts/pkg_load.R")
pkg_load(c("quarto", "randomNames", "tidyverse", "readODS", "DT", "exams"))
# (.packages())

# Load custom functions
source("scripts/clear_dir.R")
source("scripts/ods_to_csv.R")

# Set seed for reproducibility
# as.integer(Sys.time())
set.seed(1778443160)

# Create temp dir for exams package
if (!dir.exists("./temp_dir")) {dir.create("./temp_dir")}

# Generate .txt and .md files from .Rmd files
source("scripts/gen_item_files.R")
rm(list = setdiff(ls(), lsf.str())) # remove non-function variables

# Generate individual item .qmd files from item .md files
source("scripts/quarto_item_gen.R")
rm(list = setdiff(ls(), lsf.str())) # remove non-function variables

# Render quarto
quarto_render()
quarto_preview()

# quarto_preview_stop()
