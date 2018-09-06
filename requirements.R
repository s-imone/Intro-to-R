library(remotes)

##### Install specific package versions from CRAN #####

install_version("ggplot2", "3.0.0")
install_version("data.table", "1.11.4")
install_version("zoo", "1.8-3")
install_version("rgdal", "1.3-3")

##### Install packages in development from GitHub #####

# install_github("nicholasehamilton/ggtern")

##### Install packages from Bioconductor

# source("https://bioconductor.org/biocLite.R")
# biocLite("GenomicRanges")

##### Include datasets in the image

data_dir <- "Intro-to-R/datasets/"
dir.create(data_dir)

#' @param x Amazon S3 URL of the dataset, as a string. 
# download_data <- function(x) {
#   download.file(
#     x,
#     file.path(data_dir, basename(x))
#   )
# }

# Usage is, e.g.,
# download_data(
#   "https://assets.datacamp.com/production/repositories/19/datasets/27a2a8587eff17add54f4ba288e770e235ea3325/coffee.csv"
# )
