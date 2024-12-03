
mk_tble_project_summary = function(data){
  # data = targets::tar_read(data_current_pro)

  temp_data = data %>%
    select(
      research_project_id_number
      ,project_objectives
      ,location
      ,methodology
      ,project_website
      ,partner_entities
      ,pi_contact_info
      ,project_start_year_mg
      ,project_end_year_mg) %>%
    mutate(across(everything(), as.character)) %>%
    pivot_longer(cols = !"research_project_id_number") %>%
    mutate(
      flag_col = case_when(
        name %in% c("research_project_id_number", "location", "project_website") ~ "col_1"
        ,name %in% c("partner_entities", "project_start_year_mg", "project_objectives") ~ "col_2"
        ,T ~ "col_3")
    ) %>%
    mutate(name = name %>%
             str_remove_all("km|mg")) %>%
    arrange(research_project_id_number, flag_col) %>%
    group_by(research_project_id_number, flag_col)


  temp_data_1 = temp_data %>%
    mutate(index = row_number()
           ,comb = str_glue("<b>{strg_pretty_char(name)}</b> <p>{value}</p>")) %>%
    ungroup() %>%
    select(!c(name, value)) %>%
    pivot_wider(names_from = "flag_col"
                ,values_from = "comb") %>%
    mutate(research_project_id_number = strg_numeric_order(research_project_id_number
                                                           ,rev = F))
    # mutate(col_2 = case_when(
    #   str_detect(col_2, "Project Objectives") & str_count(col_2)<300~str_remove(col_2, "</p>") %>%
    #     str_pad(., 300, "right", " ") %>%
    #     paste0(., "</p>")
    #   ,T~col_2
    # ))

  # temp_data_2 = temp_data %>%
  #   mutate(index = row_number()
  #          ,comb = str_glue("{strg_pretty_char(name)} {value}")) %>%
  #   ungroup() %>%
  #   select(!c(name, value)) %>%
  #   pivot_wider(names_from = "flag_col"
  #               ,values_from = "comb") %>%
  #   mutate(research_project_id_number = strg_numeric_order(research_project_id_number,rev = F))

  temp_data_1_sh = SharedData$new(temp_data_1, group = "yolo")
  # temp_data_2_sh = SharedData$new(temp_data_2, group = "yolo")

  id_1 = "id_tble_project_summary_1"
  # id_2 = "id_tble_project_summary_2"
  temp_output = bscols(
    widths = c(3, 12)
    ,filter_select("id_tble_project_summary_proj", "", temp_data_1_sh, ~research_project_id_number, multiple = F)
    ,reactable(
      temp_data_1_sh
      ,height = 700
      ,defaultColDef = colDef(footerStyle = list(fontWeight = "bold")
                              ,header = mk_special_header
                              ,headerStyle = list(opacity = 0)
      )
      ,columns = combined_named_lists(
        colDef_html(cols = colnames(temp_data_1))
        ,colDef_colWidth_robust(cols = colnames(temp_data_1), maxWidth = 400)
        ,colDef_hide(cols = c("research_project_id_number", "index"))
      ), wrap = T, borderless = T, elementId = id_1) %>%
      reactablefmtr::add_title("Example Project Summary Printout Table") %>%
      rctble_format_table() #%>%
      # rctble_add_download(., id = id_1)
    )

  return(temp_output)
}







