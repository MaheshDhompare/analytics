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
                                                                                                                                                                                                                                                                                                        