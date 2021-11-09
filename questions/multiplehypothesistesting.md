# Questions and Answers to Multiple Hypothesis Testing.

## The multiple in multiple testing

* Are q-values and FDR sensitive to the number of measured variables in any way? 
   > Yes, they obviously are. FDR(t)=mt*pi_0/\|{p<=t}\|, so both the nominator and denominator is influenced by the number of tested hypotheses.

* I am wondering why are *q* values necessary? *p* values can be used in hypothesis testing to test the significance of the null hypothesis. Why is it cannot be used in the same way in multiple hypothesis testing? Why do we need extra values in this case?
   > In multiple hypothesis testin, it is hard to tell the probability that a finding is wrong from an individual *p* value without knowing the distribution of the other estimated *p* values. A FDR or a *q* value has an intuitive explanation.
## *p* values
* The null hypothesis p-values frequencies are evenly distributed between 0 and 1 by definition. Is there a particular reason for such deffinition?
> *p* values under null hypothesis is uniformly distributed because they are taken from the same distribution they are tested against according to our last seminar.

## False discovery rates

* In "Statistical significance for genomewide studies" it’s stated that one doesn’t want to underestimate the q-value. If one were to underestimate the q-value, what would this imply, how would this affect FDR?  
> A1: That would imply that you would report fewer errors than you actually have.   
> A2: Underestimating FDR leads to possible unexpected false discoveries.

* In the end of the video it is mentioned that if we find 1000 genes at an FDR of 5%, it means that 50 of those genes are incorrectly assessed. How do we use that information in practice, how we go about to determine which of the observations are true and which are false? 
> When you estimate errors you just estimate errors!

* When defining the FDR they state that the significant features (S) have p-values lower or equal to the threshold: S(t) =#[p <=t]   
but they also say that the number of null statistics (F) is: F(t) = #[null p <= t]. Why do the null hypotheses not have p-values > t , as we have learned earlier?
   > It's because the F is the number of false positive features, so these would be the null hypothesis included in the values lower than the threshold. The null hypothesis that are higher than the threshold would be the true negative values which they are not interested in measuring for that particular purpose. See the third page of the article where it shows:  
   F/S' = F/F+T = no. false positive features/no. significant features


## Monotonicity
1. I would just like some clarification on why we are interested in having a monotonical decrease of the false discovery rate? Doesn't "sawing off" the peaks make us report a lower FDR? 

