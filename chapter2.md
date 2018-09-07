---
title: 'Use data.table features to summarise your data'
description: 'In this section we will explore our crime data. We''ll apply a few useful functionalities from data.table to derive some basic summary stats.'
---

## Basic data exploration with data.table

```yaml
type: NormalExercise
key: TrRF46JWfP
lang: r
xp: 100
skills: 1
```

Data `crime.dt`, and libraries `data.table`, and `zoo` are pre-loaded to your environment. Have a look at your data by printing a subset of rows to screen - just type `crime.dt`. If you just want to know  the dimensions of the data, you can type `dim(crime.dt)`.

In this chapter, we will try to subset rows and columns, and to obtain some simple summary statistics on reported crimes in London. To start playing around, you can start by printing the following in your console. 

```{r}
crime.dt[year.month=="Jul 2017"] # subset of all crimes committed in July 2017
crime.dt[year.month=="Apr 2017" & crime.type=="Bicycle theft"] # all bycicle thefts in April 2017
```

If you want to select a column from your `data.table`, say `crime.type`, you can do either one of the following
```{r}
crime.dt[,crime.type] # will return a vector
crime.dt[, list(crime.type)] # will return a data.table, and is equivalent to
crime.dt[,.(crime.type)] # which I will be using from now on
```

If you want to count your data, you can use the function `.N`, which stores the number of observations in the group you selected. Try typing `crime.dt[,.N]`. Then try typing `crime.dt[, .N, by = year.month]`, or `crime.dt[, .N, by = .(year.month, lsoa.name)]`. What's happened there? You just learned how to use `by` and created two new `data.table` objects with counts of reported crimes by month, and by month and lower super output area.

Each row of `crime.dt` corresponds to one reported crime in London. Column `crime.type` reports the crime category under which the crime was recorded by the police. Try to type `crime.dt[, table(crime.type)]` in your console to get counts of crime types in the data.

Once you got an understanding of the data structure, let's try to obtain some more detailed tables. Try to create a `table` object of the proportion of crime type by month. Use columns `crime.type` and `year.month`. Assign the table to an object named `my.prop.table`. Use functions `table()` and `prop.table()`. Type `?prop.table` to take a look at the documentation, and be careful when setting `margin`.

Finally, using `.N` and `by` let's create a `data.table` object with counts of reported crimes by `year.month` and `crime.type`. Assign the object to a `data.table` and name it `n.crime.month`. Then use functions `mean()` and `sd()` to get a `data.table` showing average counts and standard deviations of crime types across months. Name it `my.sum.stats`.

`@instructions`
- Create a `table` of proportions of crime type by month. Assign the table to an object named `my.prop.table`
- Create a `data.table` of counts of reported crimes by `year.month` and `crime.type`. Name it `n.crime.month`
- Create a `data.table` of average and standard deviation of crime type counts across months. Name it `my.sum.stats`

`@hint`
- Have you noticed that `prop.table()` takes a `table` object as argument? Have you set the right `margin` for your proportional table?
- Arguments of `by` must be a list. Use `list()` or `.()`
- To create a `data.table`, try wrapping your functions in `.()`

`@pre_exercise_code`
```{r}
library(data.table)
library(zoo)
crime.dt <- get(load(url("https://assets.datacamp.com/production/repositories/3473/datasets/4d5a49235837d2e83ec16f486f1bc541b89286f2/crime_dt_wide_1.rda")))
```

`@sample_code`
```{r}
# Create a table of proportions of crime types by month
# ...
# Create a month of the year column
# ...
# Create a year column
# ...
```

`@solution`
```{r}
my.prop.table <- crime.dt[, prop.table(table(crime.type, year.month), margin = 2)]

n.crime.month <- crime.dt[,.N,by=list(year.month, crime.type)]

my.sum.stats <- n.crime.month[,list(mean(N), sd(N)), by = crime.type]	
```

`@sct`
```{r}
# all(colSums(my.prop.table)==1)

# sum(duplicated(n.crime.month[,list(year.month, crime.type)]))==0 & all(dim(n.crime.month)==c(132,3))
       
# sum(duplicated(my.sum.stats[,list(crime.type)]))==0 & all(dim(my.sum.stats)==c(11,3))

success_msg("Well done! Let's put some of this very important information in some graph now.")
```
