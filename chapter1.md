---
title: 'Get started with data.table'
description: 'You will load your first `data.table`. You will do some basic data cleaning, like changing column names, and formatting date columns.'
---

## Basic data cleaning with data.table

```yaml
type: NormalExercise
key: 7a27dde1f7
lang: r
xp: 100
skills: 1
```

In the next few sections we'll some basic data manipulation and exploration with the `data.table` package. A `data.table` is an enhanced `data.frame`. `data.table` has a very concise syntax - you can do a lot more things within the frame of a `data.table` than with a `data.frame`. The general `data.table` syntax is `DT[i, j, by]`, where `i` is the row (the `where` in SQL syntax), `j` refers to columns (`select` in SQL), and `by` is the group (`group by`). If you want more on `data.table`, [CRAN](https://cran.r-project.org/) has a great [intro to it](https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html). Before starting, I'll just introduce the function `:=`, which is assignment by reference. The `:=` operator allows you to create new variables or to modify existing ones in a `data.table` object. If you type the following code in your console, you'll create your first `data.table`, then you'll add and modify a couple of columns, and even compute the mean of one of them!

```{r}
set.seed(1246912) # set the seed to make the example reproducible
my.dt <- data.table(x = runif(120, 0, 10), y = rnorm(120, 0,1), z = rbinom(120,1,0.25)) # create a random data.table

my.dt[z==1, treat := TRUE] # create a new column. value conditional on value of z
my.dt[z==0, treat := FALSE] # modify existing column

my.dt[, mean.x := mean(x), by = z] # mean of x by z

my.dt
```

The `crime.dt` data is pre-loaded to your environment. It should already be in a nice enough format. Print the first and the last 5 rows to screen by typing `crime.dt` in your console if you don't trust me! What's not very nice about it is the column names are in upper case letters - that's annoying! -, and the dates are not actual date objects. Fortunately, `data.table` and `zoo` have some nice functions that allow us to deal with these issues very quickly. Let's use the `setnames()` and `tolower()` to change the column names to lower case. Type `?setnames()` and `?tolower()` to take a look at the documentation for these functions.

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
crime.dt <- get(load(url("https://assets.datacamp.com/production/repositories/3473/datasets/a08af3755786bab574c5b4e565922980a72bd612/crime_dt_wide.rda")))
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
