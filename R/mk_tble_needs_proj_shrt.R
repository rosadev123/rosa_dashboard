mk_tble_needs_proj_shrt = function(data){

  # data = tar_read(data_current_needed)

  tmp_data = data %>%
    dplyr::select(
      research_need_id
      ,current_projects
      ,location
      ,research_category_crrnt
      ,animal_group
      ,research_need
      ) %>%
    rename(
      existing_project_id = current_projects
      ,research_category_crrnt = research_category_crrnt) %>%
    mutate(research_need_id = strg_numeric_order(research_need_id, rev = F)) %>%
    arrange(research_need_id)

  tmp_data = tmp_data %>%
    mutate(
      across(all_of(rtrn_cols(tmp_data, words = "project_title", exclude = T, pretty = F))
             ,~strg_wrap_html(.x, width = 30, whtspace_only = F))
      # ,across(project_title
      #        ,~strg_wrap_html(.x, width = 20, whtspace_only = F))
    ) #%>%
    # rename_with(strg_pretty_char) #don't need anymore

  id = "id_tble_needs_proj_shrt"
  temp_table = reactable(
    tmp_data
    ,defaultColDef = colDef(footerStyle = list(fontWeight = "bold"), header = mk_special_header)
    ,columns = combined_named_lists(
      colDef_html(cols = colnames(tmp_data))
      ,colDef_sticky(cols = rtrn_cols(tmp_data, "research_need_id|existing_"))
      ,colDef_colWidth_robust(cols = rtrn_cols(tmp_data, "research_need_id|existing_"), maxWidth = 80)
      # ,colDef_urlLink_spec(cols = "existing_project_id", col_url = "project_website", tmp_data)
      ,colDef_filter_select(cols = rtrn_cols(tmp_data, words = "id", exclude = T), id = id)
    )
    ,columnGroups = list(
      colGroup(name = "Existing Project Attributes"
               ,columns = rtrn_cols(tmp_data, words = "research_need_id", exclude = T)
      )
    ), wrap = T, elementId = id
  ) %>%
    rctble_format_table()


  return(temp_table)
}
