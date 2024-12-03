strg_wrap_html = function(x, width = 15, whtspace_only = T){
  stringr::str_wrap(x, width = width, whitespace_only = whtspace_only) %>%
    str_replace_all("\\\n", "<br>")
}
