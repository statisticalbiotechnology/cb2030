# Questions and Answers to Multiple Hypothesis Testing.

## The multiple in multiple testing

* Are q-values and FDR sensitive to the number of measured variables in any way? 
   > Yes, they obviously are. FDR(t)=mt*pi_0/\|{p<=t}\|, so both the nominator and denominator is influenced by the number of tested hypotheses.

* I am wondering why are *q* values necessary? *p* values can be used in hypothesis testing to test the significance of the null hypothesis. Why is it cannot be used in the same way in multiple hypothesis testing? Why do we need extra values in this case?
   > In multiple hypothesis testin, it is hard to tell the probability that a finding is wrong from an individual *p* value without knowing the distribution of the other estimated *p* values. A FDR or a *q* value has an intuitive explanation.
## *p* values
* [Video lecture 8:00ish]
If I understood correctly the null hypothesis p-values frequencies are evenly distributed between 0 and 1 by definition. Is there a particular reason for such deffinition?
> *p* values under null hypothesis is uniformly distributed because they are taken from the same distribution they are tested against according to our last seminar.

## False discovery rates

* In "Statistical significance for genomewide studies" it’s stated that one doesn’t want to underestimate the q-value. If one were to underestimate the q-value, what would this imply, how would this affect FDR?  
> A1: That would imply that you would report fewer errors than you actually have.   
> A2: Underestimating FDR leads to possible unexpected false discoveries.

* In the end of the video it is mentioned that if we find 1000 genes at an FDR of 5%, it means that 50 of those genes are incorrectly assessed. How do we use that information in practice, how we go about to determine which of the observations are true and which are false? 
> When you estimate errors you just estimate errors!



## Monotonicity
* [Video 18:00]- I would just like some clarification on why we are interested in having a monotonical decrease of the false discovery rate? Doesn't "sawing off" the peaks make us report a lower FDR? 
* The  *q* values are semi-[monotonically](https://en.wikipedia.org/wiki/Monotonic_function) increasing with *p* value. Why are we interested in a monotonical decrease? 
  > We smooth the FDRs into *q* values by defining a feature's *q* value to be the minimal FDR of any treshold that includes the feature. The procedure is important as we otherwise would not be able to allocate a FDR treshhold to a particular feature (, as there will be multiple such FDRs).

* If we look at the slides 25/26 and the graphs that show the FDR and number of accepted statistics, the graph is non-monotonic when not considering the q value, however is this not only possible if we know the true outcome? In reality why will we not get a monotonic graph with only FDR anyway since we never know what is truly Null or Alternative? Doesn't the it follow that the number of False positives go down when we lower the threshold and thus there should be no jagged curve.


## *q* values
* As I understand it, the p-value gives information regarding the false positive rate whereas the q-value gives information about the false discovery rate and I understand that the FDR is interesting since it's based on the false positives out of the features called significant instead of the false positives out of the truly null features. However, I don't understand the point of using the minimal FDR, when that means that the actual FDR could be higher? What does the q-value really tell us, considering this? 
> A1: FDR is calculated from the experimental data you have. There is some variance in a specific p-value that you obtain for false positives, and you often still obtain true positives with higher p-value. You will hence get lower a FDR for higher p-value threshold. Then imagine you plan to repeat the experiment, and you want to minimize FDR while still keeping reasonable sensitivity (still detect proportion of true positives within desired range). The data on FDRs from previous experiments tells you, that by increasing p-value threshold you can get lower proportion of false positives in all significant results. But is that right? Well, if your model is correct, and p-values are evenly distributed under H0, it should not be. I believe the figure from slide nr 13 ilustrates it very well :)
> So if we want our estimated FDR to stand really for expected proportion of positive results (ex. in next experiment) coming from H0, and not overfit it to the data we have, the strategy of choice is to go for q-value.  
> A2: This is a subtle, but the difference it is easier to define the minimal FDR of any set defined by a treshold that includes the current -value, than to make a definition based on a maximal value.    


* Which of the measures *q* value, FDR, and *p* value focus on sets, and which focus on individual measurements.
   > FDR is a property of a set, while both *q* and *p* values are estimates for individual datapoints. The *q* values are estimates for individual datapoints within a list.

## π0 estimation
These questions are to some degree dealt with in the spline estimate section of the *q* value [notebook](../nb/multiplehypo/qvalue.ipynb)

