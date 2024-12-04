mk_viz_proj_location_bar = function(data, filter = T, index){
  # data = tar_read(data_current_pro)
  # index = c("location", "research_category")
  # data = tar_read(data_current_srn)
  # index = c("location", "research_category_srn")
  # data = data

  test_1 = data %>%
    count_percent_zscore(
      grp_c = index
      ,grp_p = index[1]
      ,col = count, rnd = 4
    ) %>%
    set_names(c("parent", "label", "count", "percent")) %>%
    mutate(label = as.character(label))
    # rename(parent = location, label = research_category)

  test_2 =  data %>%
    count_percent_zscore(
      grp_c = index[1]
      ,grp_p = c()
      ,col = count, rnd = 4
    ) %>%
    set_names(c( "label", "count", "percent")) %>%
    mutate(label = as.character(label))

  data = bind_rows(
    test_1
    ,test_2
  ) %>%
    mutate(
      parent = replace_na(parent, "")
    ) %>%
    mutate(label_adj = str_glue("{label}_{parent}") %>%
             as.character()) %>%
    mutate(id_1 = case_when(label %in% test_2$label~label, T~label_adj)) %>%
    mutate(text = str_glue("Count: {count}\nPct%: {100*percent}%")
    )

  temp_plot =
    plot_ly(data = data,
            type= "treemap"
            ,values = ~count
            ,labels = ~label
            ,text = ~text
            ,ids = ~id_1
            ,parents=  ~parent
            ,branchvalues = "total"
    )

  return(temp_plot)
}

# mk_viz_proj_location_bar(data_current_pro, index = c("location", "research_category"))


