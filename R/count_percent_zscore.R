count_percent_zscore = function (data, grp_c = ..., grp_p = ..., grp_z = ..., col,
          prefix = NULL, rnd = NULL, cntr_scl = FALSE)
{
  tmp = data %>% dplyr::group_by(across({
    {
      grp_c
    }
  })) %>% dplyr::summarise(count = sum({
    {
      col
    }
  })) %>% dplyr::ungroup() %>% dplyr::group_by(across({
    {
      grp_p
    }
  })) %>% dplyr::mutate(percent = (count/sum(count)) %>% {
    if (!is.null(rnd))
      round(., rnd)
    else .
  }) %>% dplyr::ungroup() %>% {
    if (cntr_scl)
      (.) %>% dplyr::group_by(across({
        {
          grp_z
        }
      })) %>% dplyr::mutate(zscore = as.vector(scale(count)))
    else .
  }
  if (is.null(prefix)) {
    tmp
  }
  else {
    newname1 = stringr::str_glue("{prefix}_count")
    newname2 = stringr::str_glue("{prefix}_percent")
    dplyr::rename(tmp, `:=`(!!newname1, count), `:=`(!!newname2,
                                                     percent))
  }
}
