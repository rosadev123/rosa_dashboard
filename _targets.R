# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
library(tarchetypes) # Load other packages as needed.

global_package = c("tibble", "tidyverse", "magrittr","gauntlet"
                   ,"gauntletReactable", "reactable", "reactablefmtr"
                   ,"crosstalk", "plotly", "httr"
                   ,"bslib","bsicons", "htmltools", "shiny")

# Set target options:
tar_option_set(
  packages = global_package # packages that your targets need to run
  ,error = "continue"
  # ,quiet = FALSE
  ,format = "rds", # Optionally set the default storage format. qs is fast.
  #
  # For distributed computing in tar_make(), supply a {crew} controller
  # as discussed at https://books.ropensci.org/targets/crew.html.
  # Choose a controller that suits your needs. For example, the following
  # sets a controller with 2 workers which will run as local R processes:
  #
  #   controller = crew::crew_controller_local(workers = 2)
  #
  # Alternatively, if you want workers to run on a high-performance computing
  # cluster, select a controller from the {crew.cluster} package. The following
  # example is a controller for Sun Grid Engine (SGE).
  #
  #   controller = crew.cluster::crew_controller_sge(
  #     workers = 50,
  #     # Many clusters install R as an environment module, and you can load it
  #     # with the script_lines argument. To select a specific verison of R,
  #     # you may need to include a version string, e.g. "module load R/4.3.0".
  #     # Check with your system administrator if you are unsure.
  #     script_lines = "module load R"
  #   )
  #
  # Set other options as needed.
)

# tar_make_clustermq() is an older (pre-{crew}) way to do distributed computing
# in {targets}, and its configuration for your machine is below.
options(clustermq.scheduler = "multiprocess")

# tar_make_future() is an older (pre-{crew}) way to do distributed computing
# in {targets}, and its configuration for your machine is below.
# Install packages {{future}}, {{future.callr}}, and {{future.batchtools}} to allow use_targets() to configure tar_make_future() options.

# Run the R scripts in the R/ folder with your custom functions:
tar_source()
# source("other_functions.R") # Source other scripts as needed.

# Replace the target list below with your own:
list(
  tar_target(
    data_rosa_dbase_file
    ,here::here(
      "data"
      # ,"Re_ ROSA Dashboard Release Sprint"
      ,"FishFORWRD v2.2.0_8.14.24_mg.xlsx"
    ), format = "file")
  ,tar_target(data_rosa_dbase_list, upload_file_rosa(data_rosa_dbase_file))
  #data_objects_raw=============================================================
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # ,tar_target(data_raw_current, readxl::read_xlsx(data_file_current))
  # ,tar_target(data_raw_needed, readxl::read_xlsx(data_file_needed))
  #data_objects_pro=============================================================
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ,tar_target(data_current_pro, prcss_current_proj(data_rosa_dbase_list))
  ,tar_target(data_needed_pro, prcss_needed_proj(data_rosa_dbase_list))
  ,tar_target(data_def_terms_pro, prcss_def_terms(data_rosa_dbase_list))
  ,tar_target(data_references_pro, prcss_references(data_rosa_dbase_list))
  ,tar_target(data_acro_list_pro, prcss_acro_list(data_rosa_dbase_list))
  ,tar_target(data_srn_pro, prcss_srn(data_rosa_dbase_list))
  ,tar_target(data_current_srn, prcss_current_srn(data_current_pro,data_srn_pro))
  # ,tar_target(data_current_needed, prcss_merge_current_needed(data_needed_pro, data_current_pro))
  # ,tar_target(data_needed_pro_ex, prcss_needed_proj_ex(data_needed_pro, data_current_needed))
  # ,tar_target(data_needProj_gap, pivot_needProj_gap(data_needed_pro))
  #viz_objects==================================================================
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ##current
  ,tar_target(viz_tble_crrnt_proj_shrt, mk_tble_crrnt_proj_shrt(data_current_pro))
  ,tar_target(viz_prj_timeline, mk_viz_prj_timeline(data_current_pro))
  ,tar_target(viz_proj_location_tree
              ,mk_viz_proj_location_bar(data_current_pro, filter = F,  index = c("location", "research_category")))
  # ,tar_target(viz_tble_agg_addrssd_gap, mk_tble_agg_addrssd_gap(data_needProj_gap))
  ##ern

  ,tar_target(
    viz_tble_crrnt_srn_xwalk
    ,mk_tble_crrnt_srn_xwalk(data_current_srn, id_sffx = "xx"))
  ,tar_target(viz_smmry_srn_funnel, mk_vix_smmry_srn_funnel(data_srn_pro))
  ,tar_target(viz_smmry_srn_location_tree, mk_viz_proj_location_bar(data_current_srn, index = c("location", "research_category_srn")))
  ,tar_target(
    viz_tble_smmry_srn,
    data_srn_pro %>%
      filter(existing_project_addressing_need_id_number != "NULL") %>%
      mk_tble_smmry_srn(., id_sffx = "reg"))
  # ,tar_target(viz_tble_needs_proj_shrt, mk_tble_needs_proj_shrt(data_current_needed))
  # ,tar_target(viz_tble_need_anmlgrp, mk_tble_need_anmlgrp(data_current_needed))
  # ,tar_target(viz_viz_unaddressed_needs, mk_viz_unaddressed_needs(data_needProj_gap))
  # ,tar_target(viz_tble_agg_needs_animal_cmplt, mk_tble_agg_needs_animal_cmplt(data_current_needed))
  ##gap
  ,tar_target(
    viz_tble_smmry_srn_gap,
    data_srn_pro %>%
      filter(existing_project_addressing_need_id_number == "NULL") %>%
      mk_tble_smmry_srn(data = ., id_sffx = "gap"))
  # ,tar_target(viz_proj_location_tree_needs
  #             ,mk_viz_proj_location_bar_needs(data_srn_pro))
  # ,tar_target(viz_tble_project_summary, mk_tble_project_summary(data_current_pro))
  #data_center_objects
  ,tar_target(viz_tble_dcntr_current, mk_tble_dcntr_current(head(data_current_pro)))
  ,tar_target(viz_tble_dcntr_need, mk_tble_dcntr_need(data_needed_pro))
  ,tar_target(viz_tble_dcntr_ref, mk_tble_dcntr_ref(data_references_pro))
  ,tar_target(viz_tble_dcntr_def, mk_tble_dcntr_def(data_def_terms_pro))
  ,tar_target(viz_tble_dcntr_acc, mk_tble_dcntr_acc(data_acro_list_pro))
  ,tar_target(viz_tble_dcntr_srn, mk_tble_dcntr_srn(data_srn_pro))
  ,tar_target(viz_nav_object, make_nav_bar(viz_tble_dcntr_def = viz_tble_dcntr_def))
  #reports
  # tar_quarto(rosa_dashboard.qmd)
  ,tar_quarto(rpt_rosa_dashboard
              ,here::here("analysis/rosa_dashboard.qmd")
              ,quiet = F)
  ,tar_quarto(rpt_rosa_dashboard_test
              ,here::here("analysis/rosa_dashboard_test.qmd")
              ,quiet = F)


)

