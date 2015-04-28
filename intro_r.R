## software capentry
## pracice for R 
x<-8
x <- 8
y <- x*2
ls() # lists bjects in environment

# create a vector of weights
weights <- c(50, 60, 80, 85)
animals <- c("panda", "haathi")
length(animals)

# find class of an object
class (animals)
class (weights)

# structure of an object
str(animals)

# adding elements to a vector
weights <- c(30, weights)
weights <- c(30, weights)
weights

z <- c(x,y,weights)
z
mean(z)
median(z)
mode(z)
?median
length(z)

## practice with real data
getwd()
list.files()
gapminder <- read.csv("gapminder.csv")
head(gapminder)
class(gapminder)
str(gapminder)
## 'data.frame':  1704 obs. of  6 variables: 1704 rows with 6 columns
## $ country  : Factor w/ 142 levels -> factor is a categorical variables
gapminder[1,3]
gapminder[500,5:6]
gapminder$pop[1:10]

## for specific country
gapminder[gapminder$country == "Finland",]
## countries and years where pop <=100000
gapminder[gapminder$pop <=100000, c("country", "year")]

gapminder[50,4] == gapminder[50,"lifeExp"]
gapminder[50,c("lifeExp")] == gapminder$lifeExp[50]

## countries with lifeExp > 80
gapminder[gapminder$lifeExp > 80, c("country", "year")]

## installing a package
install.packages("dplyr")
library("dplyr")
library("ggplot2")

select (gapminder, country, year, pop)
filter (gapminder, country == "Finland")
## selecting and filetrib at the same time
##  piping - symbol in R is %>%   takes from left and passes to right
## below we filter and then select 
## shortcut in windows ctrl-shft-m
gapminder_sml <- gapminder %>%
  filter(pop <= 100000) %>%
  select(country, year)
gapminder_sml

## using pipes subset the gapminder data to include rows where gdp is >= 35000, 
## retain country year ad gdpPercap
gapminder_gdp <- gapminder %>%
  filter (gdpPercap >= 35000) %>%
  select (country, year, gdpPercap)
gapminder_gdp

## adding new columns to the dataset
## function in dplyr is "mutate"
gapminder %<>%
  mutate (totalgdp = gdpPercap * pop) %>%
  head
str (gapminder)

gapminder %>% 
  mutate (totalgdp = gdpPercap * pop) %>%
  group_by(continent) %>% 
  dplyr :: summarise(meangdp = mean (totalgdp))
## "dplyr :: summarise" will use summarise from dplyr package

gapminder %>% 
  mutate (totalgdp = gdpPercap * pop) %>%
  group_by(continent, year) %>% 
  summarise(meangdp = mean (totalgdp))

gapminder %>% 
  mutate (totalgdp = gdpPercap * pop) %>%
  group_by(continent, year) %>% 
  summarise(meangdp = mean (totalgdp), mingdp = min(totalgdp))
gapminder %>% head


## finding max lifeExp by each continent

gapminder %>% 
  group_by(continent) %>% 
  summarise(maxLifeExp = max (lifeExp))
  
## finding mean, min and max lifeExp for each year

gapminder %>% 
  group_by(year) %>% 
  summarise(maxLifeExp = max (lifeExp), minLifeExp = min (lifeExp), meanLifeExp = mean (lifeExp))

## pick a country and find pop for each year in the dara prior to 1982
gapminder %>% 
  filter(year < 1982) %>%
  filter (country == "India")  %>% 
  select(country, year, pop)

gapminder %>% 
  filter(year < 1982 , country == "India")  %>% 
  select(country, year, pop)
  
 ## opens the documentation / help file for dplyr package where we can see all he fucntions
library(help = dplyr)

## writing files
write.csv(gapminder_sml, "gapminder_sml.csv")
list.files()


