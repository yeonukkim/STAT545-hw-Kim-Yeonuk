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
STAT_year_continent <- gapminder %>% group_by(year, continent) %>%
                           summarize(MAX = max(lifeExp), MIN = min(lifeExp), 
                                     MEAN = mean(lifeExp), SD = sd(lifeExp), 
                                     Q1 = quantile(lifeExp,probs=0.25), Q2 = quantile(lifeExp,probs=0.5),
                                     Q3 = quantile(lifeExp,probs=0.75))
knitr::kable(STAT_year_continent) # life expectation statistic for each year and continent
```

|  year| continent |     MAX|     MIN|      MEAN|          SD|        Q1|       Q2|        Q3|
|-----:|:----------|-------:|-------:|---------:|-----------:|---------:|--------:|---------:|
|  1952| Africa    |  52.724|  30.000|  39.13550|   5.1515814|  35.81175|  38.8330|  42.11775|
|  1952| Americas  |  68.750|  37.579|  53.27984|   9.3260819|  45.26200|  54.7450|  59.42100|
|  1952| Asia      |  65.390|  28.801|  46.31439|   9.2917507|  39.41700|  44.8690|  50.93900|
|  1952| Europe    |  72.670|  43.585|  64.40850|   6.3610883|  61.09000|  65.9000|  67.87500|
|  1952| Oceania   |  69.390|  69.120|  69.25500|   0.1909188|  69.18750|  69.2550|  69.32250|
|  1957| Africa    |  58.089|  31.570|  41.26635|   5.6201229|  37.43000|  40.5925|  44.84600|
|  1957| Americas  |  69.960|  40.696|  55.96028|   9.0331923|  48.57000|  56.0740|  62.61000|
|  1957| Asia      |  67.840|  30.332|  49.31854|   9.6354286|  41.90500|  48.2840|  54.08100|
|  1957| Europe    |  73.470|  48.079|  66.70307|   5.2958054|  65.02000|  67.6500|  69.20500|
|  1957| Oceania   |  70.330|  70.260|  70.29500|   0.0494975|  70.27750|  70.2950|  70.31250|
|  1962| Africa    |  60.246|  32.767|  43.31944|   5.8753639|  39.48400|  42.6305|  47.76225|
|  1962| Americas  |  71.300|  43.428|  58.39876|   8.5035437|  52.30700|  58.2990|  65.14200|
|  1962| Asia      |  69.390|  31.997|  51.56322|   9.8206319|  44.50136|  49.3250|  56.92300|
|  1962| Europe    |  73.680|  52.098|  68.53923|   4.3024996|  67.25750|  69.5250|  70.46500|
|  1962| Oceania   |  71.240|  70.930|  71.08500|   0.2192031|  71.00750|  71.0850|  71.16250|
|  1967| Africa    |  61.557|  34.113|  45.33454|   6.0826726|  41.36850|  44.6985|  49.52650|
|  1967| Americas  |  72.130|  45.032|  60.41092|   7.9091710|  55.85500|  60.5230|  65.63400|
|  1967| Asia      |  71.430|  34.020|  54.66364|   9.6509646|  47.83800|  53.6550|  59.94200|
|  1967| Europe    |  74.160|  54.336|  69.73760|   3.7997285|  68.67000|  70.6100|  71.42000|
|  1967| Oceania   |  71.520|  71.100|  71.31000|   0.2969848|  71.20500|  71.3100|  71.41500|
|  1972| Africa    |  64.274|  35.400|  47.45094|   6.4162583|  43.29800|  47.0315|  51.54600|
|  1972| Americas  |  72.880|  46.714|  62.39492|   7.3230168|  58.20700|  63.4410|  67.84900|
|  1972| Asia      |  73.420|  36.088|  57.31927|   9.7227000|  51.92900|  56.9500|  63.98300|
|  1972| Europe    |  74.720|  57.005|  70.77503|   3.2405764|  69.77500|  70.8850|  72.37000|
|  1972| Oceania   |  71.930|  71.890|  71.91000|   0.0282843|  71.90000|  71.9100|  71.92000|
|  1977| Africa    |  67.064|  36.788|  49.58042|   6.8081974|  44.51300|  49.2725|  53.87100|
|  1977| Americas  |  74.210|  49.923|  64.39156|   7.0694956|  58.44700|  66.3530|  69.48100|
|  1977| Asia      |  75.380|  31.220|  59.61056|  10.0221970|  55.49100|  60.7650|  65.94900|
|  1977| Europe    |  76.110|  59.507|  71.93777|   3.1210300|  70.49750|  72.3350|  73.79250|
|  1977| Oceania   |  73.490|  72.220|  72.85500|   0.8980256|  72.53750|  72.8550|  73.17250|
|  1982| Africa    |  69.885|  38.445|  51.59287|   7.3759401|  45.62650|  50.7560|  56.59675|
|  1982| Americas  |  75.760|  51.461|  66.22884|   6.7208338|  61.40600|  67.4050|  70.80500|
|  1982| Asia      |  77.110|  39.854|  62.61794|   8.5352214|  57.48900|  63.7390|  68.75700|
|  1982| Europe    |  76.990|  61.036|  72.80640|   3.2182603|  70.84000|  73.4900|  74.95750|
|  1982| Oceania   |  74.740|  73.840|  74.29000|   0.6363961|  74.06500|  74.2900|  74.51500|
|  1987| Africa    |  71.913|  39.906|  53.34479|   7.8640891|  46.83550|  51.6395|  59.45350|
|  1987| Americas  |  76.860|  53.636|  68.09072|   5.8019288|  64.49200|  69.4980|  71.91800|
|  1987| Asia      |  78.670|  40.822|  64.85118|   8.2037919|  60.13700|  66.2950|  69.81000|
|  1987| Europe    |  77.410|  63.108|  73.64217|   3.1696803|  71.38500|  74.8150|  76.22750|
|  1987| Oceania   |  76.320|  74.320|  75.32000|   1.4142136|  74.82000|  75.3200|  75.82000|
|  1992| Africa    |  73.615|  23.599|  53.62958|   9.4610710|  47.95450|  52.4290|  59.85800|
|  1992| Americas  |  77.950|  55.089|  69.56836|   5.1671038|  66.79800|  69.8620|  72.75200|
|  1992| Asia      |  79.360|  41.674|  66.53721|   8.0755490|  60.83800|  68.6900|  71.19700|
|  1992| Europe    |  78.770|  66.146|  74.44010|   3.2097811|  71.78875|  75.4510|  77.24750|
|  1992| Oceania   |  77.560|  76.330|  76.94500|   0.8697413|  76.63750|  76.9450|  77.25250|
|  1997| Africa    |  74.772|  36.087|  53.59827|   9.1033866|  47.30025|  52.7590|  59.22850|
|  1997| Americas  |  78.610|  56.671|  71.15048|   4.8875839|  69.38800|  72.1460|  74.22300|
|  1997| Asia      |  80.690|  41.763|  68.02052|   8.0911706|  61.81800|  70.2650|  72.49900|
|  1997| Europe    |  79.390|  68.835|  75.50517|   3.1046766|  73.02350|  76.1160|  77.98975|
|  1997| Oceania   |  78.830|  77.550|  78.19000|   0.9050967|  77.87000|  78.1900|  78.51000|
|  2002| Africa    |  75.744|  39.193|  53.32523|   9.5864959|  45.82800|  51.2355|  57.68100|
|  2002| Americas  |  79.770|  58.137|  72.42204|   4.7997055|  70.73400|  72.0470|  75.30700|
|  2002| Asia      |  82.000|  42.129|  69.23388|   8.3745954|  63.61000|  71.0280|  74.19300|
|  2002| Europe    |  80.620|  70.845|  76.70060|   2.9221796|  74.23500|  77.5365|  78.90250|
|  2002| Oceania   |  80.370|  79.110|  79.74000|   0.8909545|  79.42500|  79.7400|  80.05500|
|  2007| Africa    |  76.442|  39.613|  54.80604|   9.6307807|  47.83400|  52.9265|  59.44425|
|  2007| Americas  |  80.653|  60.916|  73.60812|   4.4409476|  71.75200|  72.8990|  76.38400|
|  2007| Asia      |  82.603|  43.828|  70.72848|   7.9637245|  65.48300|  72.3960|  75.63500|
|  2007| Europe    |  81.757|  71.777|  77.64860|   2.9798127|  75.02975|  78.6085|  79.81225|
|  2007| Oceania   |  81.235|  80.204|  80.71950|   0.7290271|  80.46175|  80.7195|  80.97725|

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
