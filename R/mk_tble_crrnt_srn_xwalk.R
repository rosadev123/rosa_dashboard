mk_tble_crrnt_srn_xwalk = function(data, id_sffx){
  # data = tar_read(data_current_srn)

  tmp_data = data %>%
    # glimpse()
    select(
      id_srn
      ,id_ern
      ,receptor
      ,methodology
      ,location
    ) %>%
    arrange(id_srn, id_ern)

  id = paste("id_tble_crrnt_srn_xwalk_", id_sffx)
  temp_table =
    reactable(
    tmp_data
    ,defaultColDef = colDef(footerStyle = list(fontWeight = "bold"), header = mk_special_header)
    ,columns = combined_named_lists(
      colDef_sticky(cols = c("id_srn", "id_ern"))
      ,colDef_colWidth_robust(cols = rtrn_cols(tmp_data, "itle"), minWidth = 250)
      ,colDef_colWidth_robust(cols = rtrn_cols(tmp_data, "id_"), maxWidth = 100)
      ,colDef_filter_select(cols = rtrn_cols(tmp_data, words = "zzzz", exclude = T), id = id)
    ), wrap = T, elementId = id
  ) %>%
    rctble_format_table()

  return(temp_table)

}
