#Win Rates
#Statistical Analysis of Win Rates per Map

#Import Libraries
library(dplyr)
library(janitor)


#Import Datasets
esea_meta_demos1 <- read.csv("esea_meta_demos.part1.csv")
esea_meta_demos2 <- read.csv("esea_meta_Demos.part2.csv")


#Combine the two dataframes
esea_meta_demos3 <- rbind(esea_meta_demos1, esea_meta_demos2)


#Here I discovered that there was just 1 observation where the winning side was "None",
#This could possibly be explained by a game crash. I used the following code to remove this observation.
esea_meta_demos3 <- esea_meta_demos3[!(esea_meta_demos3$winner_side=="None"),]


#Win Rates throughout the whole dataset
winRates <- tabyl(esea_meta_demos3, winner_side)
winRates


#Win Rates By Map
winRatesMap <- tabyl(esea_meta_demos3, winner_side, map)
winRatesMap


#Win Rates By Map
winRatesMap <- tabyl(esea_meta_demos3, winner_side, map)
winRatesMap 


#Lets look at the distribution of win rates in terms of percent
winRatesMap %>%
  adorn_percentages("col") %>%
  adorn_pct_formatting(digits = 1)






