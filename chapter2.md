---
title: 'Load your first `data.table`'
description: 'In this section we will explore our crime data. We''ll apply a few useful functionalities from `data.table`. We''ll also try to derive some basic summary stats using `data.table`''s power. Hold on to your hat! `crime.dt` is our basic data. Let''s find out what it''s about. We''ll be using libraries `data.table` and `zoo`. They have been pre-loaded to your environment.'
---

## Basic data cleaning with `data.table`

```yaml
type: NormalExercise 
lang: r
xp: 100 
skills: 1
key: 7a27dde1f7   
```

Data `crime.dt`, `data.table`, and `zoo` are pre-loaded to your environment. 


`@instructions`
- Use `setnames()` and `tolower()` to make your column names lower case.
- Use `zoo`'s function `month()` to create a column with the month of your date. Call the new column `month`
- Use `zoo`'s function `year()` to create a column with the year of your date. Call the new column `year`

`@hint`
- Try typing `?` followed by the name of the function to take a look at the documentation. Have you tried `setnames(crime.dt, old = old_names, new = new_names)`? You might also want to use the function `names()`.
- Have you tried typing `?data.table` to have a look at basic `data.table` syntax? You probably want to use the `set` operator `:=`.
- So don't provide the answer, but don't just reiterate the instructions.
- Typically one hint per instruction is a sensible amount.

`@pre_exercise_code`

```{r}
library(data.table)
library(zoo)
crime.dt <- get(load(url("https://assets.datacamp.com/production/repositories/3473/datasets/fb814fc6f7bf21aade47c3352ebaadfbc5d80985/crime_dt_wide.rda")))
```


`@sample_code`

```{r}
# Set column names to lower case
# ...
# Create a month of the year column
# ...
# Create a year column
# ...
```


`@solution`

```{r}
setnames(crime.dt, old = names(crime.dt), new = tolower(names(crime.dt)))

crime.dt[, month := month(year.month)]
crime.dt[, year := year(year.month)]
```


`@sct`

```{r}
# Update this to something more informative.
all(names(crime.dt)==tolower(names(crime.dt)))
# test_object("names(crime.dt)", incorrect_msg = "Something is wrong with the column names of `crime.dt`. Make sure they are all lower case!.")
       
crime.dt[, class(month)=="integer"]
crime.dt[, class(year)=="integer"]

success_msg("Well done! Let's try to have a look at the data now.")
```
