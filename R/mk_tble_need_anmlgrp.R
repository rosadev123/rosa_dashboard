mk_tble_need_anmlgrp = function(data){
  # data = tar_read(data_current_needed)

  tmp_data = data %>%
    count_percent_zscore(
      grp_c = c("research_category_crrnt", "research_need_id", "completeion_status", "animal_group")
      ,grp_p = c("research_category_crrnt", "research_need_id", "animal_group")
      ,col = count, rnd = 2
    ) %>%
    select(!c(percent)) %>%
    pivot_wider(values_from = "count"
                ,names_from = 'completeion_status'
                ,values_fill = 0) %>%
    mutate(
      total = pmap_dbl(
        select(., contains("Complete")), sum)
      ,`%_comp.` = round(Complete/total, 2) %>%
        replace_na(0)) %>%
    group_by(research_need_id) %>%
    mutate(
      needs_total = sum(total)
      ,needs_completed = sum(Complete)
      ,`needs_%_comp.` = round(needs_completed/needs_total, 2)
    ) %>%
    ungroup() %>%
    select( "research_need_id", "research_category_crrnt", "animal_group", "Not Complete"
           ,"Complete", "total", "%_comp."
           ,"needs_completed","needs_total", "needs_%_comp.") %>%
    mutate(research_need_id = strg_numeric_order(research_need_id, rev = F)) %>%
    arrange(research_need_id) %>%
    mutate(across(
      c('Complete', 'total', 'needs_completed', 'needs_total')
      ,~.x %>% as.character() %>% strg_numeric_order()
    ))

  id = "id_tble_need_anmlgrp"
  tmp_table = reactable(
    tmp_data %>%
      dplyr::select(!c(`Not Complete`
                       ,`%_comp.`
                       # ,`needs_%_comp.`
                       ))
    ,defaultColDef = colDef(footerStyle = list(fontWeight = "bold"), header = mk_special_header)
    ,columns = combined_named_lists(
      colDef_minwidth(cols = rtrn_cols(tmp_data, "research|animal"), width = 100)
      ,colDef_sticky(cols = rtrn_cols(tmp_data, "research|animal"))
      ,colDef_colWidth_robust(cols = rtrn_cols(tmp_data, "animal"), minWidth = 150)
      ,colDef_colWidth_robust(cols = rtrn_cols(tmp_data, "research_need_id|existing_"), maxWidth = 80)
      ,colDef_filter_select(cols = rtrn_cols(tmp_data, words = "research|animal|Com|total|needs_completed|needs_total ", exclude = F), id = id)
        ,colDef_colorScales(tmp_data, cols = rtrn_cols(tmp_data, "%", exclude = F)
                           ,colors = c("#15607A", "#FA8C00"), rev = T)
    )
    ,columnGroups = list(
      colGroup(name = "Research Need/Animal Grp"
               ,columns = c('Complete', 'total'
                            # , '%_comp.'
               ))
      ,colGroup(name = "Research Need"
                ,columns = c("needs_completed", "needs_total"
                             , "needs_%_comp."
                ))
    )
    ,wrap = T, elementId = id
  ) %>%
    rctble_format_table()

  return(tmp_table)

}

