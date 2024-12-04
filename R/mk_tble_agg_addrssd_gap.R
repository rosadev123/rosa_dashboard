mk_tble_agg_addrssd_gap = function(data){
  # data = tar_read(data_needProj_gap)

  temp_data = data %>%
    mutate(Total = pmap_dbl(select(., !contains("research")), sum) %>%
             as.integer()) #%>%
    # rename(research_need = research_category)
    # rename_with(pretty_char)

  temp_table = reactable(
    temp_data
    ,defaultColDef = colDef(footerStyle = list(fontWeight = "bold"), header = mk_special_header)
    ,groupBy = c("research_category")
    ,columns = combined_named_lists(
      colDef_agg(cols = c(
        "Adequately Addressed", "Partially Addressed"
        ,"Not Addressed", "Missing Data", 'Total'), rm_footer = T)
      ,colDef_sticky(col = rtrn_cols(temp_data, "research_", F), side = "left")
      ,colDef_colWidth_robust(cols = rtrn_cols(temp_data, "research_category", F), minWidth = 100)
      ,colDef_colWidth_robust(cols = rtrn_cols(temp_data, "research_need", F), minWidth = 150)
      # ,colDef_filter_select(cols = rtrn_cols(temp_data, words = "Addressed|Missing|Total", exclude = F), id = id)
      ,colDef_colorScales(temp_data, cols = rtrn_cols(temp_data, words = "Addressed|Missing|Total")
                          ,colors = c("#FFFFFF", "#FA8C00"))
    )
    ,columnGroups = list(
      colGroup(name = "Aggregated Columns"
               ,columns = rtrn_cols(temp_data, words = "Addressed|Missing|Total", exclude = F)
      )
    )
    ,wrap = T
  ) %>%
    rctble_format_table()

  return(temp_table)
}


