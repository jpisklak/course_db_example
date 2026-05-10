item_sheet_dir <- file.path("data", "items.csv")
question_dir <- file.path("items", "markdown")
out_dir <- "item_pages"
dir.create("item_pages", showWarnings = FALSE)

# Spreadsheet of items
item_sheet <- read_csv(item_sheet_dir, show_col_types = FALSE)

# Functions---------------------------------------------------------------------

rewrite_asset_paths <- function(
  text,
  item_id,
  source_root = "../items/rexams"
) {
  assets_dir <- paste0(item_id, "_assets")
  full_path <- paste0(source_root, "/", assets_dir)

  # Rewrite Markdown image links: ![alt](image.svg) -> ![alt](../items/rexams/item_05_assets/image.svg)
  # Only match if it's NOT already a URL or doesn't already start with the assets_dir
  text <- gsub(
    "(!\\[[^\\]]*\\]\\()(?!https?://|/|\\.\\./)([^)]+)",
    sprintf("\\1%s/\\2", full_path),
    text,
    perl = TRUE
  )

  # Handle regular Markdown links: [text](image.png) -> [text](../items/rexams/item_05_assets/image.png)
  text <- gsub(
    "(\\[[^\\]]*\\]\\()(?!https?://|/|\\.\\./)([^)]+)",
    sprintf("\\1%s/\\2", full_path),
    text,
    perl = TRUE
  )

  # Handle HTML img tags: <img src="image.jpg"> -> <img src="../items/rexams/item_05_assets/image.jpg">
  text <- gsub(
    '(<img[^>]*src=["\'])(?!https?://|/|\\.\\./)([^"\']+)',
    sprintf("\\1%s/\\2", full_path),
    text,
    perl = TRUE
  )

  text
}


# Add bottom Navigation links
nav_links <- function(index, ids) {
  paste0(
    '<div class="item-nav" style="display:flex; gap:1rem; justify-content:space-between; margin: 1rem 0 2rem 0;">',
    if ((index - 1) != 0) {
      sprintf(
        '<a href="%s.html">← Previous (%s)</a>',
        ids[index - 1],
        ids[index - 1]
      )
    } else {
      '<span></span>'
    },
    if (index != length(ids)) {
      sprintf(
        '<a href="%s.html">Next (%s) →</a>',
        ids[index + 1],
        ids[index + 1]
      )
    } else {
      '<span></span>'
    },
    '</div>'
  )
}

#-------------------------------------------------------------------------------
# Generate quarto files from markdown files

clear_dir("item_pages")

for (i in 1:nrow(item_sheet)) {
  id <- tolower(item_sheet$item_ID[i])

  path <- file.path(question_dir, paste0(id, ".md"))
  txt <- readLines(path, warn = FALSE) # load md text
  txt <- txt[-c(1)] # Remove title
  txt <- rewrite_asset_paths(txt, id) # Fix paths

  qmd <- paste0(
    # YAML
    '---\n',
    'title: ',
    sub("^(.)", "\\U\\1", gsub("_", " ", id), perl = TRUE),
    '\n',
    'page-layout: full\n',
    '---\n\n',
    # Export checkbox
    '<div class="exam-select">\n',
    '<label>\n',
    '<input type="checkbox" class="include-item" data-item-id="',
    id,
    '">\n',
    'Include in export\n',
    '</label>\n',
    '</div>\n\n',
    # Markdown text
    paste(txt, collapse = "\n"),
    '\n\n',
    '<br>\n\n',
    # Navigation footer
    '---',
    '\n\n',
    nav_links(i, tolower(item_sheet$item_ID)),
    '\n'
  )

  writeLines(qmd, file.path(out_dir, paste0(id, ".qmd")))
}
