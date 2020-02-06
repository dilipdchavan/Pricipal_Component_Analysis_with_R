rm(list=ls(all=TRUE))
setwd("C:\\DCHAVAN\\DSTI-Masters\\DilipPersonalStudy\\PCA\\DAta")

#load train and test file
train <- read.csv("train_Big.csv")
test <- read.csv("test_Big.csv")

#add a column
test$Item_Outlet_Sales <- 1

#combine the data set
combi <- rbind(train, test)

#impute missing values with median
combi$Item_Weight[is.na(combi$Item_Weight)] <- median(combi$Item_Weight, na.rm = TRUE)

#impute 0 with median
combi$Item_Visibility <- ifelse(combi$Item_Visibility == 0, median(combi$Item_Visibility), combi$Item_Visibility)

#find mode and impute
table(combi$Outlet_Size, combi$Outlet_Type)
levels(combi$Outlet_Size)[1] <- "Other"


colnames(combi)

#remove the dependent and identifier variables
my_data <- subset(combi, select = -c(Item_Outlet_Sales, Item_Identifier,Outlet_Identifier))

#check available variables
colnames(my_data)

#load library
library(dummies)

#create a dummy data frame
new_my_data <- dummy.data.frame(my_data, names = c("Item_Fat_Content","Item_Type","Outlet_Establishment_Year","Outlet_Size","Outlet_Location_Type","Outlet_Type"))

#check the data set
str(new_my_data)

#divide the new data
pca.train <- new_my_data[1:nrow(train),]
pca.test <- new_my_data[-(1:nrow(train)),]


#principal component analysis --- 
# R function : prcomp() for PCA ...by default it will Centers the variable to have Mean = 0. 
# With Parameter scale.= T, We narmalize the variables to have SD = 1
prin_comp <- prcomp(pca.train, scale. = T)
names(prin_comp)

##enter and scale refers to respective mean and standard deviation of the variables that 
#are used for normalization prior to implementing PCA

#outputs the mean of variables
prin_comp$center

#outputs the standard deviation of variables
prin_comp$scale

# The rotation measure provides the principal component loading.
# Each column of rotation matrix contains the principal component loading vector. 
# This is the most important measure we should be interested in.

prin_comp$rotation

prin_comp$rotation[1:5,1:4]

dim(prin_comp$x)

biplot(prin_comp, scale = 0)

#compute standard deviation of each principal component
std_dev <- prin_comp$sdev
std_dev[1:10]

#compute variance
pr_var <- std_dev^2

#check variance of first 10 components
pr_var[1:10]

# We aim to find the components which explain the maximum variance
# higher is the explained variance, higher will be the information contained in those components.

#To compute the proportion of variance explained by each component, 
#we simply divide the variance by sum of total variance

#proportion of variance explained

prop_varex <- pr_var/sum(pr_var)
prop_varex[1:20]

#A scree plot is used to access components or factors which explains the most of variability in the data. 
#It represents values in descending order

#scree plot
plot(prop_varex, xlab = "Principal Component", ylab = "Proportion of Variance Explained", type = "b")

#The plot above shows that ~ 30 components explains around 98.4% variance in the data set.

#using PCA we have reduced 44 predictors to 30 without compromising on explained variance
# confirmation check, by plotting a cumulative variance plot
#cumulative scree plot

plot(cumsum(prop_varex), xlab = "Principal Component", ylab = "Cumulative Proportion of Variance Explained", type = "b")

#This plot shows that 30 components results in variance close to ~ 98% . 
#For modeling, we’ll use these 30 components as predictor variables and follow the normal procedures.
#Thank you.
