---
title: 'Load your first `data.table`'
description: "In this section we will explore our crime data. We'll apply a few useful functionalities from `data.table`. We'll also try to derive some basic summary stats using `data.table`'s power. Hold on to your hat! `crime.dt` is our basic data. Let's find out what it's about. We'll be using libraries `data.table` and `zoo`. They have been pre-loaded to your environment."
---

## Basic data cleaning

```yaml
title: Basic data cleaning with `data.table`
type: NormalExercise
lang: r
xp: 100 
skills: 1
key: 7a27dde1f7   
```


The data should already be in a nice enough format. Print the first and the last rows to screen by typing `crime.dt` in your console if you don't trust me! What's not very nice about it is the column names are in upper case letters - that's annoying! -, and the dates are not actual date objects. Fortunately, `data.table` and `zoo` have some nice functions that allow us to deal with these issues very quickly. Let's use the `setnames()` and `tolower()` to change the column names to lower case. Type `?setnames()` and `tolowr()` to take a look at the documentation for these functions.


`@instructions`
- Use `setnames()` and `tolower()` to make your column names lower case.
- Use `zoo`'s function `month()` to create a column with the month of your date. Call the new column `month`
- Use `zoo`'s function `year()` to create a column with the year of your date. Call the new column `year`

`@hint`
- Here is the hint for this setup problem. 
- It should get students 50% of the way to the correct answer.
- So don't provide the answer, but don't just reiterate the instructions.
- Typically one hint per instruction is a sensible amount.

`@pre_exercise_code`

```{r}
# Load datasets and packages here.
```


`@sample_code`

```{r}
# Your
# sample
# code
# should
# be
# ideally
# 10 lines or less,
# with a max
# of 16 lines.
```


`@solution`

```{r}
# Answer goes here
# Make sure to match the comments with your sample code
# to help students see the differences from solution
# to given.
```


`@sct`

```{r}
# Update this to something more informative.
success_msg("Some praise! Then reinforce a learning objective from the exercise.")
```


