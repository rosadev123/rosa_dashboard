mk_tble_smmry_srn = function(data, id_sffx ){

  # data = tar_read(data_srn_pro)
  # data = data_srn_pro %>%
  #   filter(existing_project_addressing_need_id_number != "NULL")

  temp_data = data %>%
    select(
      summarized_research_need_id
      ,research_category
      ,summary_of_research_need
      ,research_needs_captured
      # ,count_rn
      ) %>%
    rename(summary = summary_of_research_need
           ,SRN_id = summarized_research_need_id) %>%
    mutate(SRN_id = strg_numeric_order(SRN_id, rev = F))

  id = paste0("id_tble_smmry_srn_", id_sffx)
  temp_table = reactable(
    temp_data
    ,defaultColDef = colDef(
      footerStyle = list(fontWeight = "bold")
      ,header = mk_special_header)
    ,columns = combined_named_lists(
      colDef_sticky(cols = "id")
      ,colDef_colWidth_robust(cols = rtrn_cols(temp_data, "id|count|cat", exclude = F), maxWidth = 100)
      ,colDef_colWidth_robust(cols = rtrn_cols(temp_data, "cap|cat", exclude = F), maxWidth = 150)
      ,colDef_filter_select(cols = rtrn_cols(temp_data, words = "summary|cap", exclude = T), id = id)    ), wrap = T, elementId = id, height =  700
  ) %>%
    rctble_format_table()

  return(temp_table)
}








