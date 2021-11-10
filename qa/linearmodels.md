# Questions and Answers to Linear Models.

## Notebook
1. In the Jupyter notebook, the KNAP2 expression is tested for significant dependence on grade, tumor size and the intercation between size and grade. This resulted in a very small p value for grade (1.8E-8) and a quite large p value for size (0.45). The interaction between size and grade gave a significant *p* value (0.016). It then says that "The test suggest that KNAP2 expression depends on an interaction between tumor size and grade". My question is if the significant result obtained for the interaction could be due to the very small p value for grade, thereby kind of "masking" the large p value for size? So I am wondering if we really can be sure that the interaction is significant in itself, and not solely significant in the tumor grade?
 > No, this should not, at least not theoretically, be the case. The model should regress away the larger effect of the tumor grade, rendering the further tests data where the linear effect of the tumor grade is absent.

 1. How can one see “KNAP2 expression depends on an interaction between tumor size and grade” in the Jupyter notebook “KNAP2 gene analysis”? Which value in the table is the criterion?  
 1. In the video lecture, approximately at 11:50, you say that there is an inverse relationship between the node and the grade. How do you see this in the boxplots? How can you determine that there is an inverse relationship between these?
   >  The difference in KNAP2 expression between node=1 and node=0 is positive for grade=1 tumors, but negative for grade=3 tumors. Hence there is a tempting interaction between these variables. We subsequently test if this interaction is significant.  

1. In the video it seems to me that the effect of node upon gene expression is dependent on the grade of the cancer. Can you use multiple linear regression to study the effect of multiple parameters (such as grade/node/size) on a single feature (gene expression) while including the fact that the parameters can affect and be dependent on one another? Can that be done by representing each parameter as a separate "line equation" and looking at the sum of them?
    > Yes, the notebook, for instance, look at KNAP2 expression's dependency on the interaction between tumor grade and if the patient's lymph nodes have been removed or not.


1. In the jupyter notebook "KNAP2 gene analysis", for the different model equations, "C" is not the same value within the same equation? C could be a different values for each term, correct?
  > Not correct! We use the notation C(.), when we want to emphasise that a variable is categorical and not continuous.


## python

1. Could you clarify this code "x = 10 * rng.rand(50)" in  "In Depth: Linear Regression"? rand(50) is a random 50-50 matrix, isn't it? But I cannot get what the meaning of number 10 before the function "rand()" is.
  > I think that if you use x = rng.rand(50) you will get 50 random numbers in the range 0<x<1, while if you multiply this by 10, you will get them in the range 0<x<10.
  >   
  > A2: Yes this is a valid explanation. I get the following results when testing similar code:
  > ```python
  import numpy.random as rng
  rng.rand(5)
  ```  
  > array([5.71024323e-01, 5.82879495e-01, 2.57541449e-01, 2.28721560e-01, 5.37681066e-04])  
  > ```python
  10*rng.rand(5)
  ```  
  > array([2.2329335 , 9.55115181, 5.90653729, 6.60637405, 5.64723141])

