hw03: manipulate & explore data (dplyr, ggplot2)
================
Yeonuk
September 28, 2017

##### Packages which I used

``` r
suppressPackageStartupMessages(library(tidyverse)) 
```

    ## Warning: package 'dplyr' was built under R version 3.4.2

``` r
suppressPackageStartupMessages(library(gapminder))
suppressPackageStartupMessages(library(cowplot))
```

    ## Warning: package 'cowplot' was built under R version 3.4.2

``` r
suppressPackageStartupMessages(library(grid))
suppressPackageStartupMessages(library(gridExtra))
```

    ## Warning: package 'gridExtra' was built under R version 3.4.2

``` r
knitr::opts_chunk$set(fig.width=10, fig.height=7)
```

Report my process
-----------------

> I worked for **4 tasks** (1st, 2nd, 4th, and 6th tasks). I tried my best to analyze Gapminder data set. All the tasks include figures and tables.
>
> *Please enjoy the results!!*

Homework
--------

### Task 1: Get the maximum and minimum of GDP per capita for all continents.

-   See the table and boxplot. You can find not only the Max/Min values but also the country and year for the max/min values.

``` r
# extract max and min of gdpPercap
data10 <- gapminder %>% group_by(continent) %>% 
  summarise(MAX = max(gdpPercap),MIN = min(gdpPercap)) 

# extract country and year which are with max and min of gdpPercap
data11 <- gapminder %>% filter(gdpPercap %in% data10$MAX) %>% 
  mutate(MAX_info = paste(country, year, sep=", ")) %>% 
  select(continent, MAX_info) 
data12 <- gapminder %>% filter(gdpPercap %in% data10$MIN) %>% 
  mutate(MIN_info = paste(country, year, sep=", ")) %>% 
  select(continent, MIN_info)

# rearrange by name of continent (alphabet)
data11 <- arrange(data11, continent) 
data12 <- arrange(data12, continent)

# merge data and make table
Task1 <- data.frame(data10, MAX_info=data11$MAX_info, MIN_info=data12$MIN_info)

rm(data10,data11,data12)
knitr::kable(Task1)
```

| continent |        MAX|         MIN| MAX\_info           | MIN\_info                    |
|:----------|----------:|-----------:|:--------------------|:-----------------------------|
| Africa    |   21951.21|    241.1659| Libya, 1977         | Congo, Dem. Rep., 2002       |
| Americas  |   42951.65|   1201.6372| United States, 2007 | Haiti, 2007                  |
| Asia      |  113523.13|    331.0000| Kuwait, 1957        | Myanmar, 1952                |
| Europe    |   49357.19|    973.5332| Norway, 2007        | Bosnia and Herzegovina, 1952 |
| Oceania   |   34435.37|  10039.5956| Australia, 2007     | Australia, 1952              |

``` r
#drawing boxplot with texts (country, year) on max and min points
Plot1 <- gapminder %>% ggplot(aes(continent, gdpPercap)) +
     geom_boxplot(aes(fill=continent)) +
     geom_text(aes(label=ifelse(gdpPercap %in% c(Task1$MAX,Task1$MIN), 
                                paste(country,year,sep=", \n"),''), angle=5)) +
     scale_y_continuous(limits=c(-10000,120000)) +
     theme_light()+ 
     labs(y="GDP per capita", title="GDP BoxPlot for each continent with max & min info")

Plot1
```

![](hw03_yeonuk_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-1.png)

### Task 2: Look at the spread of GDP per capita within the continents.

-   See the table and boxplot.

``` r
Task2 <- gapminder %>% group_by(continent) %>% 
                      summarize(MAX = max(gdpPercap), MIN = min(gdpPercap), 
                      MEAN = mean(gdpPercap), SD = sd(gdpPercap), 
                      Q1 = quantile(gdpPercap,probs=0.25), 
                      Q2 = quantile(gdpPercap,probs=0.5),
                      Q3 = quantile(gdpPercap,probs=0.75))
knitr::kable(Task2)  
```

| continent |        MAX|         MIN|       MEAN|         SD|         Q1|         Q2|         Q3|
|:----------|----------:|-----------:|----------:|----------:|----------:|----------:|----------:|
| Africa    |   21951.21|    241.1659|   2193.755|   2827.930|    761.247|   1192.138|   2377.417|
| Americas  |   42951.65|   1201.6372|   7136.110|   6396.764|   3427.779|   5465.510|   7830.210|
| Asia      |  113523.13|    331.0000|   7902.150|  14045.373|   1056.993|   2646.787|   8549.256|
| Europe    |   49357.19|    973.5332|  14469.476|   9355.213|   7213.085|  12081.749|  20461.386|
| Oceania   |   34435.37|  10039.5956|  18621.609|   6358.983|  14141.859|  17983.304|  22214.117|

