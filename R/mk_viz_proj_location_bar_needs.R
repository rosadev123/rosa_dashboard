mk_viz_proj_location_bar_needs = function(
    data, filter = T){

  # data = tar_read(data_needed_pro)

  temp_data = data %>%
    mutate(location = str_remove_all(location, "[:punct:]") %>%
             strg_pretty_char()) %>%
    select(location, research_category, count, data_gap_analysis_score) %>%
    arrange(location) %>%
    filter(data_gap_analysis_score == "Not Addressed")

    # filter(location %in% c("Not Specified", "Ma"))

  test_1 = temp_data %>%
    count_percent_zscore(
      grp_c = c("location", "research_category")
      ,grp_p = c("location")
      ,col = count, rnd = 4
    ) %>%
    rename(parent = location, label = research_category     )

  test_2 =  temp_data %>%
    count_percent_zscore(
      grp_c = c("location")
      ,grp_p = c()
      ,col = count, rnd = 4
    ) %>%
    rename(label = location)

  temp_data = bind_rows(
    test_1
    ,test_2
  ) %>%
    mutate(
      parent = replace_na(parent, "")
    ) %>%
    mutate(label_adj = str_glue("{parent}_{label}") %>%
             as.character() %>%
             gsub("^_", "\\1", .)) %>%
    mutate(id_1 = case_when(label %in% test_2$label~label, T~label_adj))

  temp_plot =
    plot_ly(data = temp_data,
            type= "treemap"
            ,values = ~count
            ,labels = ~label
            ,ids = ~id_1
            ,parents=  ~parent
            # ,domain= list(column=1)
            # ,name = " "
            # ,maxdepth=2
            ,branchvalues = "total"
            # ,count = "branches+leaves"
    )

  return(temp_plot)
}
