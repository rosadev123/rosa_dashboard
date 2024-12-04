library(tidyverse)

tt = c("tibble", "tidyverse", "magrittr","gauntlet"
  ,"bosFunctions"
  ,"reactable", "reactablefmtr", "crosstalk", "plotly", "bslib","bsicons", "htmltools") %>%
  gauntlet::package_load()

tar_load(data_needed_pro)


lines = readLines("analysis/rosa_dashboard.qmd") %>%
  .[stringr::str_detect(., target_string)] %>%
  {if(rm_tar) .[!stringr::str_detect(., "tar_read")] else .} %>%
  {if(rm_spce) gsub(" .*", "", .) else .} %>%
  {if(print_tar) stringr::str_glue("tar_load({.})") else .}

return(lines)
}

target_string = "data_|viz_proj|viz_tble"
file = "analysis/rosa_dashboard.qmd"

tar_scan_file = function(file, print_tar = FALSE){

  index_tar_ref = readLines("_targets.r") %>%
    .[stringr::str_detect(., ".*tar_target\\(")] %>%
    gsub(".*tar_target\\(", "\\1", .) %>%
    gsub(",.*", "\\1", .) %>%
    .[!(. == "")] %>%
    paste0(collapse = "|")

  lines = readLines(file) %>%
    paste0(collapse = " ") %>%
    stringr::str_split(" ") %>%
    .[[1]] %>%
    .[stringr::str_detect(., index_tar_ref)] %>%
    gsub(str_glue(".*({index_tar_ref}).*"), "\\1", .) %>%
    unique() %>%
    sort() %>%
    {if(print_tar) stringr::str_glue("tar_load({.})") else .}

  return(lines)
}

tar_scan_file(file = "analysis/rosa_dashboard.qmd", T)



