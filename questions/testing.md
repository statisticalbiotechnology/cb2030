# Question and answers -- Hypothesis Testing

### Tests
1. In the book it said that one of the most common effects to test is a difference between two groups (section 9.3). What are other common effects to test? 
> Any effect you want to prove in a scientific experiment should be testable.   
> S: Linear Regression for example: is there a correlation between your height and and [klafter](https://en.wikipedia.org/wiki/Klafter).
> S: And there was a funny and stupid test about [The Egg of Cuculus Canorus in Biometrika]/(https://www.jstor.org/stable/2331619) or so. 

1. I was wondering about the order of the p-test execution. Section 9.1 indicates that the p-value gets computed as the third step and afterward interpreted. The text however does not mention when a threshold for the p-value gets actually selected. From my point of view, this should definitely happen before the test is run to ensure an unbiased experiment. When would you actually choose the p-value? The precision is always dependent on the accuracy of the model so is the reference p-value usually based on that model or general standards?
> This is a philosophical difference and an old academic fight, see e.g. the [Fisher vs. Neyman & Pearson framework](https://stats.stackexchange.com/questions/23142/when-to-use-fisher-and-neyman-pearson-framework). 
> That is a good point. And I'm wondering the same. But how I see things now, you don't need to pick a reference p-value to run your statistical test. It means that once you run the test, you get your p-value, and at that point one need to interpret it based on the question. If an obviously great difference in gene expression between 2 populations is expected, one should not be satisfied with a p-value of 0.1... But if a really small difference in gene expression is detectable in the data, a p-value of 0.1 could actually confirm that it does not come by chance.   
> In that sense, I think one should not set a threshold before running the test. 
> > Maybe it was not mentioned because it is not a hard threshold, but rather the user sets it case by case. When you compute a p-value for a specific case, you are asking "how likely would [this observation] be, if [H0] were to be true?". In the pregnancy example that would be "how likely would I see [a difference in pregnancy duration as big as the one we have observed comparing the two groups], if [treatment had no effect]?". The p-value answers the question and it is computed from the specific sampled mean and standard deviation. say that for example we calculated p = 0.07. That would mean that I would see a [difference in pregnancy duration as big as the one we have observed comparing the two groups] in 7% of the cases.    
> > That's quite often. Often enough that we cannot reject the null hypothesis. We cannot say that the treatment affects pregnancy duration. 
Now the question comes, how rare must an event be to contradict the H0 (and thus prove that treatment has an effect)? Convention says 5%, and that's why you'd see researchers doing their best to get p below 0.05 (questionable practice also called p-hacking). The author questions this practice too, as 5% is still quite often. To veer on the safe side, he advises us to consider only p-values below 1% to show strong enough evidence to reject the H0.  
> > To address your last point then, each question gives you the specific conditions with which you can calculate the specific p-value. Assessing if its low enough depends on you: if you adhere to the convention, you'll be happy with anything below 5%. If you want to be safe and ensure your treatment/correlation is actually significant, you'll look for something below 1%. In certain cases (eg GWAS), only extremely small p-values (10^-4) make sense.
> > > In R you would have information if the p-value is significant for the following levels 0.1, .05, .01, and .001. with some symbol.  But you are right you have to interpret the findings which is the hardest part.

### Permutation tests

1. What is the logic behind modeling the null hypothesis by permutation? Why do we combine all samples and treat them as one big group instead of two groups? (Regarding chapter 9.3)
> Because one defined previously (as the second step described in the book) that the null hypothesis is that all samples come from distributions with the same mean.  If this is true, you would be able to combine the two groups, shuffle them and and group again (= 1 permutation) and still expect a similar effect.  
> Simulating a situation where this null hypothesis is true (the book makes 1000 iterations/permutations of the H0 simulation), one can count how often you observed a similar or greater effect (i.e., differences in means of two groups as big as those between your initial groups). If this is so rare (<5%) of the time then they are by convention statistically significant.
1. In 9.2 chapter example, was the simulation used as a control for the hypothesis testing?
> The simulation is used to generate a sampling distribution.
### Normal distributions
1. In biology, the p-value is almost always derived from statistics that apply a normal distribution in a group of samples. If there is no apparent normal distribution, how do you calculate the p-value? Or are other statistics applied then?  
This is a more general question and does not refer to any chapter in specific, on the Wikipedia page of p-value they constantly refer to an assumed normal distribution, hence the question.
> S: There is rule, the  *central limit theorem*. If you have a given number of samples like n>30 you can expect that you have a normal distribution and also a good criterion is are your box-plots look symmetric (from my German stat. script).   
> Permutation tests don't assume a normal distribution, so they can be applied almost anywhere. Often you can derive how the distributions "should" be distributed.

1. The examples regarding the sampling distribution in both the video and in chapter 8.3 used normal distributions. Are normal distributions most often used or are there times when we use other distributions?
> It depends on different situations and a chosen distribution should be better to validate the hypothesis of your samples. For example, I think the normal distribution is more suitable for samples with real random variables like people’s height or weight. Most of those values are around the mean of the population value. By contrast, if we run a nucleotide chain alignment, this is correlated to the probability that a sequence will randomly match a longer sequence a specific number of times, which is actually matched to Poisson distributions. In this case, the nucleotide at one position could be only A, T, G, or C and each value is discrete. Normal distribution are bad approximations for such cases.

1. In the book and the slides, the distributions samples follow often seem to be a normal distribution. I have always wondered about how you figure out which distribution samples follow. Do you make an estimation in advance based on prior knowledge? Do you have to recognise the shape of the plot when plotting data? Or is there another method?
> The [central limit theory](https://en.wikipedia.org/wiki/Central_limit_theorem) the sum of multiple random variables tends toward a normal distribution. 
Therefore, physical quantities that are expected to be the sum of many independent processes, such as measurement errors, often have distributions that are nearly normal.

### One vs. Two-tailed tests.
1. Why does the one-tailed method of p-value provide more statistical power than the two-tailed method?
> For a two-tailed method the significance level is split to both sides. The one-sided test, on the other hand, focuses all the significance to one side making it twice as strong. Therefore, fewer subjects are needed in order to gain the same significance as for a two-sided method.
> > So how are we choosing between one-sided or two-sided methods for p-value? From the book, it is hard to understand. Is it: one-sided = only 1 seems to be used only when one specific parameter is affecting the difference between 2 populations & 2-sided = when a difference in 2 populations is affected by 2 extreme opposite actions. Is that correct?
> > > Not really. You use a one sided test when you are only interested in the significance of an effect in one direction. E.g. the significance of drug A to be more efficient that drug B.

1. What is the difference between one tailed vs two tailed method of p-value, and what is the difference in their applications?
> Two tailed p-value will only look at if there is a difference between two samples, without considering if one group specifically has a higher or lower value of the property analysed compared to the other sample. A one tailed p-value will look specifically at one type of diffrence, for example if the one sample you think will have a significant higher value compared to the other sample. An example would be gene expression where you could simply look at if there is a difference in gene expression between two samples, using a two tailed test. Or you could decide to look at if one of the samples is specifically over expressed, using a one tailed test. In Think Stats they use the example of analysing if first babies are likely to be late, using a one tailed test as compared to only analysing if there would be a difference in pregnancy length between first babies and other. 

1. Would it make sense always to use one-sided p-value and perform the test for both hypotheses (i.e. The other sample has a lower/higher test statistic than the control)? 
From a two-sided p-value you can tell if there is a difference but not if it is higher or lower if I understood correctly. Furthermore, the one-sided p-value is more specific, i.e., you get a smaller p-value and can make a more significant statement.
> That has some problems associated with multiple testing, which we will discuss next lecture.

### Significance testing

1. When studying sampling error and basing this on a distribution taking your sample mean as mu and assuming the sample standard deviation to be the standard deviation of the underlying distribution, isn't there a chance that your sample is very unrepresentative of the population and that the sample mean is a bad approximation for the actual mu for example? If so, will this impact your estimations of the sampling error or is this unaffected by which mu and standard deviation you use for the simulations?
> This is the good description of why we do significance testing in the first place, i.e. we want to determine how representative an observed difference is for the actual difference in populations (if any).
1. Considering that the chi-squared statistic does not give an indication of the significance of difference, but merely demonstrates that there is one, what is the reason that preference is given to the use of this statistic over p-values in some occasions?
> Chi-squared tests give p-values, so there is no good reason to report the test statistic itself.   
> It is possible to attach a p-value to the outcome of a Chi-square test using a Chi-square distribution table. The p-value depends on the degrees of freedom in the Chi test as well as the sample's Chi-square. E.g. if you decide on a significance level of p = 0.05 and you have 2 degrees of freedom, the sample's Chi-square needs to be at least ~6 to be considered significant. [Link](https://www.scribbr.com/statistics/chi-square-distribution-table/)

### Confidence intervals

1. In Chapter 8.3, the author mentions:"People often think that there is a 90% probability that the actual parameter, µ, falls in the 90% confidence interval. Sadly, that is not true." I don't quite understand why this statement is not correct. Is it wrong because we can not say "90% probability" since the given actual parameter µ is fixed, so it can only either fall in the confidence interval or not fall in, or there are some other reasons that make this statement not true?  
> I would agree with your idea that μ is fixed. It's fair to say there is 90% probability that the confidence interval contains the actual mean μ. It's logical to say our inference has certain probability to correctly suggest the unknown parameter, not the unknown parameter meets our inference.


### Standard deviation/error
1. In section 8.3 the author mentioned that one way to distinguish standard error from standard deviation is to increase the sample size: "as sample size increases, standard error gets smaller; standard deviation does not". What would be happened to the standard deviation as we increase the sample size? I'm confused because I thought that the standard deviation should also get smaller as the sample size increases. 
> The standard deviation is not affected by the sample size because it is derived from the variance which is "normalized" on the sample size (so not affected by it). Whereas the standard error is dependent on the sample size in its formula (because you divide the sample standard deviation by the square root of the sample size).

1. In 8.3 it is mentioned that standard error and confidence interval are two common ways to summarize the sampling distribution, how are they related?
> In brief, one can use standard error to calculate confidence intervals:  
> Standard errors provide simple measures of uncertainty in a value and are often used because:  
> * in many cases, if the standard error of several individual quantities is known then the standard error can easily be calculated; 
> * when the probability distribution of the value is known, it can be used to calculate an exact confidence interval;
> * when the probability distribution is unknown, Chebyshev's or the Vysochanskiï-Petunin inequalities can be used to calculate a conservative confidence interval; and
> * as the sample size tends to infinity the central limit theorem guarantees that the sampling distribution of the mean is asymptotically normal.
[See wikipedia](https://en.wikipedia.org/wiki/Standard_error)

### Confidence levels
1. How is an appropriate significance threshold determined/selected for a specific situation?
> There is no clear rule that states how you should set a threshold. It's usually just by convention set to 0.05 (but can be set to i.e. 0.1, 0.025 and so on)  
For a single case, it is just conventionally set as 0.05
> I believe that in biology, it can also depend a bit on the topic and method of your research, and you can decide for yourself if you want to use a stricter or less strict requirement for significance. You can take knowledge about expected false positives rates for a certain experiment into account. For example, if a certain method is known to generate a lot of false positives, a stricter p-value might be appropriate.

1. How do we choose which confidence level percentage to use and what are the examples?
> Choosing the confidence level is subjective and up to the one that is doing the hypotheses testing. It all boils down to what level of confidence you want in the hypotheses. One of the most common ones is having a 95%.

### Correlation
1. In 9.5 the author states that "For the test statistic, I use Pearson’s correlation, but Spearman’s would work as well", how do you choose which correlation to use? Are there any advantages/disadvantages of choosing one over the other? 
> Chapter 7.3 goes through correlation, and the two methods you mentioned in 7.5 (Pearson's correlation), and 7.7 (Spearman's rank correlation). Both methods are easy to use. Rank correlation is less sensitive to non linear distributions and outliers. At the end of 7.5 shows examples where there clearly is some kind of correlation, but Pearson's method can not differentiate those from actual non-correlating ones. 
> Here is an easy understood [comparison between the two.](https://econometricstutors.com/pearson-and-spearman-correlations/)

### Multiple Hypothesis 
1. In bioinformatics, it is not uncommon to use an adjusted p-value. How is it different from the regular p-value? What's its formula?
> We will discuss this in next lecture. 

### Significance
1. At the end of chapter 9.5, it says " [...] that “statistically significant” does not always  mean that an effect is important, or significant in practice. It only means that it is unlikely to have occurred by chance." 
> An out-dated example that statistician like to use is that the income in New York is higher than the ones in Chicago with a p-value of $10^{-10}$, but that difference is $1. 