1. The  *q* values are semi-[monotonically](https://en.wikipedia.org/wiki/Monotonic_function) increasing with *p* value. Why are we interested in a monotonical decrease? 
   > A1: We smooth the FDRs into *q* values by defining a feature's *q* value to be the minimal FDR of any treshold that includes the feature. The procedure is important as we otherwise would not be able to allocate a FDR treshhold to a particular feature (, as there will be multiple such FDRs).
   > A2: In mathematics monotonic refers to the funciton between ordered sets that preserves or reverses that particular order. I think the monotonic increase or decrese is important as with the presence of multiple FDR we should allocate a threshold value to the paricular order or feature we are interested in. In order to do that motonic function is important. The q value is defined as the minimal FDR value for the given feature.
   > A3: Monotonicity is nicely explained [here](https://brainder.org/2011/09/05/fdr-corrected-fdr-adjusted-p-values/)  
   If you wanna see the mathematical proof of the resulting theorem, you can have a look at the following publication even though it requires a lot of advanced mathematics/statistics: https://projecteuclid.org/journals/annals-of-applied-statistics/volume-5/issue-2A/FDR-control-with-adaptive-procedures-and-FDR-monotonicity/10.1214/10-AOAS399.full   
   If you do not perform adjustments (e.g. Grenander density estimator) ensuring monotonicity you might end up in the situation that moving to a lower p-value results in higher q-values, which is undesirable/nonsense. Additionally, ensuring monotonical decrease results in comparable results to the Benjamini-Hochberg Procedure, which is not the case when not adjusting the FDR.

1. If we look at the slides 25/26 and the graphs that show the FDR and number of accepted statistics, the graph is non-monotonic when not considering the q value, however is this not only possible if we know the true outcome? In reality why will we not get a monotonic graph with only FDR anyway since we never know what is truly Null or Alternative? Doesn't the it follow that the number of False positives go down when we lower the threshold and thus there should be no jagged curve.


## *q* values
* As I understand it, the p-value gives information regarding the false positive rate whereas the q-value gives information about the false discovery rate and I understand that the FDR is interesting since it's based on the false positives out of the features called significant instead of the false positives out of the truly null features. However, I don't understand the point of using the minimal FDR, when that means that the actual FDR could be higher? What does the q-value really tell us, considering this? 
> A1: FDR is calculated from the experimental data you have. There is some variance in a specific p-value that you obtain for false positives, and you often still obtain true positives with higher p-value. You will hence get lower a FDR for higher p-value threshold. Then imagine you plan to repeat the experiment, and you want to minimize FDR while still keeping reasonable sensitivity (still detect proportion of true positives within desired range). The data on FDRs from previous experiments tells you, that by increasing p-value threshold you can get lower proportion of false positives in all significant results. But is that right? Well, if your model is correct, and p-values are evenly distributed under H0, it should not be. I believe the figure from slide nr 13 ilustrates it very well :)
> So if we want our estimated FDR to stand really for expected proportion of positive results (ex. in next experiment) coming from H0, and not overfit it to the data we have, the strategy of choice is to go for q-value.  
> A2: This is a subtle, but the difference it is easier to define the minimal FDR of any set defined by a treshold that includes the current -value, than to make a definition based on a maximal value.    


* Which of the measures *q* value, FDR, and *p* value focus on sets, and which focus on individual measurements.
   > FDR is a property of a set, while both *q* and *p* values are estimates for individual datapoints. The *q* values are estimates for individual datapoints within a list.

* Do you need to calculate the p-values of each feature before you can calculate the FDR and q-values? In that case, this is a method that needs to be used in combination with p-value calculation and not instead of p-value calculation. I assume then, that the authors argue that this extra computation is worth it to get a more representative statistical value. 
   > The scheme in [remark C of the appendix](https://www.pnas.org/content/100/16/9440#app-1), or any other type of empirical null model, can actually be used for estimating *q* values direcly, whithout having to estimate *p* values. 


## π0 estimation
* What is the practical meaning of π0? Is it purely theoretical is it used to estimate some parameters? 
  > In differential expression this is the fraction of genes whos gene-products are non-differentially abundant. Seems quite relevant to me.

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
    > I don't think these types of errors make a difference per se as to when to use this methodology, but I am guessing that if there is a systematic error it will be difficult to find significant features.   
    I believe you are confusing the Type I and Type II errors, which are different from random and systematic errors, (https://en.wikipedia.org/wiki/Type_I_and_type_II_errors (Links to an external site.)), and only type I errors (false positives) can apply to this methodology. 

* If I have a hypothesis with two independent statements, can I consider it within the context of multiple hypothesis testing and apply the concepts, such as q value and FDR?

* In the "Remark B: General Algorithm for Estimating q values" in the article they highlight their pick for λ, and further explain they set the degree of freedom of the natural cubic spline to 3, as this would serve their purpose by limiting its curvature to be as a quadratic function. I do not understand how they deemed that this method performed well, and the data is not given in the article. 

* In the jupyter notebook, two alternative methods are used to estimate π0 (the bootstrap method and a method similar to what is described in “Statistical significance for genomewide studies”). This yields relatively similar result, approximately 0.194 and 0.185 respectively. What are the pros and cons with each method and are there any cases where one is preferred over the other?
The bootstrap method is slightly more stable, and hence I use it in the notebook.


* As there is p-hacking, is there also q-hacking? 

* In Storey and Tibshirani’s paper, they mention that the conservative property of q-values is desirable, and that the q-values appear to have this property under weak dependence, for large number of features m. Does this mean that the accuracy of q-values will decrease for smaller a m? Does the the accuracy of q-values depend on m, and does this affect when FDR/q values are used?

* [Video 11:30] How can you mathematically proof that the p-values are evenly distributed on the null-hypothesis?

* In example 1 of the article, they first used a p-value cutoff of 0.001 and found 51 genes of interest, and later they instead used 0.0001 as the cutoff and found 9-11 genes. After calculations at the first threshold, they expected 3 false positives. Could there be reasons to push the limit further, even if you do not expect any false positives? 

* Since the false discovery rate is inherently related with the false positive rate, and the q-value with the FDR, there exists a dependence of q-value on the false positive rate (whose indicator is the p-value).
How reliable is the inference reached by such a testing? since we overlook the p-value for a multiple hypothesis testing.

* Is there situations where it would be more appropriate to use only the p-value and the q-value is not relevant, or is it always ideal to use q-values in addition to p-values?

* In the paper the authors give research examples where the False positive rate can not be to liberal. Are there any examples of research topics where it does not matter if the false positive rate is to liberal or is it good practiceto do it this way?   

* In paper mentioned the way to estimate π0 without specifying the distribution of the truly alternative p values is difficult. In Fig 1 they estimate the p value is 0.5. if we want to provide more accurate p value, how can we estimate π0 under that estimation?


* The slide at [8 min] shows that lowering and raising the p-value threshold gives fewer true positives and more false positives, respectively. Meaning that while there are advantages to shifting the threshold up or down there are also issues with doing so. In terms of correcting for these missed TPs or incorrectly identified FPs, which of the two are easier to identify and correct? Can they be identified? 

* Is there any other method other than FDR and πo estimation we can use to set the threshold? 

* Video minute 16. 𝜋0(𝜆) function
I thought the point of fitting the cubic spline to the graph of all the 𝜆 from 0 to 0.95 with a step of 0.01 was so that we could estimate the value of 𝜋0 at 𝜆 = 1 In the video you say that at 𝜆=0.6 the variance start to get to large and we can no longer trust it, but why do we need to trust it?
Wouldn't we always fit a curve to it to estimate the value of 𝜋0 at 𝜆 = 1 even if the variance stayed small at higher values for 𝜆 ?


* When selecting a threshold, when is it more benifical to select a threshold that gives us fewer false postives but also fewer true postives, and when do we want to select a threshold that gives us more true postives but also more false postives? [Video 8:00]

* In the video (Approximately at 10:20), the FDR is defined as an expectation value i.e E(F(t)/S(t)), why is that? 
  
* In video, is π0 estimation the same reason or answer to explain the p-value in the typical hypothesis test?