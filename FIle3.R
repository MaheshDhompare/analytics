#IIMLN
#Day1

mtcars
?mtcars #help on mtcars
class(mtcars)
x=1:5
class(x) #data type
x
?str
y=c(1,3.5,4.2) #c for specific values 
class(as.integer(y)) #changing class




#vectors----
#one data type
X=1:100
X
(x2=c(1,2,58)) #assign and print 
print(x2)

x2[3]

(x3=rnorm(n=10000, mean=60, sd=10)) #normal distribution values with mean and a sd
plot(x3)
plot(density(x3)) #to draw a graph

hist(x3) #histogram
hist(x3, breaks=10, col=1:10)
range(x3)
min(x3); max(x3)
mean(x3); median(x3)
boxplot(x3)
?boxplot
sort(x3)
sort(x3, decreasing=TRUE)
mean(x3[x3>80])

x3[1:10] #print first 10 values
x3[-c(1:10)] #print x3 excluding first 10 values
length(x3[x3>50]) #no of numbers greater than 50
sum(x3>80)
rev(x3)


#matrices----
#rows and column and only one data type like vector
(data=c(10,12,14,18,56,78,80,81))
(m1=matrix(data=data, nrow=2))
(m2=matrix(data=data, nrow=2, byrow=T))
rownames(m1)=c('R1','R2')
colnames(m1)=c('c1','c2','c3','c4') #naming columns and rows
m1
m1[1]
m1['R1',] #print row1
m1[,'c3'] #print column3
colSums(m1)
rowSums(m1) #sumn of rows
colMeans(m1)
apply(m1, 1, FUN=min) #1 means it operates in rows 2 means columns
apply(m1, 2, FUN=max)
apply(m1, FUN=max)
apply('c2', FUN=max)

#dataframe----

(rollno = paste('IIMLN', 1:13, sep='-'))
(age = round(runif(13, min=24, max=32),2))
(marks=trunc(rnorm(13, mean=60, sd=10)))
set.seed(1234)
(gender=sample(c('M', 'F'), size=13, replace=T, prob=c(.7,.3))) #replace is to replace male again to the sample after its assigned, and prob are men 
table(gender)  
(grade=sample(c('EX','Good','Sat'), size=13, replace=T, prob=c(0.5,0.3,0.2)))
table(grade)
prop.table(table(grade)) #proprtion
sapply(list(rollno, age, marks, gender, grade), length)
(students=data.frame(rollno, age, gender, grade))

write.csv(students,'data/students.csv',row.names=F) #exporting data in excel, row.names=f to delete row names

(df1 = read.csv('data/students.csv',row.names=F))
df2=read.csv('https://raw.githubusercontent.com/DUanalytics/rAnalytics/master/data/students.csv') #export data from github sirs file
df2

df3=read.csv(file.choose())
df3

students
#install.packages("deplyr")

library(dplyr) #loading library
class(students) 
summary(students)
str(students)
students$gender=factor(students$gender)
str(students)


#deployer
students %>% group_by(gender) %>% tally()

students
students


#Day2:21-Feb-2020----
library(dplyr)
mtcars
table(mtcars$cyl)
mtcars %>% group_by(cyl) %>% tally()
mtcars %>% group_by(cyl) %>% summerise(COUNT=n())
ftable(mtcars$cyl)

#gear and cyl
mtcars %>% group_by(gear,cyl) %>% tally()
table(mtcars$cyl, mtcars$gear, dnn=c('cylinder', 'gear'))

df=mtcars #asigning df as mtcars
head(df) #first 6 records
tail(df)
df$am= ifelse(df$am==0, 'Auto', 'Manual')
head(df)
df$mpg
df %>% group_by(mpg) %>% tally()
df=df %>% mutate(TXTYPE = ifelse(am==0, 'Auto', 'Manual'))
head(df)

#increase mileage by 10%
df$mpg * 1.1
head(df)
#add mpg+wt into new column MGPWT
df$mpg + df$wt
df$MPGWT=df$mpg*1.1 + df$wt
head(df)

#top 2 cars from mpg from each gear type : use group_by & top_n
?top_n
df
df %>% group_by(gear) %>% top_n(2, wt=mpg) %>% select(gear,mpg)

#lowest 2 cars from mpg from each gear type : use group_by & top_n
df %>% group_by(gear) %>% top_n(2, wt=-mpg) %>% select(gear,mpg)

