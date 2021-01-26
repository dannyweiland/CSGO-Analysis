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


#Lets look at the distribution of win rates in terms of percent
winRatesMap %>%
  adorn_percentages("col") %>%
  adorn_pct_formatting(digits = 1)


#We can see while the win rates are close to even, there is some variation across the different maps.
#I decided to run a two sample t-test here to analyze whether the difference in these two groups is statistically significant.
#To get this data to a format into which this is possible requires a little data manipulation.

esea_meta_demos3$CounterTerroristWin <- ifelse(esea_meta_demos3$winner_side == "CounterTerrorist", 1, 0)
esea_meta_demos3$TerroristWin <- ifelse(esea_meta_demos3$winner_side == "Terrorist", 1, 0)


#Now we have two new binary columns that will allow us to continue our analysis,
#We can continue to perform our difference in means T-test


#Ho: Mean win percentage of Counter Terrorists is 50%
#Ha: Counter Terrorist win percentage != 50%
t.test(esea_meta_demos3$CounterTerroristWin, mu = .50)






