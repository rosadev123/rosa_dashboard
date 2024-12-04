mk_tble_dcntr_def = function(data){
  # data = tar_read(data_def_terms_pro)

  id = "terms_definition"
  temp_table = reactable(
    data %>% .[,c(1:3)]
    ,columns = combined_named_lists(
      colDef_colWidth_robust(cols = rtrn_cols(data, "erm"), maxWidth = 300)
    ), defaultColDef = colDef(footerStyle = list(fontWeight = "bold"), header = mk_special_header)
    ,wrap = T, elementId = id
  ) %>%
    rctble_format_table() %>%
    rctble_add_download(., id = id)
  return(temp_table)
}
