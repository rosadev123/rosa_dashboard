make_nav_bar = function(viz_tble_dcntr_def = viz_tble_dcntr_def){
  navset_card_tab(
    # height = 450,
    full_screen = TRUE,
    title = "HTML Widgets",
    nav_panel(
      "Plotly",
      card_title("A plotly plot"),
      plot(mtcars)
    ),
    nav_panel(
      "Leaflet",
      viz_tble_dcntr_def
    ),
    nav_panel(
      shiny::icon("circle-info"),
      markdown("Learn more about [htmlwidgets](http://www.htmlwidgets.org/)")
    )
  )


}