#list out details of any 2 cars picked randomly: then do 25% of the cars
sample_n(df, 2, T)
sample_frac(df, 0.25, T) %>%  arrange(gear, desc(mpg))
df %>% sample_frac(0.25) %>%  arrange(gear, desc(mpg))


#find mean weight, mileage, and HP for different gears
df %>% group_by(gear) %>% summarise(avg=mean(mpg))
df %>% group_by(gear) %>% summarise_at(c('mpg', 'wt', 'hp', 'disp'), c(mean))
df %>% select(gear, mpg, wt, hp, disp) %>% group_by(gear) %>% summarise_all(mean)



#graphs----
hist((df$mpg), col=(1:5))
barplot(table(df$gear), col=(1:5))
pie(table(df$gear))
plot(df$wt, df$mpg)

L1=paste(round(table(df$gear)/nrow(df)*100), '%') #pie chart with % and color
pie(table(df$gear), labels=L1, col=1:4)


#install ggplot2 and reshape2
library(ggplot2)
library(reshape2)

(rollno = paste('IIM', 1:10, sep='_'))
(name = paste ('SName', 1:10, sep=''))
(gender = sample(c('M', 'F'), size=10, replace=T))
(program = sample(c('BBA','MBA'), size=10, replace = T))
(marketing = trunc(rnorm(10, mean=60, sd=10)))
(finance = trunc(rnorm(10, mean=55, sd=12)))
(Operations = trunc(rnorm(10, mean=70, sd=5)))
students <- data.frame(rollno, name, gender, program, marketing, finance, stringsAsFactors = F)
students
head(students)

(meltSum1 = melt(students, id.vars = c('rollno', 'name', 'gender', 'program'), variable.name = 'subject', value.name = 'marks'))
meltSum1
head(meltSum1)
meltSum1 %>% group_by(program, gender, subject) %>% summarise(MeanMarks = mean(marks))
sum2 = meltSum1 %>% group_by(program, gender, subject) %>% summarise(MeanMarks = mean(marks))
head(sum2)
#ggplot(data=sum2, aes(x=gender, y=MeansMarks,fill=gender)) + geom_bar(stat='identity') + facet_grid()
students
head(students, n=2)
students %>% group_by(gender) %>% summarise(COUNT = n())
ggplot(students %>% group_by(gender) %>% summarise(COUNT = n()), aes(x=gender, y=COUNT, fill=gender)) + geom_bar(stat='identity')
ggplot(students,aes(x=gender, y=..count..))+geom_bar(stat='count')

#stakedbar
ggplot(students %>% group_by(gender, program) %>% summarise(COUNT = n()), aes(x=gender, y=COUNT, fill=program)) + geom_bar(stat='identity') + geom_text(aes(label=COUNT))+labs(title = 'gender wise count')


#side by side
ggplot(students %>% group_by(gender, program) %>% summarise(COUNT = n()), aes(x=gender, y=COUNT, fill=program)) + geom_bar(stat='identity', position = position_dodge2(.7)) + geom_text(aes(label=COUNT))+labs(title = 'gender wise count')


#subject -program - gender - mean marks
names(students)
names(meltSum1)
head(meltSum1)
ggplot(meltSum1 %>% group_by(gender, program, subject) %>% summarise(meanMarks = round(mean(marks))), aes(x=gender, y=meanMarks, fill=program)) + geom_bar(stat='identity', position = position_dodge2(.7)) + labs(title = 'subject -program - gender - mean marks') + facet_grid(~subject) + geom_text(aes(label=meanMarks))

#Day3:23-Feb-2020----

#missingvalue
(x = c(1,2,4,5))
(x2=c(1,2,,4,,5))##error
(x2=c(1,2,NA,4,NA,5))
sum(x2) #this will not give sum
?sum
sum(x2, na.rm = T)
is.na(x2)
length(x2)
sum(is.na(x2)) #sum of missing value considering true as 1 and false as 0
sum(is.na(x2))/length(x2) #% 
x2[is.na(x2)]=mean(x2, na.rm=T)
x2


#VIM
library(VIM)
data(sleep)
sleep; ?sleep
head(sleep)
tail(sleep)
str(sleep) #structure of the data
dim(sleep)
summary(sleep) #gives summary of the table
x=200:300
quantile(x) #what does quantile do?

head(sleep)
is.na(sleep)
sum(is.na(sleep))
colSums(is.na(sleep)) #sum of missing value in every column
rowSums(is.na(sleep))
sum(complete.cases(sleep)) #sum of rows which does not have missing value
sleep[complete.cases(sleep),] #get only rows which does not have missing value
sleep[!complete.cases(sleep),] #get only rows which have missing value

