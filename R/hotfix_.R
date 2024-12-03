#
colDef_urlLink_hotfix = function (cols, link_text){
  tmp_coldef = colDef(cell = function(value, index) {
    mydata1 <- try(RETRY("GET", url = value, times = 1))
    if (is(mydata1, "try-error")) mydata1 <- list(status_code = 404)
    if(mydata1$status_code == 200){
      # print("herro")

       tt = htmltools::tags$a(href = value, target = "_blank", as.character(link_text))

    } else {
      # print("herro3333")
      tt = "Bad/Missing Link"

    }
    # htmltools::tags$a(href = value, target = "_blank", as.character(link_text))

    return(tt)
  })

  list_of_colDefs <- lapply(cols, function(col) {
    return(tmp_coldef)
  })

  named_list_of_colDefs <- setNames(list_of_colDefs, cols)
}

colDef_urlLink_spec_hotfix = function(cols, col_url, data){
  # browser()

  tmp_coldef_cols <- reactable::colDef(
    html = TRUE
    ,cell = function(value,index) {
      mydata1 <- try(RETRY("GET", url = data[[col_url]][index], times = 1))
      if (is(mydata1, "try-error")) mydata1 <- list(status_code = 404)
      if(mydata1$status_code == 200){
      tt = sprintf("<a href=\"%s\" target=\"_blank\">%s</a>", data[[col_url]][index], value)
      } else {

        tt = value

      }

      return(tt)
    })

  list_of_colDefs_cols <- lapply(cols, function(col) {
    return(tmp_coldef_cols)
  })

  named_list_of_colDefs_cols <- stats::setNames(
    list_of_colDefs_cols,
                                                cols)

  tmp_coldef_col_url <- reactable::colDef(
    show = F, cell = function(value,
                              index) {
    })

  list_of_colDefs_col_url <- lapply(col_url, function(col) {
    return(tmp_coldef_col_url)
  })

  named_list_of_colDefs_col_url <- stats::setNames(
    list_of_colDefs_col_url,
    col_url)

  lists <- c(named_list_of_colDefs_cols, named_list_of_colDefs_col_url)
  return(lists)
}




