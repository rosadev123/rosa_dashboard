prcss_references = function(data){
  # data = tar_read(data_rosa_dbase_list)

  data[["4. references"]] %>%
    janitor::remove_empty("cols") %>%
    # janitor::clean_names() %>%
    dplyr::select(!starts_with("x"))
}