2. How can multidimensional linear models be best visualised using Jupiter?
    > I always use the [seaborn](https://seaborn.pydata.org/) package, however there are several other packages available, such as bokeh, ggplot & plotly. I think it is very important for you all to learn one such package well. If you as engineers ever get a job that do not involve displaying data for yourselves or others, you should consider if you are the right person at the right place.

1. In the Jupyter notebook, when test the relation between gene expression and tumor size, how to understand the shadow area of the line of each lymph node status, is there any meaning of the overlapping area?
1. In the linear regression model of KNAP2 and tumor size, there is a shadow around the line. Do they mean other possible linear models? How could we narrow down the shadow to get a more precise result?
  > Seaborn calculates these confidence intervalls by [bootstrapping](https://en.wikipedia.org/wiki/Bootstrapping_(statistics)). They are meant as a reality check for you as a user, how stable are your estimated regression lines.

## Linear Models
1. I do not fully understand the graph in slide 5. In the graph in slide 4, the residual (e) is the distance of the observed variable from the line (so from the model). In graph 5, I do not understand what exactly is e showing in the graph. Could you please make an example on the board?
    > In my slides I show that one can use very similar looking models for categorical and linear variables. The residues will in both cases be the differences between the model and the measurement data.

1. I do not understand how E is calculated/determined/measured? Because RSE is the estimate of the standard deviation of E and is RSS/n-2, so what does that make E (what is the equation for what E is)?
  > *&epsilon; = Y-f(X)*. Depending on what function f(X) we test the residues will be different.

1. Could we say that all values of independent X are not subjected to the measurement error from the corresponding observed Y values in either simple and multiple linear regression?
  > No, we usually model the error term as an addition to the effect from the independent variables.

1. The linear model assumes that the residues follow a normal distribution. If the residues calculated from a data set don't follow a normal distribution, does it have any impact in the linear model constructed? Does this impact (if there is any) depend also on the sample size (i.e. the residues of a small sample may not show a normal distribution just because there are few data points to calculate the residues from, but if we had a bigger sample the normality condition would be fulfilled).
     > Yes, the assumptions of the distribution of the residuals have to full-filled for the tests to be valid.



## Degrees of freedom
I should have done a better job in explicitly stating that I do not want you to cover how F-tests are calculated, including the theory behind degrees of freedom. In this course I want to treat them as as input to the black box of f-tests for significance testing.


1. In the KNAP2 gene analysis: in the generated table we have df, sum of squares, mean sum of squares, F value, and p value. What is df and how is it important?
     > df is an abbreviation of [degrees of freedom](https://en.wikipedia.org/wiki/Degrees_of_freedom_(statistics)). The more parameters you include in your model, the more you lower df of the residuals. This often lowers the sensitivity of the test.  

1. On performing t-statistics, the textbook states that if there is no relationship between X and Y then we get expect a t-distribution with n-2 degrees of freedom.  
What does degrees of freedom mean in this context?
  > See [wikipedia](https://en.wikipedia.org/wiki/Degrees_of_freedom_(statistics))

1. Why ids the degrees of freedom n-2 and not anything else? How is this derived?
 > I specifically want to avoid explaining how we form sampling distributions, so I leave this question for yourself to find out. But in short, you use two parameters in your model, hense you are left with n-2 degrees of freedom after the fit.  

1. I understood the t-test, but didn't understand how, when there is no relation between X and Y, we will have a t-distribution with N-2 degrees of freedom. Can you explain what this means ?
   > Here is an explanation of a [*t* test](https://en.wikipedia.org/wiki/Student%27s_t-test).

1. Why is n-2 in the equation for RSE, what is the logical behind this term in the RSE equation?
   > n-2 is the [degrees of freedom](https://en.wikipedia.org/wiki/Degrees_of_freedom_(statistics)) of the residues. I am not covering the techniques of how significance is calculated in this course, so I leave this for your own indulgence.


## F-tests
I should have done a better job in explicitly stating that I do not want you to cover how F-tests are calculated. In this course I want to treat them as as a black box for significance testing. If you want to know how they really operate there are several on-line resourses to choose from, as well as most standard statistics course that put lots of effort in how they are constructed. However, as said, just see them as a vehicle for the calculation of *p* values from your data and linear models.

1. Is there an easy explanation for what the *F* value stands for, when you do the Anova test?
  > Yes, ANOVA's are dependent on [F tests](https://en.wikipedia.org/wiki/F-test).  


1. It makes sense that we want to minimise the residues of all data point to to get the best regression curve. Why do we use the sum of the squares instead of the sum of the absolute values of the residues?
  > I select two reasons: 1) It makes the maths easier. The derivate of *e(X)<sup>2</sup>* is *2e(X)*. Absolute values are trickier. 2) Subsequently want to use [*F* tests](https://en.wikipedia.org/wiki/F-test) to evaluate the models, which are defined for squared normal distributed parameters. By minimising the squared residues we get the input parameters for the *F* test for free.

1. The text states that when we have a large value of n a F-statistic value close to 1 can still provide evidence against H0 whilst a small value of n would require a large value of F-statistic to reject H0. What values counts as large for n and f-statistics and vice versa?
   > There is no rule. Check the properties by evaluating a F-tests yourself, or do as countless students done before you, use a [table](https://www.stat.purdue.edu/~jtroisi/STAT350Spring2015/tables/FTable.pdf).


2. Could you clarify how to interpret the results of the multiple regression function in the notebook? I haven't fully understood how the p-values are calculated and what it means in this case.
  > No, I will not explain how ANOVA's are calculated.  


1. In the textbook, if I understand right, it said that we can use p-value to estimate whether reject t-statistic model or not because “The t distribution has a bell shape and for values of n greater than approximately 30 it is quite similar to the normal distribution”. So if n less than 30, can we still use p-value to estimate t-statistic, or what other else method can be used? And what the relationship between p-value and t-statistic?
  > No you get the message wrong. For n>30, a t-distribution is asymptotically equal to a normal distribution. If you want to learn more about sampling distributions feel free to discover their beauty by your own.  

1. For the calculations of standard error at p.66 it is stated that the error for each observation must be assumed to be uncorrelated with the common variance. Could you clarify what this means and  why this is the case?
  > The book actually states that the variables clearly are not the uncorrelated, however, that their independence is a good enough approximation.


## Relationship between F test and t tests
1. The book chapter says that the t-statistic for a certain variable is the same as the F-statistic where only that variable is omitted, does this mean that they give the same p-value?
 > Yes.  

1. What is the advantage of t test over f test?
  > None. For historical reasons, we call some special cases of *f* tests *t* tests.

1. The book chapter says that the t-statistic for a certain variable is the same as the F-statistic where only that variable is omitted. Is this what is done in the ANOVA tests used in the jupyter notebook example, since it reports one F-value for each term rather than one F-value for all predictors?
   > No, for most tests in the notebook more than one variable is tested. [*t*-tests](https://en.wikipedia.org/wiki/Student%27s_t-test) can only be performed in case-control situations, or when a single sample is to be compared to a given value.

1. The ANOVA test can be used in order to check whether the means of two or more groups are significantly different from each other. For what reason is the T-test still in use, even though it is limited to only compare two samples at the same time?
  > Because you frequently want to test the difference between two groups.

## Which relations should be investigated?

1. When does one decide to not use linear regression on a data set? Is there a proper way to determine this?  
1. In the textbook it is mentioned that if a predictor seems to be correlated with the observed variable Y in a simple linear regression it doesn't mean that taking account other predictors in a multiple linear regression it will still be significant. They demonstrate it with the example that although the advertising in the newspaper was correlated with the sales in the simple linear regression in the model that all the different media were used it was not. In the same context in the Jupyter notebook the size was not correlated with the gene expression, but the size in comparison with the grade was. Where is the line that allows us to draw conclusions focusing only in a few predictors especially in the really complex biological systems? Is there a way to correct for that? Does this mean that the size is correlated with the grade and the grade with the expression but the size with the expression no? How many predictors should we check in the case of the differential expression analysis and how confident can we be with the results???
  > The best answer is that we should only check the relations that make sense prior to the experiment.

## Model selection

1. In the book on the pages 78-79 about the three variable selection methods, which tests are used to generate the p-values in the different steps of the different methods?
 > They mean that you should evaluate an ANOVA for each step of the model building. I am a bit sceptic to these types of methods, as they indeed offers a possibility for p value hacking. You should instead just test the relations that make sense prior to the experiment.

 1. Is there a reason not to always use mixed selection, such as greater computational requirements?
    > Not really. However, all three suggested schemes are a form of data dredging, or p-value hacking.


1. During the fitting process of a linear model, will only the parameters, (&beta;) change, or are  also the errors (e) affected?
   > Yes the residues are effected by which model we select.

1. The hierarchical principle described in the textbook (p. 89) states that if an interaction term between two variables is included in a linear regression model, the main effects of these variables (i.e. terms modelling the effect of the individual variables) should also be included, regardless of whether these effects have been determined to not be statistically significant. However, I have a hard time understanding the explanation for this. Is it not possible for an independent variable to affect a dependent variable only through its interaction with another independent variable? Will the accuracy of the model in that case not be decreased if we include an individual term for this variable?
   > I liked the textbook's explanation: "The rationale for this principle is that if X1\*X2 is related to the response, then whether or not the coefficients of X1 or X2 are exactly zero is of little interest. Also X1\*X2 is typically correlated with X1 and X2, and so leaving them out tends to alter the meaning of the interaction."
   > Particularly the second part is easy to understand. If there is a small dependency on X1 or X2, that we do not regress away, it will be hard to tell what a significant dependency of X1\*X2 means.

1. In supervised machine learning there is the problem of overfitting, does this also apply to linear modeling?
  > Not directly. If we select an overcomplicated model, we will get insignificant results, as we are decreasing the degree of freedom of the residues. However, it is easy to overfit to the data by incrementally refining your model to the data.

1. How could we evaluate the quality of the linear model? (a variety of  Linear models with different number of variables included, e.g. size or  size and grade). Can we know if the variations of the data have been mostly explained by looking at the parameters of residuals?
   > We normally just take interest in the significance, i.e. *p* value, of each parameter of the model.


1.  As I understood, when building a statistical model for a dataset, it is first decided the shape of the linear model (E.g. Simple straight line, quadratic..) and then, the parameters of the corresponding equation are adjusted to get a best-fitting line. I find this, however, quite biased in the sense that we are choosing the model according to how we think the data is distributed.  Is it possible to do this in a completely unbiased way (that does not imply just trying different models) in which you will get a best-fitting model without deciding the general shape (equation) from the beginning?  
 Even, if the regression approach is commonly good enough, wouldn't it always be better to do it in an unsupervised manner to find any type of relationship between the data?
 > There are several ways to do non-linear fits of data. However, it is often hard to evaluate significance of such models if they are not linear. However, just as you state, there are unsupervised methods to find relationships in data, that will not affect our ability to subsequently test data, e.g. PCA and clustering. These are seldom used in this context. In my mind that is a pity.  

## Regression

1. Since the mean of several the least squares lines seems to be in better correspondence to the population regression line, is it recommended to do several least square lines and use the mean, if so should you use new data for each least square line?
> I do not fully follow the rational behind looking at the mean of the regression lines.  

1. When we speak about linear regression, is it similar to linear equations in sense that a population Y is related to a population X with some terms like intercept and slope when the graph between the variables of each population? Also does finding the beta and beta0 establish a relationship between the two populations? i.e Y is dependent on X linearly.?
 > Linear regression is a type of analysis that tries to model the relationship between two (or more  in multiple linear regression) features by using a linear equation and fitting it to you data. Beta0 and Beta1 would in this model indeed represent the intercept and the slope.  
 Finding these terms means fitting your data to to a linear equation, and it would result in you having estimates of Beta0 and Beta1, but I think it does not necessarily mean there is a relationship between X and Y.  
 You can however assess the accuracy of these coefficients by calculating the standard error for each of them (e.g. SE(Beta1)). You can also determine the p-value for the null hypothesis "There is no relationship between X and Y", which can be used to infer that there is a relationship or not, depending on the size of the p-value.
 > A small addition to a nice answer: The word "population" is problematic in the question. With a linear model we try to establish if there is a linear linear dependency between one dependent variable, say $Y$, and another independent variable, say $X$ for the individuals within the population. The linear test to do such test is written "Y~X". That translates to "Y=aX+b".

1. On page 64 in the text book, they talk about many lines representing least square correction. Is it that the least squares are calculated for the same points taken randomly, few points at a time or different observations of the dependent variable for each point on the independent variable taken randomly?
  > In the text they use one relationship Y(X). They generate a number of different X,Y samples and calculate regression lines for all these samples.  

1. Page 64. “Y = 2 + 3X + &epsilon;”
  Why is &epsilon; added to the linear regression model? How is the size of &epsilon; determined?
   > The text book simulates a some measurements of a relationship between two variables X and Y. They add a normal distributed error in the simulation. They call this error &epsilon;. The parameters of the normal distribution were selected according to the author's ideas of a suitable size of an error.


## Hypothesis Testing
1. Does the *t* distribution change in the two case where &beta; = 0 and not equal to 0 change, if yes then how?
 > Your question is problematic. It contradicts a statement on frequentist hypothesis testing, which I think I stated a couple of times during the previous seminars: We are never calculating any probabilities under *H_<sub>1</sub>*. This is why it relatively easy to calculate *p* values.

2. How to set the null hypothesis in multiple linear regression? I think it's unclear not just one factor difference.
  > There are several null models. One per parameter tested.

1. When using linear regression on binary independent variables, I assume the null hypothesis needs to be adjusted to "the difference between the sets is less than X" but as I am not sure I ask for confirmation.
    > No, we normally select H<sub>0</sub> to be that there is no dependence on the categorical variable and the population parameter we test.


## Power analysis
1. In your video you mention that the plots aren't based on enough data points, what number of data points (roughly) is necessary to be able to achieve reliable results? For example, the p-values in the video were quite low even though, as mentioned, the number of data points wasn't very high.
  > This is dependent on the effect size of the phenomena you are investigation. One often do a [power analysis](http://www.biostathandbook.com/power.html) prior to the experiment to find out.

1. You mentioned in the video that the model can't be trusted if to few data points are used to create it. Will the number of data points affect any of the parameters (such as RSE, F, R^2) that are used to evaluate the models accuracy?
    > Yes. Try it out for yourself in the notebook by subsampling the data.

2. You said that in the KNAP2 gene analysis the number of the data is very low and we can not trust it. With what sample size would you say that we can definitely trust it? Of course, the more the better, but where would you put a threshold approximately?
    > No. This depends on the effect size.

1. Is the linear model still reliable when the number of data points is small? If not, how can we ensure the data is enough?
     > It is still reliable in the sense that we can calculate significance, however, the tests become insensitive when confronted with little data.

## Display of Results
1. Is there a benefit in presenting both t-statistic and p-value? Because they seem to be describing similar things
 > No, just present *p* value.

 1. What test R2 or F is better for assessment linear regression model performance or model fit?
      > None. Normally we use $p$ values.

1. Are there any assumptions for linear regression other than that the relationship between the dependent and independent variable is linear? What should one do if the assumptions are not met?
> We are minimizing the summed square of the residuals, which is a good thing if you have normally distributed residuals. That is not always the case. There are several other techniques for optimization that can be used. Still linear models are popular as they are easy to interpret.

1. How were the equations for calculating the slope and intercept of a regression line derived?
> A descriopion of the calculus can be found in this [blogpost](https://towardsdatascience.com/linear-regression-derivation-d362ea3884c2) 

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
  > Variables used as stand-in for other (often unmeasurable) variables. E.g. bmi for amount of body fat, GDP for welfare in a country.
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


