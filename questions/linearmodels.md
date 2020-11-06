# Questions and Answers to Linear Models.

## Assumptions of a linear model

1. Are there any assumptions for linear regression other than that the relationship between the dependent and independent variable is linear? What should one do if the assumptions are not met?
> We are minimizing the summed square of the residuals, which is a good thing if you have normally distributed residuals. That is not always the case. There are several other techniques for optimization that can be used. Still linear models are popular as they are easy to interpret.

1. Regarding the ANOVA tests made in the jupyter notebook, we get an F-statistic together with the p-value for each test. What does this F-statistic tell us?
> The F-statistic is the statistic we use when we perform [F-tests](https://en.wikipedia.org/wiki/F-test). Roughly it is the quota between the variance explained by the model to the variance of the residuals.

1. Why is the sum of residuals squared and not say to the power of four?  Have we chosen to square the residuals for the sake of convenience or is there actually a thought behind it?
 > There are several [reasons](https://stats.stackexchange.com/questions/118/why-square-the-difference-instead-of-taking-the-absolute-value-in-standard-devia) for this.

1. In chapter 10 , section 10.6 , When it comes to testing our linear model. We can do so by:  
  1. Considering the reduction in Mean square error( MSE) and looking at the relationship of test statistic R**2 between the variables.  
  2. Or by considering slope is due to chance and the null hypothesis is that the slope is actually zero.  
Do we select one of this randomly or is there any specific reasoning based on the our data and the situation how we should test our model?
> If you in 1. mean that you look at the how much the slope variable explains the variance in the data, 1 and 2 are equivalent. In the book they use permutation statistics, and under such conditions, 2. is easier to simulate.

1. Is there a maximum of independent variables that can be included in a multiple regression, and in that case, what is the limiting factor? Will the risk of reporting a spurious relationship increase with an increased number of independent variables?
> No, but the more independent variables you include, the less power you get to prove an effect of each variable. A quote from von Neumann: "With four parameters I can fit an elephant, and with five I can make him wiggle his trunk".


## Residuals

![](http://greenteapress.com/thinkstats2/html/thinkstats2036.png)
1. I thought it was hard to understanding figure 10.2 Residuals of the linear fit. What residuals? and: "Nevertheless, the linear fit is a simple model that is probably good enough for some purposes." Did they conclude that from the graph?
> The author states: "To visualize the residuals, I group respondents by age and compute percentiles in each group, as we saw in Section 7.2. Figure 10.2 shows the 25th, 50th and 75th percentiles of the residuals for each age group. The median is near zero, as expected, and the interquartile range is about 2 pounds. So if we know the mother’s age, we can guess the baby’s weight within a pound, about 50% of the time."


## RMSE

1. 1. RMSE (based on standard deviation of the residual) and R^2 are two ways of calculating the goodness of fit for a model. What is exactly the difference between using these two methods? Are they used together? If not when/in which situation are they used respectively and which method is better?
   1.On Chapter 10.5, the standard deviation of the residuals is defined as one of the goodness of fit, or form to measure the quality of a linear model. Which are other alternatives ways to measure it?
 > Minimizing the sum of squares, any variant involving a division of a constant (R<super>2</super>)  or the mean of the root of them (as [RMSE](https://en.wikipedia.org/wiki/Root-mean-square_deviation)) are equivalent procedures.

1. In what way is the RMSE an indicator of "predictive power" (chapter 10.5)?
> The RMSE is telling of how much variance that remains to be explained after we have deduced our linear model from the data points





## Non-linear problems

1. Is there any difference for non-linear models in the problem construction, i.e. that you try to minimize the sum of the residuals squared? Is there any case wherein there is a more efficient method than minimization of squares, for example when we may want to weigh certain areas of a model, say where the second derivative is large or some other condition?
> I think the book provides a simple strategy for [non-linear relationships](http://greenteapress.com/thinkstats2/html/thinkstats2012.html#sec115).

1. To construct a model where the dependent variable consists of boolean data, a logistic regression is used. For data where the dependent variable is an integer count, a Poisson regression is used instead. How do these differ, both in their related distributions and the ways to construct their models?

1. 1. In chapter 11.8, Downey writes about “pseudo R2-values” that can be used instead of R2 in logistic regression. What is an example of such a pseudo R2-value?
> Here is a blogpost on the [subject](https://thestatsgeek.com/2014/02/08/r-squared-in-logistic-regression/).
   2. Do we interpret these the same way as R2?
   > More or less, yes.

1. Could you extrapolate reagarding logistic regression? In 11.6 they say that it can be used for non-numerical dependent variables and use boolean as an example, are there other non-numerical dependent variables?

1. Regarding the RMSE, in the example presented in 10.5: "knowing a mother’s age does not improve the predictions substantially". In this case, would we still consider there is a relationship between the variables?  
In the book, in the chapter of non-linear relationships the author calculates and uses the square of the age. This selection seems quite arbitrary. What is the logic behind choosing this?
> I think you are right in that the square of the age seems to be an arbitrary choice. He most likely just selected this as an example.

1. In terms of the logistic regression, could you please explain the "odds in favour" please?
> In logistic regression the dependent variable is expressed as log[p/(1-p)]. This results in p taking values between 0 and 1.


1. when deciding whether to perform a logistic or poisson regression, how do you know that your dependent variables are boolean or integers? Could you give some examples ?
> A [Boolean] variable can only take two values, like true or false. An integer can take any integer value. In the case of a Poisson regression the integers are limited to positive integers including zero. An example of a boolean variable is do you have Covid-19, an example of a count is, the number of students in this class have Covid-19.


## Resampling

1. I think I am still not really grasping sampling distribution. Regarding resampling of data to assess sampling error:  
"sampling error is the result of measuring a sample rather than the entire population." p. 142 in Downey  
If you draw new sets of data (with replacement) from your sample to calculate the distribution of those new sets of data, how can that give any new information on the population? We only study the sample more closely, but how can that relate to assessing the sampling error?
> The procedure in Downey simulates the sampling process, by sampling with replacement. This is known as [bootstraping](https://en.wikipedia.org/wiki/Bootstrapping_(statistics)). We are studying the same sample values over and over again, but in a new context each time.


1. In chapter 10.6 (figure 10.4): How do you generate a distribution of slopes that adhere to the null hypothesis?
> You just mix up the links between the dependent and the independent variables. Or as Downey does, the link between the residuals and the independent variable.

1. General question: What consistutes good and bad practices respectively, when it comes to resampling and other bootstrap-oriented methods?

1. Why does the estimation of parameters by resampling give information of the sampling error? As I understand it, it tells us about the sampling error that we would find if we were to take samples from that subset of data, but not about the sampling error we got when sampling from the original population.

## Weighted resampling
1. In order to do weighted resampling - how are the weights actually obtained? Is it only used in case I have different predefined groups so that I know 'how much' I oversampled one particular group or do sampling weights also play a role in case I do not know specific groups before the experiment is carried out / the sample is drawn? E.g. differential gene expression where I would not have predefined groups or if would try to predict the US elections by sampling the population - how would I know then if I oversampled a particular group?
> The point is that the text try to make is that if we have different amount of samples from a certain part of the population we need to compensate for that effect. Say that you have a gender bias in your study, it is good practice to compensate for the geneder-effect when resampling. If you want to make an early prediction of how the mail-in woters in the US elections are going to behave it is nice to compensate for the fact that mail-in woters have different party preferentials that the ones turning up in the election boots.


1. “To correct for oversampling, we can use resampling; that is, we can draw samples from the survey using probabilities proportional to sampling weights “  (Allen B. Downey, Chapter 10.7 Weighted resampling). Is the author referring to resampling methods such as permutation tests, bootstrap or Jackknife or is he simply rerunning the test with weights applied?
“If you oversample one group by a factor of 2, each person in the oversampled group would have a lower weight” (Allen B. Downey, Chapter 10.7) Does the application of weights can reduce significant differences in one representing group if the weights are applied on a dataset which is not large enough?  So e.g. if you oversample a group by the factor of two and one of the samples is not representing the actual distribution of the factor in the group you would falsely correct this group. On the other hand, you would give more weight to a group that is represented by just one sample which could also be not representative.

1. If the number of all samples is known, we can proportionally sample according to their different weights after traversing the entire sample. So how do we weighted sampling when we don’t know how big the total sample is, or the total is too large to traverse?


1. In Chapter 10.7 the authors mention, that "each person in the oversampled group would have a lower weight". Do I understand correctly that it gives a problem of over-averaging the results, but it would also give less of outliers if the sampling group would have some. Also, in real-world sampling would it be more erroneous to oversample or undersample the population?
> These are realtive terms, if you over-sample one type of data, you under-sample another.

1. "To correct for oversampling, we can use resampling" (Allen B. Downey, Chapter 10.7) - What can we do in cases where resampling is not possible? And even when we do resample some bias will still exist in the sampling (possibly even the same biases). How do we overcome these two scenarios?


## Nomenclature

1. Could you clarify the differences among:
  * dependent variables    
  > This is what we call the output from a model, e.g. yhat in yhat = a*x+ b  
  * Response or Endogenous variables
  > Other names for dependent variable.
  * Independent variables  
  > This is what we call the input to a model, e.g. x in yhat = a*x+ b  
  * Explanatory variables and exogenous variables
  > Other names for independent variables
  * Proxy variables
  > Variables used as stand-in for other (often unmeasurable) variables. E.g. bmi for amount of body fat, GDP for welfare is a country.
  * control variable
  > A variable included in a regression to eliminate or “control for” a spurious relationship. I.e. a variable you are not interested to model per se, but want to remove the effect of. E.g. which week-day you did the measurement or which of two 48-well plates your sample was residing at.  

1. 1. What are the implications of running an ANOVA-test using the formula "y ~ x:z", i.e. what does it mean to test the explanatory variables x and z in conjunction?
   1. In the notebook, some of the models evaluate the interaction between two explanatory variables, which was not present in the chapters of the book.  
  > This is unfortunately not covered well by the material in your prepatory reading. Sorry about that. Here is a general description of [patsy notation](https://www.statsmodels.org/dev/example_formulas.html).
  x:z translates into a product between the two terms x and z. I.e. yhat=a*x*z + b


1. In your youtube video, you mention the square sum of residuals I assume this is the same thing as the residual sum of squares (RSS). My interpretation from the video was that RSS is the same as regression or R2 but Wikipedia indicates that RSS is different. What do you mean with the square sum of residuals? is it regression/R2 or do you mean something else and in that case what?
  > A residue is the difference between the estimated and observed variable, so the squared sum of the residuals are \sum_i (y_i-ŷ_i)^2.

2. The formula in the data mining part shows that formula = (' totalwgt_lb ~ agepreg + C(race) + babysex == 1 + '  
' nbrnaliv>1 + paydu==1 + totincr ' ), what is the meaning of the single apostrophe in this formula?
> It just meansd that the formula continues on the next line.

## R2 vs. R

1. In Downey chapter 11.4, the author gives an example of the predictive power of his model, mentioning that previous models had low R² values.  
When regularly working with predictive models, is there a common threshold or interval of R² that a suitable models must fulfill?
> The criterium should be that they are significant.

1. Where do the Pearson correlation coefficient and the coefficient of determination differ in theory?
1. Correlation r and R2  both describe the relationship between Y and X. What is the difference between correlation coefficient r and R2 ? Are there cases where either of them is more reliable?
> One is the square of the other. A typical case where they differ is if r is negative, then r^2 is positive.

1. In section 11.2, when investigating for a spurious relationship between the mother's age and the firstborn's weight, the results were statistically significant, but the R2-value was. In which ways are p-value and R2-value important in statistical models and which of the two should we prioritize?
> prioritize p.

## Data cleaning

1. Linear models are sensitive to outliers which therefore commonly is corrected for by removal. In the case of large samples including thousands of entities, how do we determine which sample data points that can considered as outliers? Do we ourselves define some kind of threshold or is there a general method that can be used for filtering away these outliers?
> There are automatic [outlier tests](https://en.wikipedia.org/wiki/Outlier#Definitions_and_detection). However, I recommend you to instead manually inspect the residuals of your module.

## Notebook

1. In the notebook, some of the models evaluate the interaction between two explanatory variables, which was not present in the chapters of the book. What is an interaction? Is it equivalent to evaluating correlation between the two explanatory variables and that their information is redundant for the model?  
When you remove the interaction factor from the script, the resulting linear model is a bit less significant for both variables. How is the interaction affecting the variables themselves?  
If we find that an interaction between two explanatory variables is significant, should we remove one of the variables from the model because they are related?
> An [interaction](https://en.wikipedia.org/wiki/Interaction_(statistics)) is any effect that relates to a combination of two variables. For instance if you want to test if two different drugs work better in combination than individually to reduce the weight of patients, you might want to test Weight_reduction ~ C(Drug1) + C(Drug2) + C(Drug1):C(Drug2)  


## Other

1. What is the difference between ANOVA and linear regression?
> An ANOVA is a statistical test you perform on linear regression models.

1. In 11.5 the concept of proxy variables is introduced where the correlations with the variable are often caused at least partially by other factors or variables. How are these distinctions primarily determined? Are these determined by correlating this variable with other available variables mathematically or by other means?
  > Its in their nature that the underlying effect is hard to measure. We select them as we cant measure the real deal.
