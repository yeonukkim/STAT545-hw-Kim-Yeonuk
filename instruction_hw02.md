---
title: "Homework 02: Explore Gapminder and use dplyr"
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Overview

Consult the [general homework guidelines](hw00_homework-guidelines.html). Though, you still won't be using a repo in the stat545 github org. This may or may not happen this year! See [Make a homework repo](#make-a-homework-repo) below for guidelines on making a repo.

Due anytime Tuesday 2017-09-26. Before class is better, but get help in class or office hours of you need it.

The goal is to explore a new-to-you dataset. In particular, to begin to establish a workflow for data frames or "tibbles". You will use dplyr and ggplot2 to do some description and visualization.

Your homework should serve as your own personal cheatsheet in the future for things to do with a new dataset. Give yourself the cheatsheet you deserve!

#### Make a homework repo

We might not be getting you a repo in the stat545 github org. Time will tell! For now, we will make a new GitHub repository that will hold the remainder of your homework submissions (until specified otherwise). 

1. Make a new GitHub repo called `STAT545-hw-lastname-firstname`. Note:
    - Feel free to just use your Homework 01 repo, and rename it.
    - If you want your homework to be private, here are your options:
        - Request a GitHub [student developer pack](https://education.github.com/pack). It's free and will allow you to make free GitHub repos.
        - Use [Bitbucket](https://bitbucket.org/). It's free, gives you free private repos, and works similarly to github. Let me (`@vcoia`) know via Slack if you'd like to try this.
        - Slack me if neither of these are good. I've got another option.

2. Put your Homework 02 files in a folder that's obviously named (say, `hw02`), and link to it in the main README. Be sure to put a README file in the Homework 02 folder as well, describing what's what in the directory and how someone might navigate the homework submission.


#### Bring rectangular data in

Work with the `gapminder` data we explored in class. *If you really want to, you can explore a different dataset but get permission from Vincenzo. Message me on Slack -- my handle is `@vcoia`. Self-assess the suitability of your dataset by reading [this issue](https://github.com/STAT545-UBC/Discussion/issues/115).*

The Gapminder data is distributed as an R package from [CRAN](https://cran.r-project.org/web/packages/gapminder/index.html).

Install it if you have not done so already and remember to load it.

``` r
install.packages("gapminder")
library(gapminder)
```

Install and load dplyr. Probably via the tidyverse meta-package.

``` r
install.packages("tidyverse")
library(tidyverse)
```

#### Smell test the data

Explore the `gapminder` object:

  * Is it a data.frame, a matrix, a vector, a list?
  * What's its class?
  * How many variables/columns?
  * How many rows/observations?
  * Can you get these facts about "extent" or "size" in more than one way? Can you imagine different functions being useful in different contexts?
  * What data type is each variable?

Be sure to justify your answers by calling the appropriate R functions. 

#### Explore individual variables

Pick __at least__ one categorical variable and at least one quantitative variable to explore.

  * What are possible values (or range, whichever is appropriate) of each variable?
  * What values are typical? What's the spread? What's the distribution? Etc., tailored to the variable at hand.
  * Feel free to use summary stats, tables, figures. We're NOT expecting high production value (yet).

#### Explore various plot types

See the [`ggplot2` tutorial](https://github.com/jennybc/ggplot2-tutorial), which also uses the `gapminder` data, for ideas.

Make a few plots, probably of the same variable you chose to characterize numerically. Try to explore more than one plot type. **Just as an example** of what I mean:

  * A scatterplot of two quantitative variables.
  * A plot of one quantitative variable. Maybe a histogram or densityplot or frequency polygon.
  * A plot of one quantitative variable and one categorical. Maybe boxplots for several continents or countries.

You don't have to use all the data in every plot! It's fine to filter down to one country or small handful of countries.

#### Use `filter()`, `select()` and `%>%`

Use `filter()` to create data subsets that you want to plot.

Practice piping together `filter()` and `select()`. Possibly even piping into `ggplot()`.

#### But I want to do more!

*For people who want to take things further.*

Evaluate this code and describe the result. Presumably the analyst's intent was to get the data for Rwanda and Afghanistan. Did they succeed? Why or why not? If not, what is the correct way to do this?

```
filter(gapminder, country == c("Rwanda", "Afghanistan"))
```

Read [What I do when I get a new data set as told through tweets](http://simplystatistics.org/2014/06/13/what-i-do-when-i-get-a-new-data-set-as-told-through-tweets/) from [SimplyStatistics](http://simplystatistics.org) to get some ideas!

Present numerical tables in a more attractive form, such as using `knitr::kable()`.

Use more of the dplyr functions for operating on a single table.

  * [Introduction to dplyr](block009_dplyr-intro.html)
  * [`dplyr` functions for a single dataset](block010_dplyr-end-single-table.html)

Adapt exercises from the chapters in the "Explore" section of [R for Data Science](http://r4ds.had.co.nz) to the Gapminder dataset.

### Report your process

Reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc. What things were hard, even though you saw them in class? What was easy(-ish) even though we haven't done it in class?

### Submit the assignment

As in Homework 01:

1. Add the teaching team as collaborators, if you haven't done that already. Their github alias' are:

> vincenzocoia
> gvdr
> ksedivyhaley
> joeybernhardt
> mynamedaike
> pgonzaleze
> derekcho


2. Write a new issue entitled `hw02 ready for grading`, and tag the above teaching team. Here's a convenient string to copy and paste to tag the team:

> @vincenzocoia @gvdr @ksedivyhaley @joeybernhardt @mynamedaike @pgonzaleze @derekcho

3. You're done!

### Rubric

Our [general rubric](peer-review01_marking-rubric.html) applies, but also ...

Check minus: There are some mistakes or omissions, such as the number of rows or variables in the data frame. Or maybe no confirmation of its class or that of the variables inside. There are no plots or there's just one type of plot (and its probably a scatterplot). There's no use of `filter()` or `select()`. It's hard to figure out which file I'm supposed to be looking at. Maybe the student forgot to commit and push the figures to GitHub.

Check: Hits all the elements. No obvious mistakes. Pleasant to read. No heroic detective work required. Solid.

Check plus: Some "above and beyond", creativity, etc. You learned something new from reviewing their work and you're eager to incorporate it into your work now. Use of dplyr goes beyond `filter()` and `select()`. The ggplot2 figures are quite diverse. The repo is very organized and it's a breeze to find the file for this homework specifically.
