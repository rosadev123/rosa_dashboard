mk_tble_dcntr_acc = function(data){

  # data = tar_read(data_acro_list_pro)

  id = "acronyms_list"
  temp_table = reactable(
    data
    ,columns = combined_named_lists(
      colDef_colWidth_robust(cols = "Acronym", maxWidth = 300)
    ),defaultColDef = colDef(footerStyle = list(fontWeight = "bold"), header = mk_special_header)
    ,wrap = F, elementId = id
  ) %>%
    rctble_format_table() %>%
    rctble_add_download(., id = id)

  return(temp_table)
}
