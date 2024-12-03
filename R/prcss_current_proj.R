prcss_current_proj = function(data){
  # data = tar_read(data_rosa_dbase_list)[[2]]
  # data = tar_read(data_rosa_dbase_list)


  data = data[["1. research projects"]] %>%
    janitor::remove_empty("cols") %>%
    # janitor::clean_names() %>%
    dplyr::select(!starts_with("x")) %>%
    rename_with(~gsub(" #", "\\1", .x))



  temp_data = data %>%
    # select(!`Project Website`) |>
    # rename(`Project Website` = web) |>
    # colnames() |> sort()
    janitor::clean_names() %>%
    mutate(count = 1) %>%
    mutate(project_start_year = as.numeric(project_start_year)
           ,project_end_year = as.numeric(estimated_project_end_year)) %>%
    filter(!is.na(research_project_id)) %>%
    #removal_step
    #--step removes old research_cat attributes
    #--also added step that deals with nulls and converts to NAs
    #NOTE!!! mg20240710 - this is not an issue anymore  since they have been changed
    # select(!starts_with("research_category")) %>%
    # rename(
    #   "research_category" = identified_research_need
    #   ,"research_category_2" = identified_research_need2) %>%
    mutate(across(where(is.character)
                  ,~case_when(.x %in% c("Null", "NULL")~NA_character_, T~.x) %>%
                    replace_na("NULL")))

  return(temp_data)
}
