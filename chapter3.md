---
title: 'Use `ggplot` and `plotly` to create nice figures'
description: 'In this section we will do some preliminary graphical exploration of the crime data.'
---

## Graphs with `ggplot` and `plotly`

```yaml
type: NormalExercise 
lang: r
xp: 100 
skills: 3
key: 7a27dde1f7   
```


Data `n.crime.month`, and libraries `data.table`, `zoo`, `ggplot2`, and `plotly` are pre-loaded to your environment. Before starting, let's add another function to our `data.table` stack: `:=` - or assignment by reference. Try to type `?":="` in your console to take a look at the documentation. The `:=` operator allows you to create new variables or to modify existing ones in a `data.table` object. For instance:

```{r}
set.seed(1246912) # set the seed to make the example reproducible
my.dt <- data.table(x = runif(120, 0, 10), y = rnorm(120, 0,1), z = rbinom(120,1,0.25)) # create a random data.table

my.dt[z==1, treat := TRUE] # create a new column. value conditional on value of z
my.dt[z==0, treat := FALSE] # modify existing column

my.dt[, mean.x := mean(x), by = z] # mean of x by z

my.dt
```

In this chapter, we will start by doing some data manipulation in order to produce basic figures. First, we will create a new column in `n.crime.month` with the proportion of crime types by month. Let's call it `crime.pct`.

Once we have proportions of crime types over all reported crimes, let's put those proportions in a graph, to have a look at how they have varied over the course of 2017. To do that we'll use first `ggplot2`, then `plotly`. If you want to dive deeper into `ggplot`, have a look at [this](http://r-statistics.co/Complete-Ggplot2-Tutorial-Part1-With-R-Code.html). For `plotly`, you can start from [here](https://plot.ly/r/#fundamentals).

For now, we'll just plot a couple of line graphs to give you a taste of how cool and flexible these libraries are. But keep in mind that we are barely scratching the surface. Let's have a look at the following example:

```{r}
set.seed(124433)
# add a date column to the data
my.dt[, month := sample(seq(as.Date('2017/01/01'), as.Date('2017/12/01'), by="month"), 120, replace = TRUE)]
my.dt <- my.dt[order(month)] # order the data for plotly graph

my.dt[, mean.x.month := mean(x), by = month]

library(ggplot2)
library(plotly)
# basic line graph
ggplot(data = my.dt) +
  geom_line(aes(x = month, y = mean.x.month))

plot_ly(data = my.dt, x = ~month, y = ~mean.x.month, mode = 'lines')

# compute average by treat
my.dt[, mean.x.month.treat := mean(x), by = .(month, treat)]

# plot by group - you can also assign plots to objects to add layers to it at a later stage
plot1 <- ggplot(data = my.dt) +
  geom_line(aes(x = month, y = mean.x.month.treat, color = treat)) # we'll have two lines. One for each group

plot2 <- plot_ly(data = my.dt, x = ~month, y = ~mean.x.month.treat, color = ~treat, mode = 'lines')
```

`@instructions`
- Create a column in `n.crime.month` with the proportion of crime types by month. Name it `crime.pct`
- Use `ggplot` to create a line plot of `crime.pct` by `month`. Name it `plot1`. Remember that `crime.pct` was computed by crime type
- Now use `plotly` to create the same graph. Name it `plot2`

`@hint`
- Have you noticed that `prop.table()` takes a `table` object as argument? Have you set the right `margin` for your proportional table?
- Arguments of `by` must be a list. Use `list()` or `.()`
- To create a `data.table`, try wrapping your functions in `.()`

`@pre_exercise_code`

```{r}
library(data.table)
library(zoo)
library(ggplot2)
library(plotly)
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


