# Questions and Answers to Linear Models.

## Model

5. Could you explain more about the relationship between dependent variable and explanatory variables? In my world they should be synonyms, but clearly there is a different.
   > From ThinkStat's glossary: 
   > **dependent variables**: The variables in a regression model we would like to predict. Also known as endogenous variables.
   > **explanatory variables**: The variables used to predict or explain the dependent variables. Also known as independent, or exogenous, variables.

## Optimization criterion
1. In Downey 10.1 the author writes that it is worth considering whether squared residuals are the right thing to minimize. What other parameters can be minimized to obtain the a good fit and which methods are used for this cause? Furthermore, in what kind of situations would it be beneficial to use a method other than a least squares fit?

1. Chapter 10.1 “For example, if you are using xs to predict values of ys, guessing too high might be better (or worse) than guessing too low.”. I do not understand what they mean in this sentence, do they talk about guessing xs? or do they mean guessing least squares fit?
    > Downey is just trying to say that there might be other considerations that one could incorporate in a model than minimizing , and that has been enabeled by the last 50 years improvements in computational efficency.


## *p* values
1. Is there a p-value associated with a statistical model we build so it can be used to reject the null hypothesis (the data does not fit to the statistical model) ?
   > I think chapter 10.6 in Downey gives a really thorough explanation how to do that. In brief, we are interested in either:
   > a) what is the probablity of obtaining a slope as extreme or more under Ho;
   > b) the probablity of obtaining a slope smaller/larger than 0 (for positive/negative correlation) under our sampling distribution. That would roughly translate to estimating how probable it is that our data actually comes from an uncorrelated dataset, but for a visualization with actual sampling distributions, you can check out fig. 10.4 in Downey.
   > However, the slope is not exactly our test statistic. It is R2 (coefficient of determination; the [formulas on wikipedia are quite useful](https://en.wikipedia.org/wiki/Coefficient_of_determination). That allows us to build an actual statistical model, as R2 is connected to how much the obtained fit to the data differs from what we would expect just based on variance in dependent variable. In other words, how much our model explains the data better than random model, which we are exactly interested in. Then, R2 is directly related to the Pearson correlation coefficient (R, r or ρ), as the R in R2 actually stand for the Pearson correlation coefficient. So R2 is indifferent to whether the correlation is positive or negative, and that way testing for R2 is equalivent to two-sided test for R, while if you were interested in one-sided test, you would just use R as the test statistic.

2. [Lecture video 1:59]
   Why do we use two types of statistical tests for the creation of linear models, if both of them use the same statistical methods and residual calculations (eI)? Does one have an advantage over the other calculation, as the video says both calculations are used to differentiate between diseased and healthy patients? What is the meaning of a discreet function? [video 5:01]
   > The two types of tests are used because they apply to different types of data. It is true that both of them use the same equation/calculations, but one applies to continuous data (x as a function of y, so for example age vs height) and results in a regression line with a slope (*y=ax+b*). The other applies to categorical data (so different categories like sick or healthy) and results in lines without slopes (*y=b* or *y=a+b*). This is also what discrete functions mean, individual values as opposed to continuous in a particular range. So we are basically using the techniques behind linear regression to formulate a t-test between categories. I hope I understood your question correctly! [Here's a nice video that explains this further!](https://www.youtube.com/watch?v=NF5_btOaCig&t=610s&ab_channel=StatQuestwithJoshStarmer)


## Interaction terms
A great resource for understanding these issues is the [wikipedia entry](https://en.wikipedia.org/wiki/Interaction_(statistics))

1. [Jupyter notebook KPNA2 gene analysis] 
In the Jupyter notebook example, an interaction term between grade and node removal is tested, and the model reports a p-value for it. Could you explain more about interaction terms? How is it included in the regression model? Why is it included in the regression instead of doing a separate test to examine if there is an interaction between the grade and node?

3. When modeling the p-value for an interaction between two variables as in the tumour size and grade and their effect on the expression on KPNA2 from the jupyter notebook. How are the effects of each variable convoluted from each other in the modeling? In the last cell of the notebook we see a very significant relationship between grade and expression and not so for size and expression. For the combination of grade and size we see a significant effect on the expression. My question is how do we know that the size is not just "piggybacking" in the very significant relationship between expression and grade so that the combination size:grade is still significant? 
  > When we subtract the effects of grade and size, as we do in the test, the tested remainder can not be a linear effect of "piggybacking".

4. If the span in the smoothed regression is very large or very small would the variance of the resulting best fit line be too low or too high, meaning that the data will be oversmoothed or shift too rapidly respectively and thus present errors in the regression, is it possible to check these errors via a q-q plot of the residuals versus a normal distribution with mean and variance?

6. Considering the online lecture (10:45), if we have three parameters correlating with each other in one way (positive or negative), but let's say, in reality, only A is interacting with B and C independently (there is no interaction between B and C but we see a similar correlation), how can the undirect correlation in this system be identified/eliminated? Could it be done using the available data? 

## Notebook
1. 11:0011 Nov at 11:00
[KPNA2 gene analysis] What is the "hue"-parameter?
> In the plotting package I use, [seaborn](https://seaborn.pydata.org/), the *hue* paramet sets the color scheme of the data points

### Other
7. Is there a statistic that can provide hints towards which kind of model could explain our data? Or we find this out empirically by trying out several models.

8. Chapter 10 Linear regression in Downey seem to imply that the residuals should be normally distributed but I was wondering about the variables, if they need to be normally distributed before being able to run a linear regression?

9.  Downey, Chapter 10.5 (Goodness of fit)
I do not completely understand how Std(res) and Std(ys) are calculated and why Std(res) would be a better estimate of the quality of the linear model in comparison to Std(ys).

1. In the video at 4.40, you mention dummy variables just briefly in the context of categorical data. If I understand this correctly, depending on how many categories you have, you need to have 2 or more dummy variables, (number of categories - 1). Is there a limit for how many dummy variables you can have? If so, could the sample size be a possible limitation? 
   > With any model of data, you should ensure that you have many more data points than parameters to fit. This is true here as well, were you need at least one parameter per variable you test. 

1. Video lecture, about min 4-6, If we find that the linear model applied minimizes the squared sum of residuals more than expected by chance, what does that tell us about the original data? 
   > If I understood correctly, this would mean that the original data has a good fit to the linear model that you applied and that the original data follows some form of linear distribution. If it did not minimise the squared sum of residuals more than expected by chance, that means that the model was not a good fit for the original data at all and would thus have more or less the same performance as a null model would. 
   > Because now we know that the R2 have a relationship with Pearson value. the R2 equal to the pearson2 . Regarding the p value of linear models, is there any similar relationship between the p value of Pearson and linear models?



1. Why are the residual distributed equally? I guess the higher the value, the higher the residue in natural. But in RMSE, it considers everything equally. So I think RMSE will focus on the higher value if the difference between values are big. Is it OK not to consider these things?

2. Simple Linear Regression. Reading the material that was suggested, I learnt that before doing some kind of calculations it is always a good idea to make a scatter plot. From the scatter plot we can see if the data roughly fits a line. Why do we need to do that before calculations?  
   > By using a scatter plot, we can visually examine our data. Making a scatter plot from your data is quite simple and allows us to assess the relationship between the variables before we do the calculations. I.e. you can make a prediction of what the regression line should look like. After the calculations are done, it is also easy to see if the line fits the data, as you say. For me, a visual analysis usually helps to understand the data and make predictions as well as identify any calculation errors. I hope I understood your question correctly! 

3. In the Think Stats 2e book, section 10.3 plotted residuals (Figure 10.2) and stated that it is a useful test, since if we get a flat line in the output, it then indicated that residuals are random. I don’t think I fully get the logic of this Figure 10.2 and would be happy to have a quick walk-through of how one should interpret it.    

4. Interaction terms in the KPNA2 gene analysis Notebook: When testing whether the gene expression depends on the tumor size, we first perform the test with size as the only variable, and then we also include the grade and node, before finally testing if there’s an interaction between size and grade.  
How do we know when to include interaction terms in the test? If there wouldn’t have been any significant interaction between size and grade, would we then have tested for an interaction between size and node? And if there would’ve been more variables than just grade and node in this example, would we then continue to test for an interaction between the size and all other variables as well, one at a time?
> The quite circular answer os that one include an independent variable when you are interested to test the relation from the variable on the outcome. 


1. They write that R^2 = p^2 and that because of this a one sided test of R^2 is equivalent to a two sided test of p, but I am not following the logic of this. Would we not rather multiply the value of a one sided test by 2 to get the two sided test-value assuming we have a normal distribution? 

2. In the online reading material, can you explain more about using the LinearRegression to handle multidimensional linear model? And by referring to multiple x values, does it mean multiple variables? Thank you.


1. In the book, section 10.6, the authors discuss how to estimate the p-value and present 2 ways of doing this. They conclude that computing the probability that the slope of the distribution falls below 0 is the best option and good enough even when the sampling size is small and residuals are skewed. In that case, is there any situation where we should use the other method (i.e. computing the probability that the slope under the null hypothesis exceeds the observed slope)?

2. Why when we only have one variable in the linear model to test it is equivalent to a t-test?
> Because this is what a t-test does.


1. Chapter 10.1 of the book says that the most common way to minimize the residual value is to use the sum of squared residuals. Why don't they use the absolute value of the residual instead, as one of the good reasons quoted is that "Squaring has the feature of treating positive and negative residuals the same, which is usually what we want"?