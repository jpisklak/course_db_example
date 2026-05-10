# Function for clearing a directory of its files.

clear_dir <- function(path, include_hidden = TRUE, dry_run = FALSE) {
  # Check if directory exists
  if (!dir.exists(path)) {
    stop("Directory does not exist: ", path)
  }

  files <- list.files(
    path,
    full.names = TRUE,
    all.files = include_hidden,
    recursive = TRUE,
    include.dirs = TRUE
  )

  # Filter out "." and ".." entries
  files <- files[!grepl("(/|\\\\)?\\.{1,2}$", files)]

  # Show what would be deleted
  if (dry_run) {
    message("The following ", length(files), " items would be deleted:")
    print(files)
    return(invisible(files))
  }

  # Delete
  if (dry_run == FALSE) {
    result <- unlink(files, recursive = TRUE)
  }

  # Check for errors
  if (result == 1) {
    warning("Some files may not have been deleted")
  }

  return(invisible(result))
}
