prcss_current_srn = function(data_current, data_srn_pro){

  # data_current = tar_read(data_current_pro)
  # data_srn_pro = tar_read(data_srn_pro)

  temp_data = data_srn_pro %>%
    separate(col = existing_project_addressing_need_id_number
             ,into = paste0("xcol_", c(1:50))
             ,sep = ",") %>%
    janitor::remove_empty("cols") %>%
    pivot_longer(cols = starts_with("xcol_")
                 ,values_to = "ERN") %>%
    filter(!is.na(ERN)) %>%
    select(!c("count", "name")) %>%
    mutate(ERN = ERN %>% mend_ern_ids(col = .)) %>%
    rename(research_category_srn = research_category
           ,id_srn = summarized_research_need_id) %>%
    merge(
      .,
      data_current %>%
        mutate(research_project_id = research_project_id %>% mend_ern_ids(col = .)) %>%
        rename(research_category_ern = research_category
               ,id_ern = research_project_id)
      , by = c("ERN"), by.y = c("id_ern")
    ) %>%
    rename(id_ern = ERN) %>%
    mutate(across(c(id_srn, id_ern), strg_numeric_order, rev = F))

  return(temp_data)

}



