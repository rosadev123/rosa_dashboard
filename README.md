# Quick Guide for Rosa Dashboard

## 1. Introduction
The Rosa dashboard project is an R-based interactive HTML dashboard for exploring research needs and projects. This quick guide provides streamlined instructions for setup, updates, and maintenance.

### Audience
- Familiarity with R, Quarto, and the `targets` package is recommended.
- Access links: [GitHub Repository](https://github.com/rosadev123/rosa_dashboard), [Google Drive](https://drive.google.com).

---

## 2. Setup Instructions

### Required Software
- **R**: Version 4.3.0 or higher.
- **RStudio**: For IDE integration.
- **Quarto**: Version 1.3.0+ for rendering the dashboard.

### Dependencies
1. **CRAN Packages**: Use `renv` for environment management:
   ```R
   renv::restore()
   ```
2. **Custom Packages**:
   - Install from Google Drive zip files or GitHub:
     ```R
     install.packages("path/to/gauntlet.zip", repos = NULL, type = "source")
     install.packages("path/to/gauntletReactable.zip", repos = NULL, type = "source")
     # Or install via GitHub:
     devtools::install_github("michaelgaunt404/gauntlet")
     devtools::install_github("michaelgaunt404/gauntletReactable")
     ```

---

## 3. Updating the Dashboard

### Steps to Update
1. **Data Update**:
   - Archive the current workbook in the Google Drive `data` folder.
   - Place the new workbook in the `data` directory in the repo.
   - Update `_targets.R`:
     ```R
     tar_target(
       data_rosa_dbase_file,
       here::here("data", "new_database_file.xlsx"),
       format = "file"
     )
     ```
2. **Rebuild the Pipeline**:
   ```R
   tar_visnetwork() # Visualize dependencies
   tar_make()       # Rebuild the pipeline
   ```
3. **Validate**:
   - Open `dashboard.html` in the `analysis` folder to confirm updates.

---

## 4. File Structure Overview
- **_quarto.yml**: Configures dashboard layout and structure.
- **_targets.R**: Defines the pipeline and dependencies.
- **analysis/**:
  - `dashboard.qmd`: Main Quarto file for dashboard generation.
  - `dashboard.html`: Output HTML dashboard.
- **data/**: Stores the latest Rosa database file.
- **R/**: Custom R functions auto-sourced by the pipeline.
- **docs/**: Supplemental documentation.

---

## 5. Google Drive & GitHub Repository

### Google Drive
- **Folders**:
  - `data/`: Archive of database files.
  - `docs/`: Supplemental documentation (e.g., workflow guides).
  - `special_packages/`: Zip files for `gauntlet` and `gauntletReactable`.

### GitHub Repository
- **Branching**:
  - Use feature branches for new developments:
    ```bash
    git checkout -b feature/new-feature
    ```
- **Commit & Push**:
    ```bash
    git add .
    git commit -m "Updated data pointer"
    git push origin feature/new-feature
    ```
- **Project Board**:
  - Tabs: To Do, In Progress, Done, Holding Pattern, Commemoration.
  - Use for task tracking and developer handoff.

---

## 6. Additional Notes
- **Resources**:
  - Learn more about [targets](https://books.ropensci.org/targets/) and [Quarto](https://quarto.org/).
- **Support**:
  - For credentials or access issues, refer to the Google Drive or GitHub repository.

This quick guide covers the essentials for working with the Rosa dashboard. For more details, refer to the full documentation.

