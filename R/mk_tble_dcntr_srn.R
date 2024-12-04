mk_tble_dcntr_srn = function(data, id_sffx = "_1"){
  # data = tar_read(data_srn_pro)

  temp_data = data %>%
    select(!c(starts_with("count"))) %>%
    mutate_at("summarized_research_need_id", strg_numeric_order, rev = F) %>%
    arrange(summarized_research_need_id) %>%
    mutate(across(everything(), replace_na, "NULL")) %>%
    select(summarized_research_need_id, research_category, everything())

  id = paste0("id_tble_smmry_srn_", id_sffx)

  temp_table = reactable(
    temp_data
    ,defaultColDef = colDef(
      footerStyle = list(fontWeight = "bold")
      ,header = mk_special_header)
    ,columns = combined_named_lists(
      colDef_sticky(cols = "summarized_research_need_id")
      ,colDef_colWidth_robust(cols = rtrn_cols(temp_data, "summary", exclude = F), minWidth = 300)
      # ,colDef_colWidth_robust(cols = rtrn_cols(temp_data, "cap|cat", exclude = F), maxWidth = 150)
      # ,colDef_filter_select(cols = rtrn_cols(temp_data, words = "summary|cap", exclude = T), id = id)
    ), wrap = T, elementId = id, height =  700
  ) %>%
    rctble_format_table()

  return(temp_table)
}
