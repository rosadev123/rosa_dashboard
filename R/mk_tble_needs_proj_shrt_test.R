mk_tble_needs_proj_shrt_test = function(data ){

  # data = tar_read(data_needed_pro)

  temp_data = data %>%
    select(research_need_id, research_category, summary_of_research_need
           ,source_of_identification, location, data_gap_analysis_score_mg) %>%
    rename_with(~str_remove(.x, "_mg")) %>%
    # count(data_gap_analysis_score)
    filter(data_gap_analysis_score == "Not Addressed")

  id = "id_tble_crrnt_proj_shrt_test_change"
  temp_table = reactable(
    temp_data
    ,defaultColDef = colDef(footerStyle = list(fontWeight = "bold"), header = mk_special_header)
    ,columns = combined_named_lists(
      # colDef_html(cols = colnames(tmp_data))
      colDef_sticky(cols = "research_project_id_number")
      ,colDef_colWidth_robust(cols = rtrn_cols(temp_data, "id_number"), maxWidth = 90)
      ,colDef_colWidth_robust(cols = rtrn_cols(temp_data, "summ", exclude = T), maxWidth = 120)
      ,colDef_colWidth_robust(cols = rtrn_cols(temp_data, "summ"), minWidth = 200)
      # ,colDef_minwidth(cols = rtrn_cols(tmp_data, "Research Need"), width = 110)
      # ,colDef_mailto(cols = "pi_name", col_email = "pi_contact_info", tmp_data)
      # ,colDef_urlLink_spec(cols = "research_project_id_number", col_url = "project_website", tmp_data)
      ,colDef_filter_select(cols = rtrn_cols(temp_data, words = "summary|research_need_id", exclude = T), id = id)
      ,colDef_filter_select(cols = rtrn_cols(temp_data, words = "research_need_id"), id = id, F)
    ), wrap = T, elementId = id, height =  700
  ) %>%
    rctble_format_table()

  return(temp_table)

}








