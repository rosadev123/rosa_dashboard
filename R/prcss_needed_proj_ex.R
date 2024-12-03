prcss_needed_proj_ex = function(data, data_comb){

  # data = tar_read(data_needed_pro)
  # data_comb = tar_read(data_current_needed)

  temp_data = data %>%
    filter(!(research_need_id_number %in% data_comb$research_need_id)) %>%
    mutate(across(
      c('research_need_id_number'
        ,'existing_project_addressing_need_id_number'
        ,'existing_project_addressing_need_id_number_mg')
      ,strg_numeric_order))

  return(temp_data)

}

