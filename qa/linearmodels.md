1. In the jupyter notebook, the KNAP2 expression is tested for significant dependence on grade, tumor size and the intercation between size and grade. This resulted in a very small p value for grade (1.8E-8) and a quite large p value for size (0.45). The interaction between size and grade gave a significant *p* value (0.016). It then says that "The test suggest that KNAP2 expression depends on an interaction between tumor size and grade". My question is if the significant result obtained for the interaction could be due to the very small p value for grade, thereby kind of "masking" the large p value for size? So I am wondering if we really can be sure that the interaction is significant in itself, and not solely significant in the tumor grade?
 > No, this should not, at least not theoretically be the case. The model should regress away the larger effect of the tumor grade, rendering the further tests data where the linear effect of the tumor grade is absent.

1. The book chapter says that the t-statistic for a certain variable is the same as the F-statistic where only that variable is omitted, does this mean that they give the same p-value?
 > Yes.  

1. The book chapter says that the t-statistic for a certain variable is the same as the F-statistic where only that variable is omitted. Is this what is done in the ANOVA tests used in the jupyter notebook example, since it reports one F-value for each term rather than one F-value for all predictors?
  > No, for most tests in the notebook more than one variable is tested. [*t*-tests](https://en.wikipedia.org/wiki/Student%27s_t-test) can only be performed in case-control situations, or when a single sample is to be compared to a given value.

1. Also, in the book on the pages 78-79 about the three variable selection methods, which tests are used to generate the p-values in the different steps of the different methods?
 > They mean rthat you should use an ANOVA model. I am a bit sceptic to these types of methods. You should instead just test the relations that you prior to the experiment think make sense.

1. Could you clarify this code "x = 10 * rng.rand(50)" in  "In Depth: Linear Regression"? rand(50) is a random 50-50 matrix, isn't it? But I cannot get what the meaning of number 10 before the function "rand()" is.
  > I think that if you use x = rng.rand(50) you will get 50 random numbers in the range 0<x<1, while if you multiply this by 10, you will get them in the range 0<x<10.  
  > Yes this is a correct explanation. I get the following results:
  > ```python
  import numpy.random as rng
  rng.rand(5)
  ```  
  > array([5.71024323e-01, 5.82879495e-01, 2.57541449e-01, 2.28721560e-01, 5.37681066e-04])  
  > ```python
  10*rng.rand(5)
  ```  
  > array([2.2329335 , 9.55115181, 5.90653729, 6.60637405, 5.64723141])

1. In the video lecture, approximately at 11:50, you say that there is an inverse relationship between the node and the grade. How do you see this in the boxplots? How can you determine that there is an inverse relationship between these?
  >  The difference in KNAP2 expression between node=1 and node=0 is positive for grade=1 tumors, but negative for grade=3 tumors. Hence there is a tempting interaction between these variables. We subsequently test if this interaction is significant.  

1. Since the mean of several the least squares lines seems to be in better correspondence to the population regression line, is it recommended to do several least square lines and use the mean, if so should you use new data for each least square line?

1. In your video you mention that the plots aren't based on enough data points, what number of data points (roughly) is necessary to be able to achieve reliable results? For example, the p-values in the video were quite low even though, as mentioned, the number of data points wasn't very high.

1. In the video it seems to me that the effect of node upon gene expression is dependent on the grade of the cancer. Can you use multiple linear regression to study the effect of multiple parameters (such as grade/node/size) on a single feature (gene expression) while including the fact that the parameters can affect and be dependent on one another? Can that be done by representing each parameter as a separate "line equation" and looking at the sum of them?

1. When we speak about linear regression, is it similar to linear equations in sense that a population Y is related to a population X with some terms like intercept and slope when the graph between the variables of each population? Also does finding the beta and beta0 establish a relationship between the two populations? i.e Y is dependent on X linearly.?

1. Linear regression is a type of analysis that tries to model the relationship between two (or more  in multiple linear regression) features by using a linear equation and fitting it to you data. Beta0 and Beta1 would in this model indeed represent the intercept and the slope.

Finding these terms means fitting your data to to a linear equation, and it would result in you having estimates of Beta0 and Beta1, but I think it does not necessarily mean there is a relationship between X and Y.

You can however assess the accuracy of these coefficients by calculating the standard error for each of them (e.g. SE(Beta1)). You can also determine the p-value for the null hypothesis "There is no relationship between X and Y", which can be used to infer that there is a relationship or not, depending on the size of the p-value. Hope this is a satisfactory explanation :)

1. 1. A residual is the difference between the created regression line at the point (x) and the actual data point. It makes sense that we want to minimise the residuals of all data point to have the best regression curve. Why do we use the sum of the squared sum instead of the sum?



