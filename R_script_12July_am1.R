5
ghfgfds # undefined variable
5 + 2.5 * 10

### 3 DATATYPES IN R ###

typeof(5) # my first function call
# "double" aka "numeric" is the datatype for numerical values
is.numeric(5)
is.double(5)
typeof("double")
typeof("Olu")
# second datatype: character type, for all strings.
'Olu'
TRUE # what is this?
true # Beware, R is case-sensitive
T # a shorthand form for TRUE
F # FALSE
typeof(TRUE)
is.logical(TRUE)
# third datatype: logical, for boolean values
3 == 4 # comparison operator testing for equality

### CREATING AND ALTERING VARIABLES ###
a = 4 # assign the value 4 to the variable a
# same-same assignment operator:
a <- 5 # NO SPACE between '<' and '-'
"Olu" -> a
# variables are not strongly typed: the type of
# their content may change over the course of
# the program
typeof(a)
5 <- 23 # error

### CONVERSION FUNCTIONS ###
# conversion functions (a.k.a casting functions)
# start with "as."
as.numeric('345')
as.numeric('3.5e3')
as.numeric('3.5e-6')
as.numeric('3.5e-3')

as.numeric(FALSE)
as.numeric(TRUE)

as.character(3.4)

as.logical(34) # anything not zero is converted into TRUE
as.logical(0) # FALSE

### EVERYTHING IS A VECTOR ###

# vectors are the most basic data containers in R
is.vector(5)
is.vector("Olu")
# a vector is a (linear) collection of
# objects OF SAME TYPE.

c(2,TRUE,"Olu") # automatic (silent) conversion
# into the "most permissive" type
c(2, TRUE, 3e-6)

length(a) # the length function returns the
# number of elements in a vector

# We build vectors using the c() operator
c ("Olu",'JB') -> string_vector
length(string_vector)

# beware! The length of a string is given by nchar()
nchar("Olu")

# every operator is naturally vector-aware:
nchar(string_vector)

c(1,2,3) + c(4,5,6)

# to build large regular series (sequences): seq
seq(1,100)
seq(8,800,5) -> myseq

myseq[124] # syntax to extract an element
# from a vector: SQUARE brackets

# we can extract several elements at once:
myseq[124, 73] # WRONG: we don't have two dimensions
# in a vector
myseq[c(124, 73)] # correctly extracts two elements


### FUNCTION CALLS AND NAMED ARGUMENTS ###
seq(8,800)
# what is the expected meaning attached
# to the various arguments in my call?

?seq # or help(seq)
seq() # using default arguments
# above is actually the call:
seq(1,1)
seq(from = 1, to = 1)
# one can always NAME the arguments used,
# provided that one uses the exact formal variable
# names (stipulated by the function definition)

seq(from = 8, to = 600, by = 10)
seq(from = 8, to = 600, steps = 10) # wrong argument name

seq(7, from = 0, to = 1)
# here, 7 is assigned to the first
# unmatched argument in the definition
# of seq, i.e. "by"

seq(from = 0, to = 1, length.out = 7)

# when using named arguments, their
# order doesn't matter:
seq(to = 1, length.out = 7, from = 0)

### MOVING ON TO TWO-DIM OBJECTS

# We are going to use the ChickWeight
# built-in dataset
ChickWeight -> mydata
is.vector(mydata)
is.data.frame(mydata) # yes
dim(mydata) # num of rows and num of columns
nrow(mydata)
ncol(mydata)
names(mydata) # column names
head(mydata) # to display the first rows
tail(mydata)
# column and row names are part of the display

# we can extract a column using the "$" sign
mydata$Time # dumps the content of the column
# as a vector

# a data frame is actually a LIST of column
# vectors
is.list(mydata)
mydata[[1]] # extracts the first column as a vector
mydata[1] # the result here is still a list
# (with one slot)

###### VIP function: str() to examine the
###### structure of ANY object
str(mydata)
?ChickWeight
unique(mydata$Chick) # BEWARE OF USING unique()
# on factors!!

levels(mydata$Chick)

View(mydata) # to view the dataset in a separate tab

# EXERCISE 1
# extract observations (a sample of the data frame)
# corresponding to Chick 31

mydata[31] # trying to select COLUMN 31 in the df
mydata$Chick[31] # extracts 31st element of the column "Chick"
# which means the 31st element of the vector mydata$Chick 

# correct is to do:
mydata[ mydata$Chick=="31" ,  ] # before the comma: selecting rows
# after the comma: selecting columns

# explanation:
# mydata$Chick=="31" builds a LOGICAL VECTOR that we use
# as a positive (selection) filter to filter rows


mydata[ mydata$Chick==31 ,  ] # before the comma: selecting rows
# after the comma: selecting columns

# Beware: above, "mydata$" is necessary:
mydata[ Chick==31 ,  ] # ERROR: object Chick is not found


# other way: using subset()
subset(mydata, Chick == "31") # first argument is the
# dataset, second argument in the logical selection formula
# there is no need to use "$" within that selection formula.
subset(mydata, Chick == 31) # same

# EXERCISE 2
# extract observations (a sample of the data frame)
# corresponding to chicks above 20 days of age
mydata[mydata$Time >= 20,]
subset(x = mydata, subset = Time >= 20)

# EXERCISE 3: calculate the mean of all weights in this
# experiment
mean(mydata$weight)


# EXERCISE 4: calculate the median of the weigths for each
# diet (four median values)
str(mydata$Diet) # a factor
levels(mydata$Diet) # the levels of a factor are its different
# categories (a factor encodes a categorical / qualitative)
# variable

subset(mydata, Diet == "1")$weight
subset(mydata, Diet == "1")$weight
# the above outputs a vector of numerical values

subset(x = mydata, subset = Diet == "1", select = "weight")
# the above outputs a df with only one column

median(subset(mydata, Diet == "1")$weight)
median(subset(mydata, Diet == "2")$weight)
median(subset(mydata, Diet == "3")$weight)
median(subset(mydata, Diet == "4")$weight)
# same solution with a for loop:
for (i in seq(1,4))
  print(median(subset(mydata, Diet == i)$weight))

# we can also compute the inter-quartile range:
for (i in seq(1,4))
  print(IQR(subset(mydata, Diet == i)$weight))

# summary() is a good tool to represent distributions
summary()
#### SIMPLE PLOTS ######
hist(mydata$weight)
par(bg='blue')
boxplot(mydata$weight)
# one can also have one boxplot per
# category of a categorical variable
# a.k.a a factor in R
boxplot(weight ~ Diet, data = mydata)
# the above reads:
# plot the boxplot of weights grouped
# by values of Diet.

# abline() to draw lines on top of the
# current plot
abline(h = 131.25) # median of 3rd group
abline(h = median(subset(mydata, Diet == "2")$weight), col='lightgrey', lwd = 5) # median of group 2

abline(h = median(subset(mydata, Diet == "2")$weight), col='red', lwd = 2) # median of group 2

par(bg="white")

#### tabular forms ####

# summary of a quantitative var:
summary(mydata$weight)

# summary of a qualitative var (counts):
summary(mydata$Diet)

# for categorical variables, use
# table to build a contingency
# table:
table(mydata$Diet, mydata$Chick)

# one can create data frames:
medians = data.frame(diet=seq(1,4), median_weight = 0)

for (i in seq(1,4))
  medians[i,"median_weight"] = median(subset(mydata, Diet == i)$weight)

# to save this table into a file:
write.csv(x= medians, file ="table_for_Peter.csv",row.names = FALSE)
