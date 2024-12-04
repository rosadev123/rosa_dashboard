prcss_def_terms = function(data){
  # data = tar_read(data_rosa_dbase_list)

  data[["5. Definition of Terms"]] %>%
    janitor::remove_empty("cols") %>%
    # janitor::clean_names() %>%
    dplyr::select(!starts_with("x"))
}