* [Video 15.40]
I'm wondering about the π0 estimation and the π0(λ) against λ plot. How is λ is selected for the estimation? The video says that we look for where the variance start to increase, but can still be trusted in the plot (around λ=0.6), but how is this λ=0.6 then used? I'm wondering since it is then said that we want to estimate at λ=1.  
Also, why do we want to estimate π0(λ=1)? Since the previous slide says that 
λ closer to 1 means you obtain less inference from the alternative hypothesis?

* Video lecture, time: 16.00. 
How do we choose the value of λ in the π0(λ) function? Here the value of π0 is similar when 
λ=0.6 (where we get larger variance) and when λ --> 1, but if this wasn't the case, would we select 1 or 0.6?  


## Other types of multiple hypothesis corrections

* In Statistical significance for genomewide studies by Storey and Tibshirani, the paper states that "the error measure that is typically controlled in genome scans for linkage is the family-wise error rate". Are both the False discovery rate (FDR) and Family-wise error rate (FWER) different approaches to control type I errors? if that is so, what is FWER and when do we typically use it?
> [FWER](https://en.wikipedia.org/wiki/Family-wise_error_rate) was popular before the advent of the Benjamini-Hochberg method for estimating the upper bound of the FDR was invented. In short FWER is the probability of at least one finding being a false positive.

* In one popular R-package I found that the the method for calculating the p.adjust(q value) is benjamini-hochberg. When should we use such estimates?
> I think q-values are to be prefered. That is why I use them in this course.


* Why in the article shown they used unadjusted p-value rather than adjusted p-value?
> They are using the FDR which is a sort of adjusted *p* value.

## Histograms
* In figure 1 of Storey and Tibshirani's paper, I don't understand the scale of the y-axis. I thought that in a density histogram the sum of the density values of all bars should be 1?
> A1: As I understand, the histogram itself represents a frequency distribution meaning that the height of each bar is equal to the average density (y-axis) of the corresponding p-value interval (x-axis). So it is not the height of the individual bars that add up to 1 but instead the area you get by integrating over the bars that add up 1.  
> A2: It is worth noting that you are not the first one to ask yourself this [question](https://math.stackexchange.com/questions/2666834/what-is-the-difference-between-frequency-and-density-in-a-histogram)


## Other
* Is there any readjustents (in terms of p-values or FDR threshold) that can be made in order to reduce the FDR once its been calculated?


* From video lecture on Video Lecture on Multiple Hypothesis Testing,Time:6:57 Do we even care about false negatives? If we have a really high amount of false negatives should we lower the threshold?
> False negatives are important as they help in determining Type II errors where we accept a false null hypothesis. A null hypothesis should be selected such that it is rejected, and give positive results. A false negative could therefore have a bad outcome on the test as we will not reject the null hypothesis when it is actually false.
False negatives can be avoided by increasing the statistical power of the test, which in turn can be done by increasing the sample size and increasing the significance level threshold. A higher significance level will imply a higher probability of rejecting the null hypothesis, reducing false negatives, but it can increase the rate of false positives or type I errors (which is rejecting the null hypothesis, when it is actually true). Lowering the significance level will decrease the number of false positives (type I error), but increase the number of false negatives (type II error). So, both type I and type II errors influence each other and the experimenter should find a balance between them depending on the research question.
However, I do think type I errors are more significant in statistical analysis than type II.


* Is there a way to combine all hypotheses into one model and test for all of the null hypothesis at the same time with p-value? And if possible, would this be better the than testing multiple null hypothesis with q-value?
> You would typicalluy merge your null hypotheses into one single statement e.g. µA=µB=µC=0 in an ANOVA with three groups.

* Are the q values used for FDRs both in random errors and systematic errors or do you use a different approach in the two cases?

* If I have a hypothesis with two independent statements, can I consider it within the context of multiple hypothesis testing and apply the concepts, such as q value and FDR?

* In the "Remark B: General Algorithm for Estimating q values" in the article they highlight their pick for λ, and further explain they set the degree of freedom of the natural cubic spline to 3, as this would serve their purpose by limiting its curvature to be as a quadratic function. I do not understand how they deemed that this method performed well, and the data is not given in the article. 

* In the jupyter notebook, two alternative methods are used to estimate π0 (the bootstrap method and a method similar to what is described in “Statistical significance for genomewide studies”). This yields relatively similar result, approximately 0.194 and 0.185 respectively. What are the pros and cons with each method and are there any cases where one is preferred over the other?
The bootstrap method is slightly more stable, and hence I use it in the notebook.

