mk_tble_agg_needs_animal_cmplt = function(data){

  # data = tar_read(data_current_needed)

  temp_data = data %>%
    count_percent_zscore(
      grp_c = c("research_need_id", "research_need", "research_category_crrnt")
      ,grp_p = c("research_need_id", "research_need")
      ,col = count
      ,rnd = 2
    ) %>%
    group_by(research_need_id) %>%
    mutate(total_projects = sum(count)) %>% ungroup() %>%
    select(!c(count)) %>%
    pivot_wider(names_from = research_category_crrnt, values_from = percent)  %>%
    rename_with(gauntlet::strg_pretty_char)

  temp_data = temp_data %>%
    mutate(across(
      c(rtrn_cols(temp_data, words = "Research Need|Total", pretty = FALSE, exclude = T, sort = T))
      ,~replace_na(.x, 0)
    ))

  temp_table = reactable(
    temp_data
    ,defaultColDef = colDef(footerStyle = list(fontWeight = "bold"))
    ,columns = combined_named_lists(
      colDef_sticky(
        cols = rtrn_cols(temp_data, "Research Need|Total")
      )
      ,colDef_colorScales(
        temp_data
        ,cols = rtrn_cols(
          data = temp_data
          ,words = "research|total"
          ,exclude = T)
        ,colors = c("#15607A", "#FA8C00"), rev = T))
    ,columnGroups = list(
      colGroup(name = "Percent of Existing Project Research Needs"
               ,columns = rtrn_cols(temp_data, "Research Need|Total", exclude = T))
    ), wrap = F
  ) %>%
    rctble_format_table()

  return(temp_table)

}








