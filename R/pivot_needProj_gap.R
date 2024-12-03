pivot_needProj_gap = function(data){
  # data = tar_read(data_current_pro)
  # data = tar_read(data_needed_pro)

  data %>%
    gauntlet::count_percent_zscore(
      grp_c = c('research_category', "identified_research_need", 'data_gap_analysis_score_mg')
      ,grp_p = c('research_category', 'identified_research_need')
      ,col = count, rnd =2) %>%
    select(!c(percent)) %>%
    complete(research_category, identified_research_need, data_gap_analysis_score_mg, fill = list(count = 0)) %>%
    pivot_wider(values_from = count, names_from = data_gap_analysis_score_mg) %>%
    select(research_category, identified_research_need
           ,`Adequately Addressed`, `Partially Addressed`
           ,`Not Addressed`, `Missing Data`)
}
