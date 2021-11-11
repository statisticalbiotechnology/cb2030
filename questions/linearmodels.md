# Questions and Answers to Linear Models.

## Model

5. Could you explain more about the relationship between dependent variable and explanatory variables? In my world they should be synonyms, but clearly there is a different.
   > From ThinkStat's glossary: 
   > **dependent variables**: The variables in a regression model we would like to predict. Also known as endogenous variables.
   > **explanatory variables**: The variables used to predict or explain the dependent variables. Also known as independent, or exogenous, variables.

1. Why are the residual distributed equally? I guess the higher the value, the higher the residue in natural. But in RMSE, it considers everything equally. So I think RMSE will focus on the higher value if the difference between values are big. Is it OK not to consider these things?

1. In the video at 4.40, you mention dummy variables just briefly in the context of categorical data. If I understand this correctly, depending on how many categories you have, you need to have 2 or more dummy variables, (number of categories - 1). Is there a limit for how many dummy variables you can have? If so, could the sample size be a possible limitation? 
   > With any model of data, you should ensure that you have many more data points than parameters to fit. This is true here as well, were you need at least one parameter per variable you test. 


## Residues

8. Chapter 10 Linear regression in Downey seem to imply that the residuals should be normally distributed but I was wondering about the variables, if they need to be normally distributed before being able to run a linear regression?

1. Chapter 10.1 of the book says that the most common way to minimize the residual value is to use the sum of squared residuals. Why don't they use the absolute value of the residual instead, as one of the good reasons quoted is that "Squaring has the feature of treating positive and negative residuals the same, which is usually what we want"?

3. In Downey, section 10.3 plotted residuals (Figure 10.2) and stated that it is a useful test, since if we get a flat line in the output, it then indicated that residuals are random. I don’t think I fully get the logic of this Figure 10.2 and would be happy to have a quick walk-through of how one should interpret it.    

9.  Downey, Chapter 10.5 (Goodness of fit)  
   I do not completely understand how Std(res) and Std(ys) are calculated and why Std(res) would be a better estimate of the quality of the linear model in comparison to Std(ys).
   > A1: Std(res) and Std(ys) come from the residual calculations done before hand.
   ```
   def Residuals(xs, ys, inter, slope):
      xs = np.asarray(xs)
      ys = np.asarray(ys)
      res = ys - (inter + slope * xs)
      return res
   ```
   > I believe Std(res) does take into account the whole picture while Std(ys) only focuses on one variable.
   > Std(res) is the root mean squared error of the predictions done for ys - (inter + slope * xs), which includes the xs as well and not only the ys variable.
   > A2: I think std(.) are calculated according to the formula for standard deviation.
   > So I don't think one can say that Std(res) and Std(ys) are estimates of the quality of the linear model and one is better than the other. It's rather that Std(res) in comparison to Std(ys) tells you if the prediction from the linear model is better than the prediction we would have made without the additional information we built the linear model from. 
   > Using the example with birth weights and age:  
   > If we only had the values of the birth weights our best guess would be the mean of the birth weights. So our estimate of the birth weight for a 25 year old would be the same as our estimate for a 30 year old and all other ages. So Std(ys) tells us how far our estimate would be off, on average, if we only had the birth weights for our prediction. 
   > The Std(res), on the other hand, is a measure of how far our estimate (yi(estimated by the regression equation)) would be off, on average, if we used the additional information age for the prediction (if we used the regression equation and not only the mean to estimate birth weight).  
   > So Std(ys) is not an estimate of the quality of the linear model. But by comparing Std(ys) and and Std(res) we can evaluate the quality of the linear model.
   > If Std(res)=Std(ys), knowing mothers age does not improve the prediction, because the error we would make would be as large, on average, as if we only used the mean for our prediction.  
   > if Std(res)<Std(ys), knowing mothers age does improve the prediction, because the error we would make would be smaller, on average, as if we only used the mean for our prediction.  
   > A3: Std(ys) is the standard deviation of your dependent variable y, and Std(res) is the standard deviation of the residuals of the model, i.e. what is left after we regressed away our linear model. The more the linear model explains about the data, the larger is the difference between the two measures. 

1. Video lecture, about min 4-6, If we find that the linear model applied minimizes the squared sum of residuals more than expected by chance, what does that tell us about the original data? 
   > This would mean that the original data has a good fit to the linear model that you applied and that the original data follows some form of linear distribution. If it did not minimise the squared sum of residuals more than expected by chance, that means that the model was not a good fit for the original data at all and would thus have more or less the same performance as a null model would. 
   > Because now we know that the R2 have a relationship with Pearson value. the R2 equal to the pearson2 . Regarding the p value of linear models, is there any similar relationship between the p value of Pearson and linear models?


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

## Plotting

2. Simple Linear Regression. Reading the material that was suggested, I learnt that before doing some kind of calculations it is always a good idea to make a scatter plot. From the scatter plot we can see if the data roughly fits a line. Why do we need to do that before calculations?  
   > A1: By using a scatter plot, we can visually examine our data. Making a scatter plot from your data is quite simple and allows us to assess the relationship between the variables before we do the calculations. I.e. you can make a prediction of what the regression line should look like. After the calculations are done, it is also easy to see if the line fits the data, as you say. For me, a visual analysis usually helps to understand the data and make predictions as well as identify any calculation errors. 
   > A2: It is always good practice to visualize data before fitting your model to the data. 


