# Questions and Answers to Linear Models.


### Types of variables

* In section 11.2 of the book, they mention categorial variables. Are categorial variables the same as discreet variables?
> No, the are different. For categorical variables, they contain a limited number of categories or distinguishable groups. Categorical data may not be in logical order. For example, gender, material type, and payment method. For discrete variable, it is a numeric variable that has a countable value between any two values. Discrete variables are always numeric. For example, the number of customer complaints.

### Outliers

* From what I understand, linear regression is quite sensitive to outliers in the data. Is there a way to identify ''true outliers'' and take that into account by creating a linear regression to make it more accurate? Or does this increase the chance to find a correlation between variables that may not be there?
> There are some statistical test designed to identify outliers, however, none of them are very clear in how they should be interpreted.

### Measures of model fits and model selection

* What is the difference between RMSE and R^2 and when do we want to use each approach?
> RMSE is the square root of the average of the squared difference between the original and predicted values. R^2 is the proportion of the variance in the dependent variable that is explained by the linear model. They are both measures of how well a linear regression model fits a dataset, but RMSE is an absolute measure of how accurate the model can predict the value of a response variable, while R^2 is a relative measure of how well the variation in the response variables can be explained by the predictor variables. For comparing the accuracy of different linear models, RMSE is better; for an intuitive representation of a model's goodness of fit, R^2 is better.

