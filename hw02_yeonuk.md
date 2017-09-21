hw02\_yeonuk: Explore Gapminder and use dplyr
================
Yeonuk
September 21, 2017

#### 1. Bring rectangular data in

``` r
suppressPackageStartupMessages(library(tidyverse)) 
suppressPackageStartupMessages(library(gapminder))
knitr::opts_chunk$set(fig.width=4, fig.height=3)
```

#### 2. Smell test the data

-   Is it a data.frame, a matrix, a vector, a list?
    -   Answer: **data.frame** (see the below resut)
-   What’s its class?
    -   Answer: **tbl\_df** and **tbl** (see the below resut)

``` r
str(gapminder)
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    1704 obs. of  6 variables:
    ##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
    ##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
    ##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
    ##  $ pop      : int  8425333 9240934 10267083 11537966 13079460 14880372 12881816 13867957 16317921 22227415 ...
    ##  $ gdpPercap: num  779 821 853 836 740 ...

-   How many variables/columns?
    -   Answer: **6** (see the below resut)
-   How many rows/observations?
    -   Answer: **1704** (see the below resut)

``` r
c(ncol(gapminder), nrow(gapminder))
```

    ## [1]    6 1704

-   Can you get these facts about “extent” or “size” in more than one way? Can you imagine different functions being useful in different contexts?
    -   Answer: I also can use the *str* function to get the numbers of variables and rows (see the first result). As for using different functions, the data types of the *ncol* function and the *nrow* function are *integar* (see the bellow result), so these functions can be used when I need to compute something from the data size (see the bellow example: computing the total number of components).

``` r
typeof(c(ncol(gapminder), nrow(gapminder)))
```

    ## [1] "integer"

``` r
(n_total <- ncol(gapminder)*nrow(gapminder)) # 6 * 1704 = 10224
```

    ## [1] 10224

-   What data type is each variable?
    -   Answer: country & continent = *Factor*, year & pop = *int*, lifeExp & gdpPercap = *num* (see the first result)

#### 3. Explore individual variables

-   Pick **at least** one categorical variable and at least one quantitative variable to explore.
    -   I used two categorial variables *year, continent* and one quantitative variable *lifeExp*
-   What are possible values (or range, whichever is appropriate) of each variable?
-   What values are typical? What's the spread? What's the distribution? Etc., tailored to the variable at hand.
    -   Answer: see the bellow summarized table

``` r
STAT_year <- gapminder %>% group_by(year) %>%
                           summarize(MAX = max(lifeExp), MIN = min(lifeExp), 
                                     MEAN = mean(lifeExp), SD = sd(lifeExp))
STAT_continent <- gapminder %>% group_by(continent) %>%
                           summarize(MAX = max(lifeExp), MIN = min(lifeExp), 
                                     MEAN = mean(lifeExp), SD = sd(lifeExp))

knitr::kable(STAT_year) # life expectation statistic for each year
```

|  year|     MAX|     MIN|      MEAN|        SD|
|-----:|-------:|-------:|---------:|---------:|
|  1952|  72.670|  28.801|  49.05762|  12.22596|
|  1957|  73.470|  30.332|  51.50740|  12.23129|
|  1962|  73.680|  31.997|  53.60925|  12.09724|
|  1967|  74.160|  34.020|  55.67829|  11.71886|
|  1972|  74.720|  35.400|  57.64739|  11.38195|
|  1977|  76.110|  31.220|  59.57016|  11.22723|
|  1982|  77.110|  38.445|  61.53320|  10.77062|
|  1987|  78.670|  39.906|  63.21261|  10.55629|
|  1992|  79.360|  23.599|  64.16034|  11.22738|
|  1997|  80.690|  36.087|  65.01468|  11.55944|
|  2002|  82.000|  39.193|  65.69492|  12.27982|
|  2007|  82.603|  39.613|  67.00742|  12.07302|

``` r
knitr::kable(STAT_continent) # life expectation statistic for each continent
```

| continent |     MAX|     MIN|      MEAN|         SD|
|:----------|-------:|-------:|---------:|----------:|
| Africa    |  76.442|  23.599|  48.86533|   9.150210|
| Americas  |  80.653|  37.579|  64.65874|   9.345088|
| Asia      |  82.603|  28.801|  60.06490|  11.864532|
| Europe    |  81.757|  43.585|  71.90369|   5.433178|
| Oceania   |  81.235|  69.120|  74.32621|   3.795611|

#### Explore various plot types & Use *filter()*, *select()* and *%&gt;%*

Make a few plots, probably of the same variable you chose to characterize numerically. Try to explore more than one plot type. **Just as an example** of what I mean:

-   A scatterplot of two quantitative variables.
-   A plot of one quantitative variable. Maybe a histogram or densityplot or frequency polygon.
-   A plot of one quantitative variable and one categorical. Maybe boxplots for several continents or countries.

You don't have to use all the data in every plot! It's fine to filter down to one country or small handful of countries.

#### But I want to do more!

*For people who want to take things further.*

Evaluate this code and describe the result. Presumably the analyst's intent was to get the data for Rwanda and Afghanistan. Did they succeed? Why or why not? If not, what is the correct way to do this?

``` r
filter(gapminder, country == c("Rwanda", "Afghanistan"))
```

    ## # A tibble: 12 x 6
    ##        country continent  year lifeExp      pop gdpPercap
    ##         <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>
    ##  1 Afghanistan      Asia  1957  30.332  9240934  820.8530
    ##  2 Afghanistan      Asia  1967  34.020 11537966  836.1971
    ##  3 Afghanistan      Asia  1977  38.438 14880372  786.1134
    ##  4 Afghanistan      Asia  1987  40.822 13867957  852.3959
    ##  5 Afghanistan      Asia  1997  41.763 22227415  635.3414
    ##  6 Afghanistan      Asia  2007  43.828 31889923  974.5803
    ##  7      Rwanda    Africa  1952  40.000  2534927  493.3239
    ##  8      Rwanda    Africa  1962  43.000  3051242  597.4731
    ##  9      Rwanda    Africa  1972  44.600  3992121  590.5807
    ## 10      Rwanda    Africa  1982  46.218  5507565  881.5706
    ## 11      Rwanda    Africa  1992  23.599  7290203  737.0686
    ## 12      Rwanda    Africa  2002  43.413  7852401  785.6538

Read [What I do when I get a new data set as told through tweets](http://simplystatistics.org/2014/06/13/what-i-do-when-i-get-a-new-data-set-as-told-through-tweets/) from [SimplyStatistics](http://simplystatistics.org) to get some ideas!

Use more of the dplyr functions for operating on a single table.

-   [Introduction to dplyr](block009_dplyr-intro.html)
-   [`dplyr` functions for a single dataset](block010_dplyr-end-single-table.html)

Adapt exercises from the chapters in the "Explore" section of [R for Data Science](http://r4ds.had.co.nz) to the Gapminder dataset.

### Report my process

> One problem which I've suffered from is that I do not understand the exact meaning of *class*. Frankly speaking, I am not sure my answer for *class* is correct or not.
>
> Using the function *kable* is the most easiest thing although I haven't learn in class. Also the tables modified by this function look tidy. I think it is pretty useful when using markdown.