## Notebook
1. 11:0011 Nov at 11:00
[KPNA2 gene analysis] What is the "hue"-parameter?
> In the plotting package I use, [seaborn](https://seaborn.pydata.org/), the *hue* paramet sets the color scheme of the data points

4. Interaction terms in the KPNA2 gene analysis Notebook: When testing whether the gene expression depends on the tumor size, we first perform the test with size as the only variable, and then we also include the grade and node, before finally testing if there’s an interaction between size and grade.  
How do we know when to include interaction terms in the test? If there wouldn’t have been any significant interaction between size and grade, would we then have tested for an interaction between size and node? And if there would’ve been more variables than just grade and node in this example, would we then continue to test for an interaction between the size and all other variables as well, one at a time?
> The quite circular answer os that one include an independent variable when you are interested to test the relation from the variable on the outcome. 

### Other
7. Is there a statistic that can provide hints towards which kind of model could explain our data? Or we find this out empirically by trying out several models.

1. They write that R^2 = p^2 and that because of this a one sided test of R^2 is equivalent to a two sided test of p, but I am not following the logic of this. Would we not rather multiply the value of a one sided test by 2 to get the two sided test-value assuming we have a normal distribution? 

2. In the online reading material, can you explain more about using the LinearRegression to handle multidimensional linear model? And by referring to multiple x values, does it mean multiple variables? Thank you.


1. In the book, section 10.6, the authors discuss how to estimate the p-value and present 2 ways of doing this. They conclude that computing the probability that the slope of the distribution falls below 0 is the best option and good enough even when the sampling size is small and residuals are skewed. In that case, is there any situation where we should use the other method (i.e. computing the probability that the slope under the null hypothesis exceeds the observed slope)?

2. Why when we only have one variable in the linear model to test it is equivalent to a t-test?
> Because this is what a t-test does.


* Goodness of fit, Chap 10.5]  How well a linear model reflects a dataset can be evaluated by calculating the standard deviation of residuals, R-squared or Pearson's coefficient. How do we know which one to choose? The author mentions that standard deviation of residuals is better for assessing quality of prediction than Pearson's or R-squared. Why is that?

* In the Simple Linear regression part in VanderPlas, they show an example of a linear regression with a straight-line fit, which has a slope and an intercept. Then for a multidimensional linear model, the slope is [1.5, -2, 1]. Are these the slopes at the inflection points or what does this mean in practice?

* It was mentioned in the video (7:20) that ANOVA can be used when case and control are evaluated with a linear model and that it would be equivalent to a t-test when we only have one variable. What are the differences between ANOVA and a t-test, and why would it be equivalent when we only have one variable?

* It is stated in Downey 10.1 that the most common way to minimize residuals is to minimize the sum of squared residuals. But they also mention that the absolute value of residuals or their cubes can be used for this purpose. Are these later methods ever used and when would these be used instead of squared residuals? 

* In 10.5, the author thinks standard deviation is a better tool in representing the quality of predictive power, while the coefficient of determination represents better the strength of a relationship, how the predictive power is defined here, I suppose is the absolute difference between the predicted value and the true value, but it is a bit hard to understand the difference between the predictive power and the correlation strength of a relationship.

* In the online reading material, can you explain more about using the LinearRegression to handle multidimensional linear model? And by referring to multiple x values, does it mean multiple variables? Thank you.

* In the book, section 10.6, the authors discuss how to estimate the p-value and present 2 ways of doing this. They conclude that computing the probability that the slope of the distribution falls below 0 is the best option and good enough even when the sampling size is small and residuals are skewed. In that case, is there any situation where we should use the other method (i.e. computing the probability that the slope under the null hypothesis exceeds the observed slope)?

* Why when we only have one variable in the linear model to test it is equivalent to a t-test?

* In the book part 10.1, they mention that using squared residual gives more weight to large residuals and I'm wondering why this is beneficial to the model?

* By giving more weight I think they mean penalising large errors more than small ones. The errors of the data points to fit the model are not treated equally as smaller errors should always be preferred over large ones. So I guess it is about accuracy.

* Textbook: 10.1
In the linear regression model, can we use R squared instead of p-value to evaluate the accuracy of the data?

* in the measurement of goodness of fit, which situation standard deviation is better than the coefficient of determination and why?

* Why is that only those response variables that have an arbitrary distribution, as opposed to a normal distribution, can be subjected to linearization?
And wouldn't such a general linear model be afflicted by outliers as expected in expression experiments? 

* (Simple Linear regression (Links to an external site.) subsection in VanderPlas)
I am having some trouble understanding a real example of multidimensional linear models. Could someone give me some examples of how this could be applied?

* Do you have to calculate the p-value every time you perform data processing? When we have two variables in the data, is it still possible to do the t-test to calculate the p-value? Will it appear that the data has biological significance but not statistical significance?

* We've heard of at least three methods to minimize the residuals in linear regression: sum of squared residuals, absolute value of residuals and cubic regression. How do we determine which of these (and I expect many others) to use on our data? 

* KPNA2 gene analysis Notebook: What does the F value in the fourth column of each table actually mean in this case? Are F values not used to tell us if a group of variables are jointly significant? If I'm not mistaken is it not also used in this case to see if singular variables such as grade or node respectively are statistically significant? Can't a t-test be performed to see if singular variables are statistically significant?
   > The F statistic is defined as the variance of the group means / mean of the within group variances or in other words the Mean Square Between divided by the Mean Squared Error. Test statistics (t-statistic in the T-test, D-statistic in Kolmogorov Smirnov, ...) are used to get the probability value (p value). In order to make meaningful conclusions from your test, both p-value and f-value should be statistically significant (see multiple testing procedures from last lecture).