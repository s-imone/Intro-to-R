---
title: 'Create your first map'
description: 'In this chapter we'll go through the basis of creating simple maps.'
---

## Maps!

```yaml
type: NormalExercise 
xp: 100 
key: 0180c62511   
```

Dataset `crime.dt` and libraries `data.table`, `zoo`, `ggplot2`, and `rgdal` are pre-loaded to your environment. `rgdal` allows us to work with geospatial data, `ggplot2` is flexible enough to allow us to plot maps. `crime.dt` includes columns with longitude and latitude of the reported crime. In this chapter we will learn how to project the reported crimes on a map of London. To do that we are missing one thing: a file to draw the map of London. That is `london`, already loaded to your environment. `london` is a shapefile. A shapefile is a geospatial vector data format for geographic information system (GIS) software that can spatially describe vector features, such as points, lines, and polygons. Have a look at [this](https://en.wikipedia.org/wiki/Shapefile) for more on shapefiles. For now, all you need to know is that a shapefile is actually a collection of files with a common prefix, living in a common environment. The .shp file is the actual feature geometry. Let's start by having a look at `london`. 

By typing `class(london)` you can see it is a `SpatialPolygonsDataFrame` object. It holds non-geographic attribute data (type `head(london@data)` to take a look at it), coordinates to draw polygons of the geographical areas in the data (try typing `london@polygons`), info on the coordinate reference system (CRS) (`lnd@proj4string`). By simply typing `plot(london)` in your console, you can print your first map. The function `plot()` is smart, and recognises the class of data you are passing through it. 



```{r}
set.seed(1246912) # set the seed to make the example reproducible
my.dt <- data.table(x = runif(120, 0, 10), y = rnorm(120, 0,1), z = rbinom(120,1,0.25)) # create a random data.table

my.dt[z==1, treat := TRUE] # create a new column. value conditional on value of z
my.dt[z==0, treat := FALSE] # modify existing column

my.dt[, mean.x := mean(x), by = z] # mean of x by z

my.dt
```

In this chapter, we will start by doing some data manipulation in order to produce basic figures. First, we will create a new column in `n.crime.month` with the proportion of crime types by month. Let's call it `crime.pct`.

Once we have proportions of crime types over all reported crimes, let's put those proportions in a graph, to have a look at how they have varied over the course of 2017. Finally, let's use a bar graph to see how bicycle thefts are distributed by month. To derive these graphs we'll use the `ggplot2` library. If you want to dive deeper into `ggplot`, have a look at [this](http://r-statistics.co/Complete-Ggplot2-Tutorial-Part1-With-R-Code.html).

For now, we'll just plot a line and a bar graph to give you a taste of how cool and flexible `ggplot` is. But keep in mind that we are barely scratching the surface. Let's have a look at the following example to get a sense of how `ggplot` works:

```{r}
set.seed(124433)
# add a date column to the data
my.dt[, month := sample(seq(as.Date('2017/01/01'), as.Date('2017/12/01'), by="month"), 120, replace = TRUE)]
my.dt <- my.dt[order(month)] # order the data for plotly graph

my.dt[, mean.x.month := mean(x), by = month]

library(ggplot2)
# basic line graph
ggplot(data = my.dt) +
  geom_line(aes(x = month, y = mean.x.month))

# compute average by treat
my.dt[, mean.x.month.treat := mean(x), by = .(month, treat)]

# plot by group - you can also assign plots to objects to add layers to it at a later stage
plot1 <- ggplot(data = my.dt) +
  geom_line(aes(x = month, y = mean.x.month.treat, color = treat)) # we'll have two lines. One for each group

# Now the simplest of bar graphs
set.seed(1237834)
new.dt <- data.table(foo = sample(1:5, size = 100, prob = runif(5, min = 0, max = 1), replace = TRUE))
plot2 <- ggplot(data = new.dt) + geom_bar(aes(x = foo))
```


`@instructions`
- Create a column in `n.crime.month` with the proportion of crime types by month. Name it `crime.pct`
- Use `ggplot` to create a line plot of `crime.pct` by `month`. Name it `plot1`. Remember that `crime.pct` was computed by crime type
- Using `crime.dt`, use `ggplot` to create a bar graph of bicycle thefts by month. Name it `plot2`. Remember to subset your data.

`@hint`
- Have you divided `N` by the sum of `N` by `month`?
- Have you assigned your plot to an object? Have you used the `geom_line()` function?
- Did you try subsetting your data? Try passing `crime.dt[crime.type=="Bicycle theft"]` as `data` argument for your plot.

`@pre_exercise_code`

```{r}
library(data.table)
library(zoo)
library(ggplot2)
library(rgdal)

lnd <- readOGR("", "london_sport")
proj4string(lnd) <- CRS("+init=epsg:27700")
london <- spTransform(lnd, CRS("+init=epsg:4326")) # extracts info from the .shp file - right?
crime.dt <- get(load(url("https://assets.datacamp.com/production/repositories/3473/datasets/f419d934cee09d6d378e34767c8e93c0961563a4/crime_dt_wide_1.rda")))
n.crime.month <- get(load(url("https://assets.datacamp.com/production/repositories/3473/datasets/a74a89c152247ab14d23fb87d255f0b022542c59/n_crime_month.rda")))
```


`@sample_code`

```{r}
# Create a column with the proportion of crime types by month. Name it crime.pct
# ...
# Use ggplot to create a line plot of crime.pct by month. Name it plot1
# ...
# Use ggplot to create a bar plot of the number of bicycle thefts by month. Name it plot2
# ...
```


`@solution`

```{r}
n.crime.month[, crime.pct := N/sum(N), by = year.month]

plot1 <- ggplot(data = n.crime.month) +
  geom_line(aes(x = year.month, y = crime.pct, color = crime.type))

plot2 <- ggplot(data = crime.dt[crime.type=="Bicycle theft"]) +
  geom_bar(aes(x = year.month))
```


`@sct`

```{r}
all(n.crime.month[, sum(crime.pct)==1, by = year.month][,V1]==1)

plot1$labels[1]=="year.month"
plot1$labels[2]=="crime.pct"
plot1$labels[3]=="crime.type"

plot2$label[1]=="year.month"
plot2$label[2]=="count"
plot2$label[3]=="weight"
```


