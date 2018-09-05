---
title: 'Create your first map'
description: 'In this chapter we''ll go through the basis of creating simple maps'
---

## Maps!

```yaml
type: NormalExercise
key: 7f0e7762b6
xp: 100
```

Dataset `crime.dt` and libraries `data.table`, `zoo`, `ggplot2`, and `rgdal` are pre-loaded to your environment. `rgdal` allows us to work with geospatial data, `ggplot2` is flexible enough to allow us to plot maps. `crime.dt` includes columns with longitude and latitude of the reported crime. In this chapter we will learn how to project the reported crimes on a map of London. To do that we are missing one thing: a file to draw the map of London. That is `london`, already loaded to your environment. `london` is a shapefile. A shapefile is a geospatial vector data format for geographic information system (GIS) software that can spatially describe vector features, such as points, lines, and polygons. Have a look at [this](https://en.wikipedia.org/wiki/Shapefile) for more on shapefiles. For now, all you need to know is that a shapefile is actually a collection of files with a common prefix, living in a common environment. The .shp file is the actual feature geometry. Let's start by having a look at `london`. 

By typing `class(london)` you can see it is a `SpatialPolygonsDataFrame` object. It holds non-geographic attribute data (type `head(london@data)` to take a look at it), coordinates to draw polygons of the geographical areas in the data (try typing `london@polygons`), info on the coordinate reference system (CRS) (`lnd@proj4string`). By simply typing `plot(london)` in your console, you can print your first map. The function `plot()` is smart, and recognises the class of data you are passing through it.

`@instructions`


`@hint`


`@pre_exercise_code`
```{r}
library(data.table)
library(zoo)
library(ggplot2)
library(rgdal)

lnd <- readOGR("https://assets.datacamp.com/production/repositories/3473/datasets/ca1f9d22d318a9016987edb655f15bdde124f0fc/london_sport.shp", "london_sport")
proj4string(lnd) <- CRS("+init=epsg:27700")
london <- spTransform(lnd, CRS("+init=epsg:4326")) # extracts info from the .shp file - right?
crime.dt <- get(load(url("https://assets.datacamp.com/production/repositories/3473/datasets/6a71e8d051656a611adf39c33fe106eb3344c1ee/crime_dt_long.rda")))
```

`@sample_code`
```{r}

```

`@solution`
```{r}

```

`@sct`
```{r}

```
