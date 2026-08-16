---
type: note
status: active
project: uct
course: STA2020S
tags: [uct, statistics, r, course]
---

## R workflow for this course
Everything R-related lives in `r/` inside the vault, so scripts and plots are versioned with the notes and never stranded in Downloads.
### Setup (once)
Open `r/STA2020S.Rproj` in RStudio (File > Open Project). RStudio's working directory becomes `r/`, so any script you save lands in the vault automatically.
### Every session
```R
source("vault.R")
```
Then:
- `sta_datasets()` — list the CSVs in `data/`
- `df <- sta_data("intro.csv")` — load a course dataset
- `sta_save_plot("week01-residuals")` — save current plot to `r/plots/`, embed in a note with `![[week01-residuals.png]]`
- `sta_import("~/Downloads/newdata.csv")` — pull a downloaded file into `data/`
### Conventions
- One script per week: `week01.R`, `week02.R`, matching the notes.
- Plot names prefixed with the week: `week01-scatter`, so `r/plots/` stays sorted.
