mk_tble_crrnt_proj_shrt = function(data){

  # data = tar_read(data_current_pro)

  # message("Small")

  tmp_data = data %>%
    dplyr::select(research_project_id
                  ,project_title
                  ,research_category
                  ,location
                  ,funder
                  ,lead_entity
                  # ,pi_name
                  # ,pi_contact_info
                  ,project_website
    ) %>%
    rename_with(~str_remove(.x, "_mg")) %>%
    mutate(research_project_id = strg_numeric_order(research_project_id, rev = F)) %>%
    arrange(research_project_id)
    # head(10)

  id = "id_tble_crrnt_proj_shrt"
  temp_table = reactable(
    tmp_data
    ,defaultColDef = colDef(footerStyle = list(fontWeight = "bold"), header = mk_special_header)
    ,columns = combined_named_lists(
      colDef_html(cols = colnames(tmp_data))
      ,colDef_sticky(cols = "research_project_id")
      ,colDef_colWidth_robust(cols = rtrn_cols(tmp_data, "itle"), minWidth = 250)
      # ,colDef_minwidth(cols = rtrn_cols(tmp_data, "Research Need"), width = 110)
      # ,colDef_mailto(cols = "pi_name", col_email = "pi_contact_info", tmp_data)
      ,colDef_urlLink_spec_hotfix(cols = "research_project_id", col_url = "project_website", tmp_data)
      ,colDef_filter_select(cols = rtrn_cols(tmp_data, words = "title", exclude = T), id = id)
    ), wrap = T, elementId = id
  ) %>%
    rctble_format_table()

  return(temp_table)

}
