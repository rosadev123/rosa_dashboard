mk_tble_dcntr_ref = function(data){

  # data = tar_read(data_references_pro)

  temp_data = data %>%
    # select(!c('Notes', 'database_notes')) %>%
    mutate(`Reference ID #` = strg_numeric_order(`Reference ID #`, rev = F)) %>%
    arrange(`Reference ID #`) %>%
    mutate(across(everything(), replace_na, "NULL"))

  id = "references"
  temp_table = reactable(
    temp_data
    ,columns = combined_named_lists(
      # colDef_agg(cols = c(as.character(1:28), 'Grand Total'), rm_footer = T)
      colDef_urlLink(cols = rtrn_cols(temp_data, "Link"), link_text = "Link to site")
      ,colDef_colWidth_robust(cols = rtrn_cols(temp_data, "Full Citation|Notes")
                              ,wrap = T, minWidth = 400)
      ,colDef_sticky(col = rtrn_cols(temp_data, "Reference ID")
                     ,side = "right")
    )
    ,defaultColDef = colDef(footerStyle = list(fontWeight = "bold"), header = mk_special_header)
    ,wrap = T
    ,elementId = id
  ) %>%
    rctble_format_table() %>%
    rctble_add_download(., id = id)

  return(temp_table)
}