``` r
Plot2 <- gapminder %>% ggplot(aes(gdpPercap)) 
      
Plot20 <- Plot2 + 
      geom_freqpoly(aes(gdpPercap,..density..,colour=continent), binwidth = 1800) +
      labs(x="GDP per capita", title="GDP histogram for each continent") +theme_bw()
Plot21 <- Plot2 + 
      facet_wrap( ~ continent) + 
      geom_histogram(aes(gdpPercap,..density..), bins =65, colour="blue") +
      labs(x="GDP per capita") +theme_bw()


plot_grid(Plot20, Plot21, ncol = 1, nrow = 2)
```

![](hw03_yeonuk_files/figure-markdown_github-ascii_identifiers/set(fig.height=12)-1.png)

### Task 4: How is life expectancy changing over time on different continents?

``` r
Data4 <- gapminder %>% group_by(continent, year) %>%
  summarise(M = mean(lifeExp), SD = sqrt(var(lifeExp)))

AF <- Data4 %>% filter(continent == "Africa")
AM <- Data4 %>% filter(continent == "Americas")
AS <- Data4 %>% filter(continent == "Asia") 
EU <- Data4 %>% filter(continent == "Europe") 
OC <- Data4 %>% filter(continent == "Oceania") 

Task4 <- cbind(AF,AM,AS,EU,OC)
Task4 <- Task4[-c(1,5,6,9,10,13,14,17,18)]
names(Task4) <- c("year", "AF_mean", "AF_SD", "AM_mean", "AM_SD", 
                  "AS_mean", "AS_SD", "EU_mean", "EU_SD", "OC_mean", "OC_SD")
rm(AF, AM, AS, EU,OC)

knitr::kable(Task4)  
```

|  year|  AF\_mean|    AF\_SD|  AM\_mean|    AM\_SD|  AS\_mean|     AS\_SD|  EU\_mean|    EU\_SD|  OC\_mean|     OC\_SD|
|-----:|---------:|---------:|---------:|---------:|---------:|----------:|---------:|---------:|---------:|----------:|
|  1952|  39.13550|  5.151581|  53.27984|  9.326082|  46.31439|   9.291751|  64.40850|  6.361088|   69.2550|  0.1909188|
|  1957|  41.26635|  5.620123|  55.96028|  9.033192|  49.31854|   9.635429|  66.70307|  5.295805|   70.2950|  0.0494975|
|  1962|  43.31944|  5.875364|  58.39876|  8.503544|  51.56322|   9.820632|  68.53923|  4.302500|   71.0850|  0.2192031|
|  1967|  45.33454|  6.082673|  60.41092|  7.909171|  54.66364|   9.650965|  69.73760|  3.799729|   71.3100|  0.2969848|
|  1972|  47.45094|  6.416258|  62.39492|  7.323017|  57.31927|   9.722700|  70.77503|  3.240576|   71.9100|  0.0282843|
|  1977|  49.58042|  6.808197|  64.39156|  7.069496|  59.61056|  10.022197|  71.93777|  3.121030|   72.8550|  0.8980256|
|  1982|  51.59287|  7.375940|  66.22884|  6.720834|  62.61794|   8.535221|  72.80640|  3.218260|   74.2900|  0.6363961|
|  1987|  53.34479|  7.864089|  68.09072|  5.801929|  64.85118|   8.203792|  73.64217|  3.169680|   75.3200|  1.4142136|
|  1992|  53.62958|  9.461071|  69.56836|  5.167104|  66.53721|   8.075549|  74.44010|  3.209781|   76.9450|  0.8697413|
|  1997|  53.59827|  9.103387|  71.15048|  4.887584|  68.02052|   8.091171|  75.50517|  3.104677|   78.1900|  0.9050967|
|  2002|  53.32523|  9.586496|  72.42204|  4.799705|  69.23388|   8.374595|  76.70060|  2.922180|   79.7400|  0.8909545|
|  2007|  54.80604|  9.630781|  73.60812|  4.440948|  70.72848|   7.963724|  77.64860|  2.979813|   80.7195|  0.7290271|

``` r
Plot40 <- ggplot(Data4, aes(year,M,colour=continent)) +
    geom_errorbar(aes(ymin=M-SD/2, ymax=M+SD/2), colour="black", width=.5, alpha=0.5) +
    geom_line() +
    geom_point() +
    labs(y="Annual mean for Life Exp with SD") +theme_bw()

Plot41 <- gapminder %>% ggplot(aes(x=year,y=lifeExp, colour=continent)) +
  geom_boxplot(aes(group = year)) +
  facet_grid(continent ~.) +
  labs(y="boxplot for Life Exp") +theme_bw()

plot_grid(Plot40, Plot41, ncol = 1, nrow = 2)
```

![](hw03_yeonuk_files/figure-markdown_github-ascii_identifiers/set(fig.height=30)-1.png)

### Task 6: Find countries with interesting stories. Open-ended and, therefore, hard.