#Ayush's query
xy=colSums(is.na(sleep))
xy
xy[xy>0]
c1 = names(xy[xy>0])
sleep[,c1]
c1 = names(xy)


#partioning
(x=1:100)
s1=sample(x, size=70)
length(s1)
sum(s1) #sum will be different every time as sample is different

(x=1:100)
set.seed(1354)
s1=sample(x, size=70)
length(s1)
sum(s1) #now the sum will be same

s2=sample(x, size = .7*length(x))
length(s2)
x

library(dplyr)
mtcars
mtcars %>% sample_n(24) #sampling
mtcars %>% sample_frac(.7)
dim(mtcars); nrow(mtcars)
(index = sample(1:nrow(mtcars), size = .7*nrow(mtcars))) #22 rows out of 32
mtcars[index,]
dim(mtcars[index,]) 
mtcars[-index,] #other 11 rows
dim(mtcars[-index,])


pinstall = c('rpart.plot', 'caTools', 'caret', 'arules', 'arulesViz', 'factoextra', 'dendextend', 'NbClust', 'cluster', 'fpc', 'amap', 'animation')
install.packages(pinstall)




pinstall <- c('gsheet', 'readxl', 'rJava', 'xlsx','wordcloud', 'wordcloud2', 'modeest','fdth','e1071' )
tspackages <- c('timeSeries','xts','zoo','forecast','TTR','quantmod', 'lubridate','smooth','Mcomp')
tmpackages <- c('twitteR', 'ROAuth', 'syuzhet')
lppackages <- c('timeSeries','twitteR','lpSolve', 'linprog', 'lpSolveAPI')

install.packages(lppackages)
if (!require("quantmod")) {
  install.packages("quantmod")
  library(quantmod)
}



#data partition important
library(caTools)
head(mtcars) #partioning data of mtcars column for 'am' column
sample=sample.split(Y=mtcars$am,SplitRatio = 0.7) #selecting 70% of the records randomly
sample
table(sample)
prop.table(table(sample))
y1= mtcars[sample==T,] #True Set, which are part of sample set
y2= mtcars[sample==F,] #False Set
table(y1$am) ; prop.table(table(y1$am)) #proportion of 0 and 1 in true set
table(y2$am) ;prop.table(table(y2$am)) #proportion of 0 and 1 in false set, proportion will be same


#another way of partioning
library(caret) 
(intrain = createDataPartition(y=mtcars$am, p=0.7, list=F)) #70% in train set
train = mtcars[intrain,]
test = mtcars[- intrain, ] 
prop.table(table(train$am)); prop.table(table(test$am)) #proprtion of 0 and 1 in train and test set



#linear Regresssion
head(women)
model=lm(weight~height, data = women)
summary(model)

#y = mx + c
#weight = 3.45 * height + -87.51

plot(x=women$height, y=women$weight)
abline(model) #line of best fit
residuals(model) #residual, difference betwn actual and predicted values
women$weight
predwt = predict(model, newdata=women, type = 'response') #prediction of Y value
head(women)
cbind(women, predwt, res=women$weight-predwt)

summary(model)
sqrt(sum(residuals(model)^2))  #SSE
#adjusted r-squared for more than one variable
#mutiple r-squared value for only one varible
range(women$height)
ndata = data.frame(height=66.5) #data frame
predict(model, newdata = ndata, type='response') #prediction fro 66.5 weight


#case2: LR----
#using google sheet
link = "https://docs.google.com/spreadsheets/d/1h7HU0X_Q4T5h5D1Q36qoK40Tplz94x_HZYHOJJC_edU/edit#gid=2023826519"
library(gsheet)
df=as.data.frame(gsheet2tbl(link))
head(df)
model2=lm(Y~X, data = df)
summary(model2)

#interpretation based on summary
#fstatistics p-value less than 5%, model exist
#we will use multiple r-squared value
#Sales=1.669*area + 0.9645

plot(x=df$X, y=df$Y)
abline(model2)

resid(model2)
ndata2 = data.frame(X=c(3,4))
predict(model2, newdata = ndata2, type = 'response')


#Multiple Linear Regression

link2 = "https://docs.google.com/spreadsheets/d/1h7HU0X_Q4T5h5D1Q36qoK40Tplz94x_HZYHOJJC_edU/edit#gid=1595306231"
library(gsheet)
df=as.data.frame(gsheet2tbl(link2))
head(df)
model3=lm(sqty~price+promotion, data = df)
summary(model3)
#adjuested r-squared interpretation: 74.21 variation in sales in is due to independant variables
#intercept value is 5837 and this value is for range of price and promotion values given in your data
#Linear regression if for intrapolation
plot(x=df$price, y=df$sqty)
abline(model3, col=2)