* When and how do you know you should use a linear model rather than any other type of model? Is there any logical/mathematical tool to assist the decision in the choice of a model category?
> This is an interesting problem. The more parameters a model use the better it will fit a set. Often tests such as [Bayesian Information Criterion](https://en.wikipedia.org/wiki/Bayesian_information_criterion) and [Akaike information criterion](https://en.wikipedia.org/wiki/Akaike_information_criterion) are used to investigate the which of several models are better fits, not just because they use more parameters.

* Why is the standard deviation of the residuals is a better representation of the quality than R^2 or Pearson's coefficient of correlation? (Chapter 10.5) 
> The RMSE is not a better representation, but it shows more clearly how well the model can predict dependent variables based on independent variables. While the R^2, show how much the variation between the datapoints can be explained by the model. The higher the R^2 value the more the variations depend on the variations of the independent variable (i.e.: We have a strong correlation). But R^2 does not say anything about the the error of the predicted values.

* In 10.5 it is mentioned that R2 is often used to quantify the strength of a relationship and that it is a good indicator of reduction in MSE, but the reduction in RMSE is a better indicator of predictive power. What are the reasons for this?
> RMSE will tell how well the value of a responsible variable can be predicted in absolute terms by a regression model. R2 will instead tell how well the predictor variables are able to explain the variation in the response variable. Both methods will tell how well a regression model fits a data set, but from different perspectives. I understand it as this will make a difference in their predictive power. 

* In 10.5 the author states that there are several ways to measure the quality of a linear model for example, by the standard deviation of residuals and the coefficient of determination. How do you choose which method to use?
> I understood that the standard deviation of residuals is more suited to assess the predictive power as well, especially when compared to the standard deviation of the dependent variables. 

* In the video regarding categorical variables it was stated that dummy variables can be used instead for example disease and healthy marked with 0 and 1. How would one know how many dummy variables a linear regression model could handle before compromsing the model itself?
> We can use as many categorical variables as we want. However, you might run into less power in the model if these extra parameters are not informative.
### Optimization criterion

1. What would be the benefit of simply taking the absolute value or cubing the residuals (as mentioned in 10.1 Least squares fit) rather than squaring them? In the text, squared residuals is motivated as "treating positive and negative residuals the same" and "gives more weight to large residuals, but not so much weight that the largest residual always dominates", which I would assume trumps the absolute value; however, I do not understand how larger residuals would ever be subordinate to smaller ones (and I assume this also refers to the cubing).
> The aim of linear regression is to find if there is relationship between the dependent and explanatory variables (or "how much" they relate). When you simply take the absolute value of residuals/cubing the residuals, yes, it also measures the positive and negative residuals the same. Squaring or cubing can "enlarge" the residues to "enlarge" our observation. However, when your data have an overrepresented observation (dot), cubing also overamplifies this residue, which may make your result ugly. I would say cubing "gives more weight to large residuals, but too much weight to dominant largest residuals".   

* In 10.1 it is stated that " [..] if you are using xs to predict values of ys, guessing too high might be better (or worse) than guessing too low. In that case you might want to compute some cost function for each residual, and minimize total cost, sum(cost(res))." I cannot fully understand what is exactly meant by that. 
> The sentence is not chrystal clear. The say that in an experiment where a too high estimation of y is associated with something bad, e.g. an undesired financial cost, we can design the `cost(...)` function in such a way that it favours underestimations of y, eg lower penalties for positive than negative residues.


### Optimization

* I also have another question regarding chapter 10.1 where it is stated that the most common method is to minimize the sum of squared residuals. Are there other approaches used that are better? Perhaps they need more computational power?
   > There is a method called Gradient Descent, where the solution for the linear system Ax - b = 0 is found by finding the global minima for the system. This has a lower computational cost, but can it needs many iterations to find the minima, or it can even "get stuck" in a local minima instead of a global. As far as I have understood, this method is based more on an optimization approach, where the Least-Square Method is based on finding the least possible residual value. 

* In section 10.4 of the book they run simulated experiments to compute sampling distribution of the estimates to assess sampling errors. As we discussed before, another way of assessing bias in your samples is performing permutation testing to see if your current distribution is representable for your whole sample. Is one technique preferred over the other, or are they used for different applications?
   > Permutation testing is often seen as a method makes a minimal set assumptions of the data. However, both methods make sense.

### ANOVA

* As I interpret the notebook, the p-values are in the column Pr(>F). What does the F statistic mean in this case and how does it relate to p-values?
   > In an ANOVA the ratio between the explained and the unexplained variance (the sum of the residuals) follows a F-distribution. The higher the F-value, the lover the resulting p-value.


### Model notation
* A question regarding the Jupyter notebook and the youtube lecture.How do the models created  look? Is there any way to visualise and inspect the models created with the ols statsmodel package and how the datapoints relate to it? Especially for this formula: formula='log_gene ~ C(grade) + C(node) + C(grade):C(node)'
> Here is a description: https://patsy.readthedocs.io/en/latest/formulas.html  
> For most terms you just multiply them with a linear weight, the "C(grade):C(node)" translates to a new variable, which will get a 1 or 0 value based on C(grade) AND C(node), also weighted by one single variable.

* In the notebook associated with the reading, in the very last box, it says that the model presents three different p-values. Are there any hierarchal ranking between these or is it just a "fact" that the model produces it?
> The p-values are calculated for each of the three explanatory variables (1) cancer grade, (2) size, and (3) the interaction term between cancer grade and size. The order of reported p-values then probably depends on the order of the variables in the formula:    
> formula = 'log_gene ~ C(grade) + size + size:C(grade)'  ==> p value(C(grade)), p value(size), p value(size:C(grade))    
> formula =    'log_gene ~  size + C(grade) + size:C(grade)'     
> you will get ==>  p value(size), p value(C(grade)), p value(size:C(grade))
> Each of these p-values have a different meaning, and note that they are not multiple hypothesis tested (if you use more than one of them).


### Other types of regression

* In the text by VanderPlas, it says that the results of Ridge regularisation and Lasso regularisation can differ a surprising amount. From the graphs it seems to me like indeed the basic function graph appear very different for the two, but the fitted line seems to match the data in a very similar way. Could it also appear that the fitted line that the two regularisation models return differs a lot? And if so, how can one best decide which type of regularisation is the best choice for a specific case?
> No, not that I know of. However, note that ridge and lasso regression are not part of the course material. 


## Causality
* You said in the video that nothing could be said about the causality between the tumor and removing the lymph node. Is there a way determine if there is causality or not?
> Not from the data itself. You would need to design a new study, e.g. a [randomized control trial](https://en.wikipedia.org/wiki/Randomized_controlled_trial) to get a hint of causality. 

## Error models
* In the notebook the following statement was made: "It is common to assume a log normal distribution of transcription values". How come this is the case?
> As measurement errors for concentration often are roughly proportional to the magnitude of the measurements, a log transformation makes them equally large for low and high abundant analytes.



