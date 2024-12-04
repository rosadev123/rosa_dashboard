prcss_srn = function(data){
  # data = tar_read(data_rosa_dbase_list)

  data = data[["3. summarized research needs"]] %>%
    janitor::remove_empty("cols") %>%
    # janitor::clean_names() %>%
    dplyr::select(!starts_with("x"))
    # rename_with(~gsub(" #", "\\1", .x))

  temp_data = data %>%
    janitor::clean_names() %>%
    mutate(count = 1) %>%
    mutate(existing_project_addressing_need_id_number = mend_ern_ids(existing_project_addressing_need_id_number)) %>%
    mutate(across(where(is.character)
                  ,~case_when(
                    str_to_lower(.x) %in% c("null")~"NULL", T~.x) %>%
                    replace_na("NULL"))) %>%
    mutate(count_ern = str_count(existing_project_addressing_need_id_number, "Ex")) %>%
    mutate(count_rn = str_count(research_needs_captured , "RN")) %>%
    mutate(summarized_research_need_id = strg_numeric_order(summarized_research_need_id))

  return(temp_data)

}

