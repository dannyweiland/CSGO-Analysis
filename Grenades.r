#Mapping Grenade Spots in CSGO
#My Goal here is to see where the most common spots to throw and be hit by grenades are by visualizing them on the game map. 


#Import Libraries
library(readxl)
library(dplyr)
library(ggplot2)
library(ggpubr)
library(png)


#Import Data

grenades1 <- read.csv("mm_grenades_demos.csv")

de_dust2_map <- png::readPNG("de_dust2.png")
de_nuke_map <- png::readPNG("de_new_nuke.png")
de_cache_map <- png::readPNG("de_cache.png")
de_cache_map_test <- png::readPNG("de_cache_test.png")


#Plotting on map -----

#Dust2 Attacker Plot
dust2 <- grenades1 %>%
  filter(map == "de_dust2") %>%
  ggplot(., aes(att_pos_x, att_pos_y)) +
  background_image(de_dust2_map)+
  geom_jitter(alpha = 0.1, color = "red")
dust2

#Nuke Attacker Plot
nuke <- grenades1 %>%
  filter(map == "de_nuke") %>%
  ggplot(., aes(att_pos_x, att_pos_y)) +
  background_image(de_nuke_map)+
  geom_jitter(alpha = 0.1, color = "red")

#This one needs to be more properly scaled.  Lets figure that out

#We can solve this by finding the min and max values for each player position.  
mapScale <- grenades1 %>%
  select(map, att_pos_x, att_pos_y) %>%
  group_by(map) %>%
  summarise(
    max_att_pos_x = max(att_pos_x),
    max_att_pos_y = max(att_pos_y),
    min_att_pos_x = min(att_pos_x),
    min_att_pos_y = min(att_pos_y)
  ) %>%
  arrange(map)

  
#Increase the value to essentially "shrink" the size of the plot relative to the image

#Cache Attacker Plot
cache <- grenades1 %>%
  filter(map == "de_cache") %>%
  ggplot(., aes(att_pos_x, att_pos_y)) +
  background_image(de_cache_map_test)+
  geom_jitter(color = "red")+
  
cache

#When completed, re-add alpha = .1 next to color to show density


