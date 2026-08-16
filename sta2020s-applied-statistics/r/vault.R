# STA2020S vault helpers.
# Open STA2020S.Rproj in RStudio, then: source("vault.R")
# Everything saved through these functions lands inside the Obsidian vault.

course_root <- path.expand("~/vault/school/sta2020s-stats")

# Load a course dataset by name: df <- sta_data("intro.csv")
sta_data <- function(name) {
  read.csv(file.path(course_root, "data", name))
}

# List available datasets
sta_datasets <- function() {
  list.files(file.path(course_root, "data"), pattern = "\\.csv$")
}

# Save the current plot into the vault so it can be embedded in notes
# with ![[plots/name.png]]. Works for base R and ggplot (last displayed plot).
sta_save_plot <- function(name, width = 8, height = 5) {
  dir.create(file.path(course_root, "r", "plots"), showWarnings = FALSE)
  path <- file.path(course_root, "r", "plots", paste0(name, ".png"))
  dev.copy(png, filename = path, width = width * 96, height = height * 96, res = 96)
  dev.off()
  message("Saved: ", path, "  (embed with ![[", name, ".png]])")
}

# Copy any file (e.g. something a lab PC put in Downloads) into the vault data folder
sta_import <- function(path) {
  dest <- file.path(course_root, "data", basename(path))
  file.copy(path, dest, overwrite = TRUE)
  message("Imported: ", dest)
}
