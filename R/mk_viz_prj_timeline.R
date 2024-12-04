mk_viz_prj_timeline = function(data, filter = T){

  # data = tar_read(data_current_pro)

  #mk: perfroms super basic munging
  #--- filter T/F determines if NA projects will be removed or not
  if (filter){
  temp_data = data %>%
    filter(!is.na(project_start_year) &
             !is.na(project_end_year)) %>%
    mutate(research_project_id = strg_numeric_order(research_project_id)) %>%
    arrange(research_project_id)
  } else {
    temp_data = data %>%
      mutate(research_project_id = strg_numeric_order(research_project_id)) %>%
      arrange(research_project_id)

  }

  temp_data_sd = temp_data |>
    mutate(label_start = str_glue("{research_project_id} ({project_start_year} - {project_end_year})\nRsrch Category: {research_category}\nWindfarm Dev Stage: {windfarm_development_stage}\nReceptor: {receptor}")) %>%
    mutate(receptor = str_replace_all(receptor, " ", "\n")) |>
    mutate(receptor = str_replace_all(receptor, "/", "/\n"))

  temp_plot =
    temp_data_sd %>%
    plot_ly() %>%
    add_lines(
      x = year(Sys.Date()), y = ~research_project_id
      ,inherit = FALSE
      ,line = list(color = "lightgrey", alpha = .1)
      ,showlegend = FALSE
      ,text = "Current Year", hoverinfo = "text") %>%
    add_segments(
      x = ~project_start_year, xend = ~project_end_year
      ,y = ~research_project_id, yend = ~research_project_id
      ,color = ~receptor, showlegend = T
      ,text = ~label_start, hoverinfo = "text"
    ) %>%
    layout(
      xaxis = list(title = ""
                   ,range = c(
                     min(temp_data_sd$project_start_year)
                     ,2035))
      ,yaxis = list(title = "")
      ,annotations =
        list(x = 1, y = -.06,
             text = "Note: This graph only displays projects with valid start and end dates.",
             showarrow = F,
             xref='paper',
             yref='paper')
    )

  return(temp_plot)
}
