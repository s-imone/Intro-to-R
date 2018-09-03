---
title: 'Use `ggplot` and `plotly` to create nice figures'
description: 'In this section we will do some preliminary graphical exploration of the crime data.'
---

## Basic data exploration with `data.table`

```yaml
type: NormalExercise 
lang: r
xp: 100 
skills: 3
key: 7a27dde1f7   
```


Data `n.crime.month`, and libraries `data.table`, `zoo`, `ggplot2`, and `plotly` are pre-loaded to your environment. Before starting, let's add another function to our `data.table` stack: `:=` - or assignment by reference. Try to type `?":="` in your console to take a look at the documentation. The `:=` operator allows you to create new variables and modify existing ones in a `data.table` object. For instance, let's consider the following data:

`
set.seed(1235673528)
data.table(x = runif(100, 0, 10), y = rnorm(100, 0,1), z = rbinom(100,1,0.1))
`

In this chapter, we will try to subset rows and columns, and to obtain some simple summary statistics on reported crimes in London. To create a subset of all crimes committed in July 2017, you would type `crime.dt[year.month=="Jul 2017"]`. For all bycicle thefts in April 2017, you would have to type `crime.dt[year.month=="Apr 2017" & crime.type=="Bicycle theft"]`. If you want to select a column from your `data.table`, say `crime.type`, you can either use `crime.dt[,crime.type]`, which will return a vector, or `crime.dt[, list(crime.type)]`, which will return a `data.table`. The latter syntax is equivalent to `crime.dt[,.(crime.type)]` which I will use from now on. If you want to count your data, you can use the function `.N`, which stores the number of observations in the group you selected. Try typing `crime.dt[,.N]`. Then try typing `crime.dt[, .N, by = year.month]`, or `crime.dt[, .N, by = .(year.month, lsoa.name)]`. What's happened there? You just learned how to use `by` and created two new `data.table` objects with counts of reported crimes by month, and by month and lower super output area.

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
crime.dt <- get(load(url("https://assets.datacamp.com/production/repositories/3473/datasets/fb814fc6f7bf21aade47c3352ebaadfbc5d80985/crime_dt_wide_1.rda")))
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

n.crime.month <- crime.dt[,.N,by=.(year.month, crime.type)]

my.sum.stats <- n.crime.month[,.(mean(N), sd(N)), by = crime.type]
```


`@sct`

```{r}
all(colSums(my.prop.table)==1)

sum(duplicated(n.crime.month[,.(year.month, crime.type)]))==0 & all(dim(n.crime.month)==c(168,3))
       
sum(duplicated(my.sum.stats[,.(crime.type)]))==0 & all(dim(my.sum.stats)==c(14,3))

success_msg("Well done! Let's put some of this very important information in some graph now.")
```


