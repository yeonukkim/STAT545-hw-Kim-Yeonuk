hw02\_yeonuk
================
Yeonuk
September 21, 2017

FYI
---

> Homework 02: Explore Gapminder and use dplyr
>
> All the contents are made by R markdown.

### 1. Bring rectangular data in

``` r
suppressPackageStartupMessages(library(tidyverse)) 
suppressPackageStartupMessages(library(gapminder))
knitr::opts_chunk$set(fig.width=4, fig.height=3)
```

### 2. Smell test the data

-   Is it a data.frame, a matrix, a vector, a list?
-   Answer: **data.frame** (Please see the below resut)

-   What’s its class?
-   Answer: **tbl\_df** and **tbl** (Please see the below resut)

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
-   Answer: **6** (Please see the below resut)

``` r
ncol(gapminder)
```

    ## [1] 6

-   How many rows/observations?
-   Answer: **1704** (Please see the below resut)

``` r
nrow(gapminder)
```

    ## [1] 1704

-   Can you get these facts about “extent” or “size” in more than one way? Can you imagine different functions being useful in different contexts?
-   Answer: I can use *str* function to get the number of variables and rows (Please see the above result). The data types of *ncol* and *nrow* are *integar*, so these functions can be used when I need to compute something from the data size (Please see the bellow example).

``` r
typeof(ncol(gapminder))
```

    ## [1] "integer"

``` r
(n_total <- ncol(gapminder)*nrow(gapminder))
```

    ## [1] 10224

-   What data type is each variable?

> Answer:

#### 3. Explore individual variables

Pick **at least** one categorical variable and at least one quantitative variable to explore.

-   What are possible values (or range, whichever is appropriate) of each variable?
-   What values are typical? What's the spread? What's the distribution? Etc., tailored to the variable at hand.
-   Feel free to use summary stats, tables, figures. We're NOT expecting high production value (yet).

#### Explore various plot types

See the [`ggplot2` tutorial](https://github.com/jennybc/ggplot2-tutorial), which also uses the `gapminder` data, for ideas.

Make a few plots, probably of the same variable you chose to characterize numerically. Try to explore more than one plot type. **Just as an example** of what I mean:

-   A scatterplot of two quantitative variables.
-   A plot of one quantitative variable. Maybe a histogram or densityplot or frequency polygon.
-   A plot of one quantitative variable and one categorical. Maybe boxplots for several continents or countries.

You don't have to use all the data in every plot! It's fine to filter down to one country or small handful of countries.

#### Use `filter()`, `select()` and `%>%`

Use `filter()` to create data subsets that you want to plot.

Practice piping together `filter()` and `select()`. Possibly even piping into `ggplot()`.

#### But I want to do more!

*For people who want to take things further.*

Evaluate this code and describe the result. Presumably the analyst's intent was to get the data for Rwanda and Afghanistan. Did they succeed? Why or why not? If not, what is the correct way to do this?

    filter(gapminder, country == c("Rwanda", "Afghanistan"))

Read [What I do when I get a new data set as told through tweets](http://simplystatistics.org/2014/06/13/what-i-do-when-i-get-a-new-data-set-as-told-through-tweets/) from [SimplyStatistics](http://simplystatistics.org) to get some ideas!

Present numerical tables in a more attractive form, such as using `knitr::kable()`.

Use more of the dplyr functions for operating on a single table.

-   [Introduction to dplyr](block009_dplyr-intro.html)
-   [`dplyr` functions for a single dataset](block010_dplyr-end-single-table.html)

Adapt exercises from the chapters in the "Explore" section of [R for Data Science](http://r4ds.had.co.nz) to the Gapminder dataset.

### Report your process

Reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc. What things were hard, even though you saw them in class? What was easy(-ish) even though we haven't done it in class?

### Submit the assignment

As in Homework 01:

1.  Add the teaching team as collaborators, if you haven't done that already. Their github alias' are:

> vincenzocoia gvdr ksedivyhaley joeybernhardt mynamedaike pgonzaleze derekcho

1.  Write a new issue entitled `hw02 ready for grading`, and tag the above teaching team. Here's a convenient string to copy and paste to tag the team:

> @vincenzocoia @gvdr @ksedivyhaley @joeybernhardt @mynamedaike @pgonzaleze @derekcho

1.  You're done!

### Rubric

Our [general rubric](peer-review01_marking-rubric.html) applies, but also ...

Check minus: There are some mistakes or omissions, such as the number of rows or variables in the data frame. Or maybe no confirmation of its class or that of the variables inside. There are no plots or there's just one type of plot (and its probably a scatterplot). There's no use of `filter()` or `select()`. It's hard to figure out which file I'm supposed to be looking at. Maybe the student forgot to commit and push the figures to GitHub.

Check: Hits all the elements. No obvious mistakes. Pleasant to read. No heroic detective work required. Solid.

Check plus: Some "above and beyond", creativity, etc. You learned something new from reviewing their work and you're eager to incorporate it into your work now. Use of dplyr goes beyond `filter()` and `select()`. The ggplot2 figures are quite diverse. The repo is very organized and it's a breeze to find the file for this homework specifically.
