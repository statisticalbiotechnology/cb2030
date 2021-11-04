# Question and answers -- Hypothesis Testing

## Definition of probabilities
1. What properties of the *p* value makes them uniformly distributed under H0?
   > A1. They are sampled from the same distribution that they are tested against. An analogue is that the probability of a randomly selected Swede to be among the *p*% tallest persons in Sweden is *p*.   
   > A2. For the p-values to be uniformly distributed the distribution of test statistics needs to be continuous, (has infinite range of values). In continues distribution, the chosen sample could be in any percentile of the distribution, meaning that all the percentile of the samples are uniformly distributed. Keeping in mind that a percentile is a statistical value where the certain percentage of scores fall below given sample value, in terms of continuous distribution, it could likely be anywhere.  
   Under the conditions of H0, the exact samples values are calculated if the null hypothesis is true. The sample is chosen randomly from this distribution and p-values represent a location on that distribution, therefore p-values are uniformly distributed under H0.

2. Why don't we use the CDF instead of PDF (probability distribution function) to test the difference in sample means?
   > We do use a CDF for calculating p values

3. Can someone elaborate further why the p-value is not a probability of observing a result as extreme as the one observed due to chance? If we are sampling randomly then any result we get is due to chance, and extreme result have a lower probability. 
   > In The ASA Statement on p-Values: Context, Process, and Purpose it is said that:
   > „P-values do not measure the probability that the studied hypothesis is true, or the probability that the data were produced by random chance alone. Researchers often wish to turn a p-value into a statement about the truth of a null hypothesis, or about the probability that random chance produced the observed data. The p-value is neither. It is a statement about data in relation to a specified hypothetical explanation, and is not a statement about the explanation itself.“
   > It is correct that there is an element of chance. Just as you are saying, ideally, we chose the sample at random. The “correct” definition does not exclude this element of chance. From the ASA statement the first problem with the “incorrect” definition you stated is rather that it can be interpreted as to mean that the p-value is the probability that the data were produced by random chance alone. But the p-value is not about what “caused” the data in the first place:
   > What the correct definition implies is rather: If the null hypothesis is true and we would take a really really big number of samples and calculate the test statistic for each sample, the distribution of all these test statistic values we calculated would be the same as the null distribution. If so, the p-value is “the probability of obtaining test results at least as extreme as the results actually observed, under the assumption that the null hypothesis is correct.” (Links to an external site.), or Pr (our observed or a more extreme test statistic value | H0).
   > The p-value is not Pr (H0 | our observed or a more extreme test statistic value). So just as the p-value is not the probability of the null hypothesis being true, given our observed data, the p-value is not the probability of any other prior assumption about “how the data was produced” being actually true, e.g. another null distribution or just pure random chance. The p-value just tells us that if the null hypothesis is true and if we take many many more samples, we will obtain the same or a more extreme result for (p-value)% of the samples we take.
   > I hope this is not more confusing or partly wrong but put like this it felt more intuitive for me.
   >[amstat](https://amstat.tandfonline.com/doi/full/10.1080/00031305.2016.1154108#.Vt2XIOaE2MN)
   >[wikipedia](https://en.wikipedia.org/wiki/P-value)

## Variance
1. One thing that I don't quite understand is why "as sample size increases, standard error gets smaller; standard deviation does not". 
   > The SE is the error in the estimate of the mean, which shrinks as you increase sample size.

## Hyptheses
1. We speak a lot about when we can reject H0, but not when we reject H1. I do not mean here just keeping the assumption that there is no difference because we have not had enough statstical power, but stating that for ex. 2 populations are actually identical at some confidence level. Do we ever do that? How to find out the confidence level for H1 being false and how does it relate to statistical power?

## Sidedness of tests

1. In 9.4 one-sided and two-sided tests are introduced, but I do not understand which one to apply to which situation? Further, can two-sided tests be used for unsupported hypotheses, why is this the case in comparison to one-sided tests?
   > One-sided tests are used when we have a reason to believe one mean (if we are comparing means) is bigger than the other, thus we are only testing "one-side" of an eventual difference. If we just think there is a difference between the means but don´t know which mean would be bigger, we use a two-sided test, i.e., the absolute value of the difference between the means. I guess the reason two-sided test can be used for unsupported hypotheses since you don´t have to know which mean "should be" bigger while the one-sided tests have to be based on some sort of knowledge or expectation about the system to be able to tell which mean should be tested for being bigger than the other. 
1. Are there any situation when you do exception when to use two-sided p-value and one-sided p-value? i.e. for example in this case you should use two-sided p-value, but in this particular situation we do the  exception and use one-sided p-value. If there are not any exception do you have any examples of articles when they have used the two-sided p-value or one-sided p-value wrong. 

1. In chapter 9.4 (Downey) it is mentioned that a test result can be interpreted in terms of one-sided or double-sided p-values. In which case is one preferred over the other? Since the double-sided p-value is twice as large as the one-sided, do we adjust the threshold of statistical significance in some way?  

1. I'm a bit confused about the reasoning behind using a one-sided test over a two-sided test, as explained in Ch 9.4, page 123. Why is it more appropriate to only use one side of the distribution differences? What makes a hypothesis specific to where a one-sided test is more appropriate? 
   > As I understand, the choice of whether to use a one-sided or two-sided test depends on what you aim to prove/disprove, i.e. the basis for your hypothesis. If you are interested in proving a difference in your test statistic then both the smaller and bigger data become relevant in rejecting H0, thus you should choose a two-sided test. If you are instead interested in proving an increase or decrease in your test statistic then only one side of the data becomes relevant, thus you choose a one-sided test. I believe the appropriate choice boils down to which direction(s) of the test statistic that are relevant in rejecting H0.

1. in 9.4  when we need to use a one-sided test or a two-sided test, what is the difference between them in test statistics?
   > A1: You use the absolute value of the one sided test statistics to derive a two-sided statistic if the distribution is symetric.
   > A2: A one sided test is used when one needs to measure the effect only in one direction. If the test statistic falls on one side of the normal probability it allows us to infer that an effect is seen in that direction. We can rely on the one sided test only if we are testing for something very specific. Like: the how much more significant is the effect of drinking on gambling than say proximity to casinos.
   > A two sided test allots equal probability for the test statistic to fall on either side of the normal probability. This can be translated as, if one wants to measure the beneficial effect of a new drug on a population, it test for both scenarios where the mean is greater than(not-beneficial) and less than(Beneficial). 

1. (Think Stats 2e, Chapter 9.5 - Testing a correlation)  
In the context of testing the statistical significance of a correlation, what factors are used to determine whether to use a one-sided or two-sided test, in the real world? 

1. I am wondering if the terms  "one-sided" and "two-sided"  refer to both the p-value and the statistical test and are in that sense interchangeable? In other words, is the one-sided p value the "result" of a one-sided test and two-sided p-value the result of "two-sided" test?


## Sampling process
1. [Classical hypothesis testing] It is stated in 9.1 that statistical significance of an apparent effect allows for inference that the effect is likely to appear in the larger population too. Say that the sample group consists of a few thousands individuals from Sweden, and that the larger population is all inhabitants in Sweden. This must surely be of different statistically significance in comparison to the whole world's population. What are the limitations of statistical significance in regard to population size, and how are they evaluated?

## Sampling distributions
1. How can one quantify the sampling error when you do not know the actual value for μ and σ? Can you only do such calculations with estimated values of μ and σ, and are these based/estimated from a randomly selected sample or can these values be estimated/chosen by other means? 
(based on “8.3  Sampling distributions”)
   > If we know nothing about our dataset then the only possible estimation is using our samples mean and SD. This estimation is usually the bigger the better, so we come down to another scenario in case we have huge datasets, for example we need to take a sample from a chemical product each day and measure a compound concentration. In this case we will not make our estimation from that days sample and rather relying the vast amount of data from the past, which will provide a better estimation.

1. In the preparatory material, the sample distribution or test statistic is typically calculated using "mean". Does this "mean" refer to the arithmetic mean or the median of the sample? And can they be used interchangeably, depending on the problem or would it result in different probable solutions?
   > I think Mean here refers to the mean calculated using the formulae as per given in the text book page number 25. It does not refer to the median is what I have understood. I think median and mean should be used depending on the problem at hand. 
   > check this page out to know when to use median and mean [central-tendency](https://courses.lumenlearning.com/introstats1/chapter/when-to-use-each-measure-of-central-tendency/)

1. [Sampling Distributions] - when building a sampling distribution we draw values at random many times from a normal distribution. For this method to work the actual distribution of the phenomenon we are investigating also has to be normal. How often do we get the underlying distribution wrong when building our model? How can we tell if we have chosen the wrong distribution? 

1. While figuring out the test statistics, it said that the difference in the means are usually taken. But why is the mean (one of the statistical central tendency ) is chosen here instead of mode or even median? According to what I have understood, the median can be used in situations where 
  1. Few extreme scores in the data collected ( if the scores are extreme we cannot use mean as it will skew the value)
  2. If the distribution is open ended one.
All these possibilities are probable in the hypothesis that is chosen. Then why does the test statistics only use mean as the central tendency and not median? I am confused here.

1. 9.3 Testing a difference in means
in this part, we want to see if the longer mean pregnancy length for first babies is statistically significant. Then modeling the null hypothesis by permutation. it said "we can take values for first babies and others and shuffle them, treating the two groups as one big group" .  
In MakeModel part, we combines the groups into one NumPy array. And then in RunModel code , we shuff the pooled values and splitting them into two groups. I am confused about how they split those values? randowly? The value and numbers of first babies are fixed, what's the point to shuff and then split? How this step attribute to test the differnece? What's the logic behind it ?
    > As you said, they are using this logic as a way to model the null hypothesis. So as I understand it they want to create a situation where H0 is true. Since we're testing if there is a statistically significant difference in mean for pregnancy length comparing first babies and others, H1 is that there is a difference in mean and H0 is that there is no difference in means. Before doing the test we don't know whether we will end up rejecting H0 or not, but regardless, the p-value is the probability of observing the result in your test statistic or a result more extreme under the assumption that H0 is true. Therefore, we need to be able to compute the probability distribution of different results when H0 is true, otherwise we will not be able to calculate a p-value. By combining the data points from the two groups and shuffling them, then splitting them up again, we create two new groups which due to the shuffling satisfy the null hypothesis, and based on this situation we can now compute the p-value.

1. In 8.3, they are using an example with gorillas to explain samling distribution. They assume that the population is well known, in order to choose a representative sample, but then goes on to discuss how a sampling error can occur if you happen to sample only the smallest or largest gorillas. Since weight is the parameter of interest and we don't know what the gorillas weigh (and therefore might choose a sample with poor distribution); from a statistical point of view, why does the population have to be well known, and what properties could that include?

### Confidence intervalls

1. I have a question about practical application of CI in section 8.3.  When we calculate the CI in some case such as KM survival analysis, we may get a CI like (X, NA).X is an actual value, but i don't know the meaning of NA and why we get NA.



## Pemutation tests
1. I have a question about permutation from section 9.3 in the book. As I understand it, permutation means taking values from different groups and combining them into a new group, and the book mentions this as a way to "model the null hypothesis." However, I don't understand how this works/what the purpose is - aren't we interested in the difference in mean between two different groups? Why would we then want to combine them into one group?
   > The purpose of this permutation is to "model" the null hypothesis. Lets say we have group A and B and we make a t test for their values, so we do not know at this point if they are different or not. The null hypothesis is that they are equal. For the computational system we create the scenario when we know that the null hypothesis is true and for this we just mix the two groups randomly (permutation), which will satisfy the null hypothesis. Having this we can "compare" if the original not mixed A and B are also satisfying this null hypothesis or not.

1. [Concerning section 9.3] They write that a way to model the null hypothesis is by permutation of values from two different sampling groups and then treating the two as one big group. How does this create a model where the distribution for the two original groups are the same? Could you offer a more elaborate explanation? 
   > I found this document from the faculty of Washington about permutation tests done by Ken Rice and Thomas Lumley (https://faculty.washington.edu/kenrice/sisg/SISG-08-06.pdf (Links to an external site.)). It helped me visualize permutation tests. 
   > "A permutation test gives a simple way to compute the sampling
distribution for any test statistic, under the strong null hypothesis
that a set of genetic variants has absolutely no effect on the
outcome."

## $t$ tests

1. From preparatory reading, the is an extra reading on t-test. I would like to know the differences between t-test and z-test, and when to choose one over the other and what effects each test has on the p-value
> The two test statistics sample from two different distributions, normal distirbution and student's t-distribution for z-test and t-test respectively. The t-test is generally used when the variance is unknown and the z-test assumes a known variance, but for larger sample numbers, the t-distirbution approaches the normal distibution and such may be approximated at larger sample sizes using the normal distibution. Since the p-value is the probability of getting the derived result or a more extreme result assuming the null hypothesis is true (integral of probability density function between test statistic and infinity) at either one tail or both tails depending on the test, the p-value will be affected accordingly by the calculation of the test statistic with accompanied distribution.

## Significance levels

1. [Significance levels]- The most common way of interpreting scientific results seems to be comparing the p-value to our conventionally set significance level (p<0.05) and drawing the conclusion that our results are either statistically significant or not. However, I have always found it quite random why precisely 5% is the convention. Upon further investigation I came across several reports strongly criticizing significance levels, going so far as to suggest banning significance levels altogether. One argument was “The widespread use of ‘statistical significance’ (generally interpreted as ‘p ≤ 0.05’) as a license for making a claim of a scientific finding (or implied truth) leads to considerable distortion of the scientific process”  
These concerns have apparently been brought up by statisticians for decades. So, why are significant levels still so widely used in reports? Is it merely out of habit and convention?  [site](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5502092/)
   > Yes, it *only* due to convention. 


1. In chapter 9.2 the author writes that p values between 1-10% should be considered borderline as they are neither unlikely to occur by chance or plausible to be explained by chance, and concludes that the data is not strong enough. However, p-values in this range are often used for drawing conclusions. Why do people in the scientific community use p-values in this range if they are not reliable, does it not make the conclusions useless? Why not introduce a generally accepted significance level rather than having each individual setting it by convention?


1. Since the choice of 5% being the threshold for statistical significance is arbitrary, and the p-value depends on the test statistic and null hypothesis model, how do researchers justify that their set significance level is actually relevant for making conclusions about their hypothesis. What if the significance level is conventionally set to a specific level in order to reject a hypothesis in favor of the research. This concerns the reading material: 9.2. 


## Correlation tests

1. In 9.5 Testing a correlation, Pearson's correlation was used for the test statistic but states that Spearman's would also work. When should one be used over the other and what other correlation tests could have been used for the same example?
> A1: Both Pearson and Spearman are used for measuring correlation but which one you choose depends on the kind of analysis you want to make. Pearson correlation evaluates the linear relationship between two variables, where the increase/decrease rate is constant (since it's a linear relationship). Meanwhile, the Spearman correlation evaluates the monotonic relationship, that is, a relationship in which variables tend to move towards or against the same direction, but not necessarily at a constant rate. In other words, for example, as the value of one variable increases, the value of the other variable increases too, and vice-versa. The Spearman correlation coefficient is based on rank-ordered variables rather than the raw data itself (Pearson).  
When analyzing scatterplots and looking for correlation relationships, the advantage of using Spearman over Pearson is that it can also account for monotonic relationships, while Pearson can only account for linear ones. Spearman can end up detecting a perfectly linear relationship, which is totally fine. However, if you were to apply a Pearson correlation to data that isn't exactly linear, we could miss information that Spearman could capture.
> A2: I was also wondering about this and found that both Pearson's correlation and Spearman's correlation can be used when we want to measure a linear relationship between two variables. But Pearson's correlation can only measure linear relationships, so when we have two variables with a non-linear correlation and use the Pearson correlation coefficient we will assess their linear relationship. With Spearman's rank correlation coefficient, we instead measure the monotonic relationship. For example that one variable always increases when the other variable increases, and this does not have to be linear. 
So in this case (in 9.5), I guess that we had a linear correlation and therefore could use both Pearson's and Spearman's correlation. 

## Log-normal and expression data
1. In the Jupyter notebook about differential expression analysis, a significance test is performed for the difference between triple negative and other cancers by using a t-test. This is based on the assumption that the RNA expression data follow a log-normal distribution and thus is log transformed to get a normal distribution. It is also stated that “It is generally assumed that expression values follow a log-normal distribution, and hence the log transformation implies that the new values follow a normal distribution”. Why is that and are there any cases where this assumption is not valid?
  > This is true when errors are multiplicative rather than aditative. This is frequently the case when we work with concentration.


## Design of experiments
1. How can we estimate the minimun required sample size in order to perform a reliable hypothesis test?
   > I think there is no correct answer for that and it depends on what your research aim is. The main idea is to increase your statistical power so one could say more sample size is the better, but in practice, it is generally decided based on how easy one can collect the data, the time, cost, and the amount of people working on the project. In addition, when you think about clinical research, you don't want to try something novel on many patients to just increase your sample size, right? In summary, although there is no consensus on that, there are different approaches for different purposes. Mead's resource equation, for example, can be used especially for animal studies as an alternative to the power analysis where you do not know standard deviation and the effect size.

1. How can we select a sample size to prevent sampling error? The code in 8.3 estimates if N=9 renders reasonable results, but is there a way to decide an optimal N?
Also, why do we have to reject the null hypothesis? Couldnt we make H1 be H0 and, instead of disproving H0, prove H0?
   > We will get an optimal result without sampling errors when $N$ is infinite.



### Other 
1. What type of evidence is required to assume normal distribution?

> video 5.47
How easy is it normally to determine the distribution (normal, binomial, Poisson etc) of the test statistic? Have there been cases where researchers found that none of the existing distributions was good to apply in their hypothesis test? In that case how did they deal with this problem?

1. I am having trouble understanding the point of the graph in the permutation test Figure 9.1 in part 9.3. I understand they choose the complement value of their p value (0.17) which is 0.83 to decide the intersect the line in the graph, but I do not understand what this gives in terms of results. What would be a general use of this method and what is the purpose?
> It is an explanation of how p-value are related to CDFs


1. In section 9.3, how do we see that the difference in means is about 0.17 weeks? Is it where the CDF reaches 1? What does the scale from  0 to 1 on the y-axis represent? Is it the probability of finding the difference or something else?


2. How do we use Bayesian methods to claim that  there is a 90% probability that the actual parameter, µ, falls in the 90% confidence interval is not true? (based on “8.3  Sampling distributions”)




