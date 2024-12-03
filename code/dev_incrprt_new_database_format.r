#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# This is script [[insert brief readme here]]
#
# By: mike gaunt, michael.gaunt@wsp.com
#
# README: [[insert brief readme here]]
#-------- [[insert brief readme here]]
#
# *please use 80 character margins
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#library set-up=================================================================
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#content in this section should be removed if in production - ok for dev
library(tidyverse)
library(gauntlet)

#path set-up====================================================================
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#content in this section should be removed if in production - ok for dev

#source helpers/utilities=======================================================
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#content in this section should be removed if in production - ok for dev

#source data====================================================================
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#content in this section should be removed if in production - ok for dev
#area to upload data with and to perform initial munging
#please add test data here so that others may use/unit test these scripts
data_raw =  readxl::read_xlsx(
  here::here(
    "data/Re_ FishFORWRD Database Updates - June"
    ,"FishFORWRD Research Projects_CLEAN_6.28.24.xlsx"
  )
)


#main header====================================================================
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

temp_data = data_raw %>%
  janitor::clean_names() %>%
  mutate(count = 1) %>%
  mutate(project_start_year_mg = as.numeric(project_start_year_mg)
         ,project_end_year_mg = as.numeric(estimated_project_end_year_mg)) %>% #issue here with name - will have to change it later
  filter(!is.na(research_project_id_number)) %>%
  #removal_step
  #--step removes old research_cat attributes
  #--also added step that deals with nulls and converts to NAs
  #NOTE!!! mg20240710 - this is not an issue anymore  since they have been changed
  # select(!starts_with("research_category")) %>%
  # rename(
  #   "research_category" = identified_research_need
  #   ,"research_category_2" = identified_research_need2) %>%
  mutate(across(where(is.character)
                ,~case_when(.x %in% c("Null", "NULL")~NA_character_, T~.x) %>%
                  replace_na("NULL"))) |>
  #NOTE: HOT FIX ----- NEEDS TO BE REMOVED AND CORRECTED FOR LATER
  mutate(animal_group = receptor) |>
  mutate(research_category = research_category2) |>
  mutate(partner_entities = partern_entities) |>
  mutate(project_funding_source = funder)
#section_end


temp_data |>  colnames() |> sort()


##sub header 1==================================================================
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

mk_tble_crrnt_proj_shrt(temp_data)
mk_viz_prj_timeline(temp_data)
mk_viz_proj_location_bar(temp_data, filter = F)

temp_data |>  count(location, )

##sub header 2==================================================================
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#script end=====================================================================











































