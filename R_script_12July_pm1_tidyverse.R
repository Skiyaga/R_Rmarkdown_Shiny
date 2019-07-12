## The tidyverse environment

library(dplyr)
library(magrittr)
#install.packages("dplyr") # IF NOT INSTALLED

mydata = ChickWeight # just in case you start this
# from scratch

# preparing the dataset for work with dplyr:
mydata = tbl_df(mydata)
mydata

# to filter observations (i.e. extract rows):
filter(mydata, Time == 2)

# pipe operator
mydata$weight %>% length()

# filter() is to select rows, select() is to
# select columns
mydata %>% filter(Diet == 2) %>% select(weight)
# the above is the dataframe containing the
# weights of chicks under diet 2
mydata %>% filter(Diet == 2) %>% select(weight) %>% median()
# the above doesn't work: median() wants raw numerical
# values, not a data frame

mydata %>% filter(Diet == 2) %>% summarise(med = median(weight))

mydata %>% group_by(Diet) %>% summarise(med = median(weight))
mydata %>% group_by(Diet) %>% summarise(med = median(Time))
