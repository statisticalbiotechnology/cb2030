# Questions and Answers to Linear Models.

1. Is there any difference for non-linear models in the problem construction, i.e. that you try to minimize the sum of the residuals squared? Is there any case wherein there is a more efficient method than minimization of squares, for example when we may want to weigh certain areas of a model, say where the second derivative is large or some other condition?

1. In order to do weighted resampling - how are the weights actually obtained? Is it only used in case I have different predefined groups so that I know 'how much' I oversampled one particular group or do sampling weights also play a role in case I do not know specific groups before the experiment is carried out / the sample is drawn? E.g. differential gene expression where I would not have predefined groups or if would try to predict the US elections by sampling the population - how would I know then if I oversampled a particular group?

1. In your youtube video, you mention the square sum of residuals I assume this is the same thing as the residual sum of squares (RSS). My interpretation from the video was that RSS is the same as regression or R2 but Wikipedia indicates that RSS is different. What do you mean with the square sum of residuals? is it regression/R2 or do you mean something else and in that case what?

1. “To correct for oversampling, we can use resampling; that is, we can draw samples from the survey using probabilities proportional to sampling weights “  (Allen B. Downey, Chapter 10.7 Weighted resampling). Is the author referring to resampling methods such as permutation tests, bootstrap or Jackknife or is he simply rerunning the test with weights applied?
“If you oversample one group by a factor of 2, each person in the oversampled group would have a lower weight” (Allen B. Downey, Chapter 10.7) Does the application of weights can reduce significant differences in one representing group if the weights are applied on a dataset which is not large enough?  So e.g. if you oversample a group by the factor of two and one of the samples is not representing the actual distribution of the factor in the group you would falsely correct this group. On the other hand, you would give more weight to a group that is represented by just one sample which could also be not representative.

1. If the number of all samples is known, we can proportionally sample according to their different weights after traversing the entire sample. So how do we weighted sampling when we don’t know how big the total sample is, or the total is too large to traverse? Thank you!

1. Are there any assumptions for linear regression other than that the relationship between the dependent and independent variable is linear? What should one do if the assumptions are not met?

1. RMSE (based on standard deviation of the residual) and R^2 are two ways of calculating the goodness of fit for a model. What is exactly the difference between using these two methods? Are they used together? If not when/in which situation are they used respectively and which method is better?


1. To construct a model where the dependent variable consists of boolean data, a logistic regression is used. For data where the dependent variable is an integer count, a Poisson regression is used instead. How do these differ, both in their related distributions and the ways to construct their models?

1. In the notebook, some of the models evaluate the interaction between two explanatory variables, which was not present in the chapters of the book. What is an interaction? Is it equivalent to evaluating correlation between the two explanatory variables and that their information is redundant for the model?  
When you remove the interaction factor from the script, the resulting linear model is a bit less significant for both variables. How is the interaction affecting the variables themselves?  
If we find that an interaction between two explanatory variables is significant, should we remove one of the variables from the model because they are related?

1. Linear models are sensitive to outliers which therefore commonly is corrected for by removal. In the case of large samples including thousands of entities, how do we determine which sample data points that can considered as outliers? Do we ourselves define some kind of threshold or is there a general method that can be used for filtering away these outliers?

1. In chapter 11.8, Downey writes about “pseudo R2-values” that can be used instead of R2 in logistic regression. What is an example of such a pseudo R2-value? Do we interpret these the same way as R2?

1. Could you extrapolate reagarding logistic regression? In 11.6 they say that it can be used for non-numerical dependent variables and use boolean as an example, are there other non-numerical dependent variables?

Nov 4, 17.18
