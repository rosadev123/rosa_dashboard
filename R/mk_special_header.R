mk_special_header = function(value, str_l = 10){
  # print(str_length(value) > 10 )

  if(str_length(value) > 10) {

    # print("hello")

    value = value %>%
      str_to_lower() %>%
      str_replace(., "research", "rsrch.") %>%
      str_replace(., "project", "proj.") %>%
      str_replace(., "group", "grp.") %>%
      str_replace(., "development", "dev.") %>%
      str_replace(., "identified", "ident.") %>%
      # str_replace(., "identification", "ID.") %>%
      str_replace(., "animal", "anml.") %>%
      str_replace(., "available", "avail.") %>%
      str_replace(., "partner", "prtner.")

  }

  value = value %>%
    str_replace(., "y_n", "y/n") %>%
    strg_pretty_char() %>%
    # str_wrap(width = 10) %>%
    str_replace_all("Pi ", "PI ")

  # print(value)

  return(value)

}

