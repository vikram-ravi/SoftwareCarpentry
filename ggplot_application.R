##---------------------
## working with ggplot2
## ggplot2 is one of the packages for plotting available in R
## grammar of graphics by gg wilkinson
##---------------------
library(ggplot2)
rm(list=ls())
gapminder <- read.csv("gapminder.csv")
head(gapminder)
class(gapminder)

## scatterplot of lifeExp vs gdpPeccap

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) +geom_point() + scale_x_log10()
## or 
p<- ggplot(gapminder, aes(x=gdpPercap, y=lifeExp))
p2<- p + geom_point()+ scale_x_log10()
print (p2)

## another way to plot log scale
ggplot(gapminder, aes(x=log10(gdpPercap), y=lifeExp)) +geom_point() 
unique(gapminder$country)
## life exp vs gdp plot for china only

gapminder_ch<- gapminder %>% 
  filter(country == "China")

ggplot(gapminder_ch, aes(x=log10(gdpPercap), y=lifeExp)) +geom_point() 

#or directly pipe ggplot to output from filter instead of making a new dataframe for china
# notice that we dont provide data argument to ggplot here
gapminder %>% 
  #filter(country == "India") %>%
  ggplot(aes(x=log10(gdpPercap), y=lifeExp)) +geom_point(size=2) +aes(colour=continent, alpha =0.1)


## try the size shape and color aesthetics both with categorical variables and numerical variables

gapminder %>% 
  #filter(country == "India") %>%
  ggplot(aes(x=log10(gdpPercap), y=lifeExp, shape=continent, color=continent, size=pop)) + geom_point()

## plot of china but with line
gm_china <- gapminder %>% 
  filter(country == "India")

ggplot(gm_china, aes(x=log10(gdpPercap), y=lifeExp)) + geom_line(color="red") + geom_point(color="green", size=4, alpha = 0.5)
ggplot(gm_china, aes(x=log10(gdpPercap), y=lifeExp)) + geom_line(color="red") + geom_point(aes(color=year), size=4, alpha = 0.5)

## plot of china and india but with line
gm_china_india <- gapminder %>% 
  filter(country == c("United States", "Japan"))
ggplot(gm_china_india, aes(x=(gdpPercap), y=lifeExp)) + 
  geom_line(aes(group=country)) +  # using aes(group=country) creates separate lines for country
  geom_point(aes(color=country), size=4, alpha = 0.5)

## creating a histogram
gapminder %>% 
  filter(year == 2007) %>%
  ggplot(aes(x=lifeExp)) + 
  geom_histogram(binwidth = 2.5,
                 fill="blue",
                 color="black") 

## creating a boxplot
gapminder %>% 
  filter(year == 2007) %>%
  ggplot(aes(y=lifeExp, x=continent)) + 
  geom_boxplot()

## creating a boxplot
gapminder %>% 
  filter(year%in%c(1957:2007)) %>%
  ggplot(aes(y=lifeExp, x=continent)) + 
  geom_boxplot() + coord_flip()

## creating a vertical points plot
gapminder %>% 
  filter(year%in%c(1997:2007)) %>%
  ggplot(aes(y=lifeExp, x=continent)) + 
  geom_boxplot() +
  geom_point(position=position_jitter(width=0.1, height=0))


## faceting
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) +
  geom_point() + scale_x_log10() +
  facet_grid(continent~year)

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, color=continent)) +
  geom_point() + scale_x_log10() +
  facet_wrap(~year)


## select five countries of interest and plot life Exp vs gdpPercap across time w/ geom_line  facetin  by ountry
gapminder %>% 
  filter(country%in%c("China","India", "United States", "France", "Nigeria")) %>%
  ggplot(aes(y=lifeExp, x=gdpPercap, color=country)) + 
  geom_line() +
  facet_wrap(~country)
install.packages(ggthemes)
library(ggthemes)
