prcss_needed_proj = function(data){
  # data = tar_read(data_rosa_dbase_list)
  # data = tar_read(data_raw_needed)

  data = data[["2. research needs"]] %>%
    janitor::remove_empty("cols") %>%
    # janitor::clean_names() %>%
    dplyr::select(!starts_with("x")) %>%
    rename_with(~gsub(" #", "\\1", .x))


  temp_data = data %>%
    janitor::clean_names() %>%
    mutate(count = 1) %>%
    filter(!is.na(research_need_id)) %>%
      #removal_step
      #--step removes old research_cat attributes
      #--also added step that deals with nulls and converts to NAs
      # select(!starts_with("research_category")) %>% #removed this as name is correct now
      # rename(
      #   "research_category" = identified_research_need
      #   ,"research_category_2" = identified_research_need2) %>% #removed this as name is correct now
      mutate(across(where(is.character)
                    ,~case_when(.x %in% c("Null", "NULL")~NA_character_, T~.x) %>%
                      replace_na("NULL")))

    return(temp_data)

}


