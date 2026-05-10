#library(readODS)

ods_to_csvs <- function(ods_path, out_dir = "csv_sheets", prefix = NULL) {
  dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

  sheets <- list_ods_sheets(ods_path)

  for (sh in sheets) {
    df <- read_ods(ods_path, sheet = sh, col_names = TRUE, progress = FALSE)

    # make a safe filename from the sheet name
    safe <- gsub("[^A-Za-z0-9_-]+", "_", sh)
    fname <- paste(c(prefix, safe), collapse = "_")
    out <- file.path(out_dir, paste0(fname, ".csv"))

    write.csv(df, out, row.names = FALSE, na = "")
  }

  invisible(sheets)
}