2. How can multidimensional linear models be best visualised using Jupiter?



1. How can one see “KNAP2 expression depends on an interaction between tumor size and grade” in the Jupyter notebook “KNAP2 gene analysis”? Which value in the table is the criterion?

1. In order to perform hypothesis testing on the coefficients we use the t statistics where a certain measure of t is being calculated. How is the value of t is correlated with the p value and how is the p-value calculated in this case?

1. From the text in the textbook I understood that the t-statistics gives a series of values that forms the t-distribution. Based on this t-distribution (it becomes normal distribution under certain conditions), this can then be used to get p-values in a conventional manner.

1. In the KNAP2 gene analysis: in the generated table we have df, sum of squares, mean sum of squares, F value, and p value. What is df and how is it important?

1. You mentioned in the video that the model can't be trusted if to few data points are used to create it. Will the number of data points affect any of the parameters (such as RSE, F, R^2) that are used to evaluate the models accuracy? And how do you choose the amount of data needed to create a trustworthy model?

1. The ANOVA test can be used in order to check whether the means of two or more groups are significantly different from each other. For what reason is the T-test still in use, even though it is limited to only compare two samples at the same time?

1. From the textbook, the key concepts seem to be:

1. Definition of simple linear regression

2. Definition of multiple linear regression

3. How to estimate the uncertainty in the parameters (β0 and β1)



Is there any additional key concept that we should understand?



1. The linear model assumes that the residues follow a normal distribution. If the residues calculated from a data set don't follow a normal distribution, does it have any impact in the linear model constructed? Does this impact (if there is any) depend also on the sample size (i.e. the residues of a small sample may not show a normal distribution just because there are few data points to calculate the residues from, but if we had a bigger sample the normality condition would be fulfilled).



1. On performing t-statistics, the textbook states that if there is no relationship between X and Y then we get expect a t-distribution with n-2 degrees of freedom.

What does degrees of freedom mean in this context? And how is it n-2 and not anything else? How is this derived?

Does the t-distribution change in the two case where LaTeX: \beta
β
1 = 0 and not equal to 0 change, if yes then how?

1. In the textbook it is mentioned that if a predictor seems to be correlated with the observed variable Y in a simple linear regression it doesn´t mean that taking account other predictors in a multiple linnear regression it will still be significant. They demonstrate it with the example that alttough the advertising in the newspaper was correlated with the sales in the simple linnear regression in the model that all the different media were used it was not. In the same context in the Jupyter notebook the size was not correlated with the gene expression, but the size in comparison with the grade was. Where is the line that allows us to draw conclusions focusing only in a few predictors especially in the really complex biological systems? Is there a way to correct for that? Does this mean that the size is correlated with the grade and the grade with the expression but the size with the expression no? How many predictors should we check in the case of the differential expression analysis and how confident can we be with the results???

1. When does one decide to not use linear regression on a data set? Is there a proper way to determine this?

1. On page 64 in the text book, they talk about many lines representing least square correction. Is it that the least squares are calculated for the same points taken randomly, few points at a time or different observations of the dependent variable for each point on the independent variable taken randomly?

1. In the linear regression model of KNAP2 and tumor size, there is a shadow around the line. Do they mean other possible linear models? How could we narrow down the shadow to get a more precise result?

1. The hierarchical principle described in the textbook (p. 89) states that if an interaction term between two variables is included in a linear regression model, the main effects of these variables (i.e. terms modelling the effect of the individual variables) should also be included, regardless of whether these effects have been determined to not be statistically significant. However, I have a hard time understanding the explanation for this. Is it not possible for an independent variable to affect a dependent variable only through its interaction with another independent variable? Will the accuracy of the model in that case not be decreased if we include an individual term for this variable?

1. Is there an easy explaination for what the F value stands for, when you do the Anova test?

In SVM there is the problem of overfitting, does this also apply to linear modeling ?

During the fitting process, will only the parameters(Beta) changed, or also the error(e)?

1. In the textbook, if I understand right, it said that we can use p-value to estimate whether reject t-statistic model or not because “The t distribution has a bell shape and for values of n greater than approximately 30 it is quite similar to the normal distribution”. So if n less than 30, can we still use p-value to estimate t-statistic, or what other else method can be used? And what the relationship between p-value and t-statistic?

1. I understood the t-test , but didn't understand how, when there is no relation between X and Y , we will have a t-distribution with N-2 degrees of freedom. Can you explain what this means ?

1. Page 64. “Y= 2+ 3X + epsilon”

Why is epsilon added to the linear regression model? How is the size of epsilon determined?

1. How could we evaluate the quality of the linear model? (a variety of  Linear models with different number of variables included, e.g.  size or  size and grade). Can we know if the variations of the data have been mostly explained by looking at the parameters of residuals?
