upload_file_rosa = function(path){

  # path = tar_read(data_rosa_dbase_file)

  # print(path)
#
  excel_sheets = readxl::excel_sheets(path)

  index_data_sheets = c(
    # "Overview"
    "1. research projects"
    ,"2. research needs"
    ,"3. summarized research needs"
    ,"4. references"
    ,"5. Definition of Terms"
    ,"6. Acronyms List"
    # ,"6. Pivot Table"
  )



  #perfrom quick check 0 make sure sheet names are present and legit
  check_sheet_names = (excel_sheets %in% index_data_sheets) %>%  sum()

  stopifnot("Looks like the sheet names have changed\nplease inspect...." = check_sheet_names == 6)

  data_list = list(
    excel_sheets[excel_sheets %in% index_data_sheets]
    ,c(0, 0, 0, 1, 1, 1)
    ) %>%
    pmap(~{
      readxl::read_xlsx(path = path
                        ,sheet = .x
                        ,skip = .y)
    })

  names(data_list) = index_data_sheets

  return(data_list)

}
