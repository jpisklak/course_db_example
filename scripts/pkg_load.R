pkg_load <- function(pkgs) {
  for (pkg in pkgs) {
    
    # 1. Install if not installed
    if (!requireNamespace(pkg, quietly = TRUE)) {
      install.packages(pkg)
    }
    
    # 2. Load if not already attached
    if (!paste0("package:", pkg) %in% search()) {
      library(pkg, character.only = TRUE)
    }
  }
}