plot(x=df$promotion, y=df$sqty)
abline(model3)
range(df$price); range(df$promotion)
(ndata3=data.frame(price=c(60,75), promotion=c(300,500)))
predict(model3, newdata=ndata3, type='response')


#decision Tree
# Decision Tree - Classification
#we want predict for combination of input variables, is a person likely to survive or not

#import data from online site
path = 'https://raw.githubusercontent.com/DUanalytics/datasets/master/csv/titanic_train.csv'
titanic <- read.csv(path)
head(titanic)
names(titanic)
data = titanic[,c(2,3,5,6,7)]  #select few columns only
head(data)
dim(data)
#load libraries
library(rpart)
library(rpart.plot)
str(data)
#Decision Tree
names(data)
table(data$Survived)
prop.table(table(data$Survived))

str(data)
data$Pclass = factor(data$Pclass)
fit <- rpart(Survived ~ ., data = data, method = 'class')
fit
rpart.plot(fit, extra = 104, cex=.8,nn=T)  #plot
head(data)
printcp(fit) #select complexity parameter
prunetree2 = prune(fit, cp=.017544)
rpart.plot(prunetree2, cex=.8,nn=T, extra=104)
prunetree2
nrow(data)
table(data$Survived)
# predict for Female, pclass=3, siblings=2, what is the chance of survival

#Predict class category or probabilities
(testdata = sample_n(data,2))
predict(prunetree2, newdata=testdata, type='class')
predict(prunetree2, newdata=testdata, type='prob')
str(data)
testdata2 = data.frame(Pclass=factor(2), Sex=factor('male'), Age=15, SibSp=2)
testdata2
predict(prunetree2, newdata = testdata2, type='class')
predict(prunetree2, newdata = testdata2, type='prob')
#Use decision trees for predicting
#customer is likely to buy a product or not with probabilities
#customer is likely to default on payment or not with probabilities
#Student is likely to get selected, cricket team likely to win etc

#Imp steps
#select columns for prediction
#load libraries, create model y ~ x1 + x2 
#prune the tree with cp value
#plot the graph
#predict for new cases

#rpart, CART, classification model
#regression decision = predict numerical value eg sales


#CLustering
marks1=trunc(rnorm(n=30, mean=70,sd=8))
sum(marks1)
dfs=data.frame(marks1=marks1)
head(dfs)
km3 = kmeans(dfs, centers = 3)
attributes(km3)
km3$cluster
km3$centers
km3$size
sort(dfs$marks1)
cbind(dfs, km3$cluster)
dfs$cluster = km3$cluster
head(dfs)
dfs %>% arrange(cluster)
dist(dfs[1:5,])


#another example
set.seed(1234)
marks1=trunc(rnorm(n=30, mean=70,sd=8))
marks2=trunc(rnorm(n=30, mean=120,sd=10))

df6=data.frame(marks1, marks2)
head(df6)
km3B = kmeans(df6, centers = 3)
attributes(km3B)
km3B$cluster
km3B$centers
km3B$size

cbind(df6, km3B$cluster) #which row which cluster
df6$cluster = km3B$cluster
head(df6)
df6 %>% arrange(cluster)
df6[1:5,]
dist(df6[1:5,])
plot(df6$marks1, df6$marks2, col=df6$cluster)


#scaling (Incomplete code)
set.seed(1234)
marks1=trunc(rnorm(n=30, mean=70,sd=8))
marks2=trunc(rnorm(n=30, mean=120,sd=10))

df6=data.frame(marks1, marks2)
head(df6)
km3B = kmeans(df6, centers = 3)
attributes(km3B)
km3B$cluster
km3B$centers
km3B$size

cbind(df6, km3B$cluster) #which row which cluster
df6$cluster = km3B$cluster
head(df6)
df6 %>% arrange(cluster)
df6[1:5,]
dist(df6[1:5,])
plot(df6$marks1, df6$marks2, col=df6$cluster)


#Word colud
library(wordcloud2)
df=data.frame(word=c('mdi','iim','imt'), freq=c(20,23,15))
df
par(mar=c(0,0,0,0))
wordcloud2(df)
head(demoFreq) #demoFreq is a built in data set
dim(demoFreq)
par(mar=c(0,0,0,0))
wordcloud2(demoFreq)
