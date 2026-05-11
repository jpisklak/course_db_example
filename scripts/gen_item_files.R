# Convert master spreadsheet to CSV
ods_to_csvs("data/master_sheet.ods", out_dir = "data")

# R exam file directory
edir <- "items/rexams"

# Output directories
dir_txt <- "items/plain_txt"
dir_md <- "items/markdown"

# Get r exam files
files <- list.files("items/rexams", pattern = "\\.Rmd$")

#-------------------------------------------------------------------------------

# Data frame for question stems
df_stems <- data.frame(
  ques = files,
  stem = vector(mode = "character", length = length(files)),
  answer = vector(mode = "character", length = length(files))
)

# For loop for txt file creation
for (i in 1:length(files)) {
  # Clean temp_dir
  clear_dir("temp_dir")

  # New filename
  fn <- sub("\\.Rmd$", "", files[i])

  q_i <- xexams(
    files[i],
    edir = edir,
    tdir = "temp_dir"
  )

  # Transfer assets from temp dir to rexams
  source_path <- paste0("temp_dir/items/rexams/", fn, "_assets")

  if (dir.exists(source_path) && length(list.files(source_path)) > 0) {
    file.copy(
      paste0("temp_dir/items/rexams/", fn, "_assets"),
      paste0("items/rexams/"),
      recursive = TRUE,
      overwrite = TRUE
    )
  }

  # Generate plain text files
  cat(
    paste0("Question: ", fn),
    "\n",
    paste(q_i$exam1$exercise1$question, sep = "", collapse = "\n"),
    "\n",
    if (length(q_i$exam1$exercise1$questionlist) > 0){
    paste(paste("* ", q_i$exam1$exercise1$questionlist), sep = "", collapse = "\n")},
    "\n\n",
    "Correct Answer:",
    "\n",
    paste(q_i$exam1$exercise1$metainfo$solution, sep = "", collapse = "\n"),
    sep = "",
    file = file.path(dir_txt, paste0(fn, ".txt"))
  )

  # Generate Markdown (.md) files
  cat(
    "### Question ",
    "\n",
    # paste0(fn),
    # "\n\n",
    paste(q_i$exam1$exercise1$question, sep = "", collapse = "\n"),
    "\n",
    if (length(q_i$exam1$exercise1$questionlist) > 0){
    paste(paste("* ", q_i$exam1$exercise1$questionlist), sep = "", collapse = "\n")},
    "\n\n",
    "### Correct Answer",
    "\n",
    paste(q_i$exam1$exercise1$metainfo$solution, sep = "", collapse = "\n"),
    "\n\n",
    "### Solution:",
    "\n",
    paste(q_i$exam1$exercise1$solution, sep = "", collapse = "\n"),
    sep = "",
    file = file.path(dir_md, paste0(fn, ".md"))
  )

  df_stems$stem[i] <- paste(q_i$exam1$exercise1$question, collapse = "<br>")
  df_stems$answer[i] <- paste(as.character(q_i$exam1$exercise1$metainfo$solution), collapse = " ")
}

write_csv(df_stems, "data/stems.csv")

# Clean temp_dir
clear_dir("temp_dir")
