mend_ern_ids = function(col){
  col %>%
    str_to_lower() %>%
    str_squish() %>%
    str_trim() %>%
    str_replace_all(., "ex-", "Ex-")
}


mend_rn_ids = function(col){
  col %>%
    str_to_lower() %>%
    str_squish() %>%
    str_trim() %>%
    str_replace_all(., "rn-", "RN-")
}



