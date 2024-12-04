mk_tble_smmry_srn_gap = function(data ){

  # data = tar_read(data_srn_pro)

  temp_data = data %>%
    filter(existing_project_addressing_need_id_number == "NULL") %>%
    select(
      summarized_research_need_id
      ,research_category
      ,summary_of_research_need
      ,research_needs_captured) %>%
    rename(summary = summary_of_research_need
           ,SRN_id = summarized_research_need_id) %>%
    mutate(SRN_id = strg_numeric_order(SRN_id, rev = F))


  id = "id_tble_smmry_srn_gap"
  temp_table = reactable(
    temp_data
    ,defaultColDef = colDef(
      footerStyle = list(fontWeight = "bold")
      ,header = mk_special_header)
    ,columns = combined_named_lists(
      # colDef_html(cols = colnames(tmp_data))
      colDef_sticky(cols = "id")
      ,colDef_colWidth_robust(cols = rtrn_cols(temp_data, "id_number"), maxWidth = 90)
      ,colDef_colWidth_robust(cols = rtrn_cols(temp_data, "summ", exclude = T), maxWidth = 120)
      ,colDef_colWidth_robust(cols = rtrn_cols(temp_data, "summ|cap"), minWidth = 200)
      # ,colDef_minwidth(cols = rtrn_cols(tmp_data, "Research Need"), width = 110)
      # ,colDef_mailto(cols = "pi_name", col_email = "pi_contact_info", tmp_data)
      # ,colDef_urlLink_spec(cols = "research_project_id_number", col_url = "project_website", tmp_data)
      ,colDef_filter_select(cols = rtrn_cols(temp_data, words = "summary|cap", exclude = T), id = id)
      # ,colDef_filter_select(cols = rtrn_cols(temp_data, words = "research_need_id"), id = id, F)
    ), wrap = T, elementId = id, height =  700
  ) %>%
    rctble_format_table()

  return(temp_table)

}








