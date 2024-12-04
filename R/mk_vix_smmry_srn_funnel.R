mk_vix_smmry_srn_funnel =  function(data){
  # data = targets::tar_read(data_srn_pro)

  (data %>%
     select(summarized_research_need_id, count_ern, count_rn) %>%
     mutate(count_rn = count_rn*-1) %>%
     mutate(label = str_glue("{summarized_research_need_id}\nExisting Proj: {count_ern}\nResearch Needs: {abs(count_rn)}")) %>%
     pivot_longer(cols = starts_with("count")) %>%
     ggplot() +
     geom_col(aes(value, summarized_research_need_id, fill = name, text = label)) +
     scale_x_continuous(labels = abs) +
     labs(c = "Number of Porjects", y = "")
  ) %>% ggplotly(tooltip  = "label")
}
