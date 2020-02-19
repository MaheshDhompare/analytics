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