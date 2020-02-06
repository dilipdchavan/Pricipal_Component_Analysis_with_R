# Pricipal_Component_Analysis_with_R

## What is Principal Component Analysis ?
In simple words, PCA is a method of obtaining important variables (in form of components) from a large set of variables available in a data set. With fewer variables obtained while minimising the loss of information, visualization also becomes much more meaningful. PCA is more useful when dealing with 3 or higher dimensional data.

The transformation of a high dimensional data (3 dimension) to low dimensional data (2 dimension) using PCA. Not to forget, each resultant dimension is a linear combination of p features

A principal component is a normalized linear combination of the original predictors in a data set. For example PC1 and PC2 are the principal components

## Why is normalization of variables necessary in PCA ?
The principal components are supplied with normalized version of original predictors. This is because, the original predictors may have different scales. For example: Imagine a data set with variables’ measuring units as gallons, kilometers, light years etc. It is definite that the scale of variances in these variables will be large.

## Implementation of PCA in R 
PCA can be applied only on numerical data. Therefore, if the data has categorical variables they must be converted to numerical.

###We have almost 12 Variables
Item_Identifier,Item_Weight,Item_Fat_Content,Item_Visibility,Item_Type,Item_MRP,Outlet_Identifier,Outlet_Establishment_Year,Outlet_Size,Outlet_Location_Type,Outlet_Type,Item_Outlet_Sales
Now will have to remove dependent & categorical variables
Item_Identifier, Outlet_Identifier, Item_Outlet_Sales

### Now we have 9 variables
Item_Weight,Item_Fat_Content,Item_Visibility,Item_Type,Item_MRP,Outlet_Establishment_Year,Outlet_Size,Outlet_Location_Type,Outlet_Type
If will see data now agin 6 out of 9 variables are categorical.
By R library (dummies) will covert these variables into Numeric. 
We have data set of integer values. Now by R function prcomp() is used to perform PCA
By default, it centers the variable to have mean equals to zero. With parameter scale. = T, we normalize the variables to have standard deviation equals to 1. 
#outputs the mean of variables
prin_comp$center
#outputs the standard deviation of variables
prin_comp$scale

### Rortation Measure 
The rotation measure provides the principal component loading. Each column of rotation matrix contains the principal component loading vector. This is the most important measure we should be interested in.
> prin_comp$rotation
The prcomp() function also provides the facility to compute standard deviation of each principal component. sdev refers to the standard deviation of principal components.
#compute standard deviation of each principal component
std_dev <- prin_comp$sdev

We aim to find the components which explain the maximum variance
This shows that first principal component explains 10.3% variance. Second component explains 7.3% variance. Third component explains 6.2% variance and so on.

### Conclsion
A scree plot is used to access components or factors which explains the most of variability in the data.
The plot  shows that ~ 30 components explains around 98.4% variance in the data set. 
By plotting a cumulative variance plot,  will give us a clear picture of number of components.
This plot shows that 30 components results in variance close to ~ 98%. 
For modeling, we’ll use these 30 components as predictor variables and follow the normal procedures.
