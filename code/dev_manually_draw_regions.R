





library(tidyverse)
library(sf)
library(mapedit)

data = mapedit::drawFeatures() %>% st_transform(crs = 4326)




# sf_sne = data %>% mutate(location = "Southern New England")
# sf_gom = data %>% mutate(location = "Gule of Maine")
# sf_sa = data %>% mutate(location = "South Atlantic")
# sf_njny = data %>% mutate(location = "New York/New Jersey Bight")
# sf_ma = data %>% mutate(location = "Mid Atlantic")
# sf_ = data %>% mutate(location = "")

bind_rows(
  sf_sne
  ,sf_gom
  ,sf_sa
  ,sf_njny
  ,sf_ma

) %>% write_sf(
  here::here("data", "regional_locations_polys.gpkg")
)

reg = read_sf(
  here::here("data", "regional_locations_polys.gpkg")
)

mapview::mapview(reg)


library(tidyverse)
library(sf)
library(mapedit)
library(gauntletMap)
library(mapview)
# devtools::install_github("RichardPatterson/midlines")
library(midlines)
# install.packages("smoothr")
library(smoothr)

data = mapedit::drawFeatures() %>% st_transform(crs = 4326)

data = data %>%
  st_transform(32610)

mapview::mapview(data)

rad = 20 #meters
var = 900
data %>%
  st_quick_buffer(32610, 32610, rad) %>%
  mapview()

poly = data %>%
  st_quick_buffer(32610, 32610, rad) %>%
  st_union() %>%
  st_quick_buffer(32610, 32610, var) %>%
  st_quick_buffer(32610, 32610, -1*var) %>%
  st_quick_buffer(32610, 32610, -5*rad*.50) %>%
  st_quick_buffer(32610, 32610, var*5) %>%
  st_quick_buffer(32610, 32610, -5*var) %>%
  # st_quick_buffer(32610, 32610, -1*rad*.90) %>%
  # sf::st_simplify(dTolerance = .1) %>%
# st_quick_buffer(32610, 32610, -1*rad*.50) %>%


  st_as_sf()  #%>%
  # sf::st_simplify(dTolerance = 1 )

poly %>%
  # st_quick_buffer(32610, 32610, -1*rad*.90) %>%
  mapview()

cleaned = poly %>%
  midlines_draw(
    # border_line = poly %>%  st_quick_buffer(32610, 32610, -1*rad*.10) %>%  st_cast("LINESTRING")
      dfMaxLength = 1) %>%
  # midlines_clean(n_removed = 10) %>%
  st_union() %>%
  st_as_sf()

cleaned_sm = cleaned %>%
  smooth(method = "spline")

cleaned %>%    sf::st_simplify(dTolerance = .1 ) %>% mapview()

  mapview(cleaned) + mapview(cleaned_sm, color = "red")

plot(m2$geometry, col = c("BLUE", "RED")[m2$removed_flag])


var = 1000

poly %>%
  st_quick_buffer(32610, 32610, var) %>%
  st_quick_buffer(32610, 32610, -1*var) %>%
  # st_quick_buffer(32610, 32610, var) %>%
  # st_quick_buffer(32610, 32610, -1*var) %>%
  mapview() +  mapview(poly, color = "red")

library(leaflet)
editMap(leaflet() %>% addTiles())
leaflet::add
yolo = mapedit::selectMap(
  # mapview(breweries91)@map
  leaflet(breweries91) %>% addTiles() %>%  addCircleMarkers()
  # targetLayerId = "breweries91"
)

mapview::add



mapedit::selectMap(tmp_map
                   ,styleFalse = list(weight = 5, opacity = 0.7)
                   ,styleTrue = list(weight = 10, opacity = 1))



'breweries = breweries %>%
  mutate(number.of.types = runif(nrow(breweries)
                                  ,min(breweries$number.of.types)
                                  ,max(breweries$number.of.types)) %>% round(0)
         ,label = str_glue("{brewery}\n{number.of.types}"))' %>%
  cat()
  paste0(collapse = "\n")
  print()



st_polygonize()



data_buf = data %>%
  st_quick_buffer(32610, 32610, 20)

  data_buf %>%
    st_segmentize(10) %>%
  mapview()






























