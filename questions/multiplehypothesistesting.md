# Questions and Answers to Multiple Hypothesis Testing.

### General questions

1. For a genomewide study would you then calculate both the p value and the q value? Or would it be unnecessary to calculate/show the p value? In the article it says that both values should be included but I do not really understand why.
> q-values are derived from p-values, so you normally calculate both.

1. As stated in the article, with large data false positives still occurs with low p-values. Therefore they developed this method using FDR and q-values. Can this new method improve for smaller sets of data too? 
> There is always going to be a risk that there are false positives, no matter the size of the data set. However, the larger the data set, the higher the risk. The FDR and q-values are always useful when multiple features are analyzed due to it reflecting on the hypotheses that are alternative/significant features.

0:188 Nov at 0:18

### Sensitivity vs. selectivity

1. In "Remark D: Theoretical Properties" from the article it was stated that one shouldn't underestimate both p-values and q-values. What is the signifiance of this in real life applications?
> It hust means that it in general is better to make conservative than anti-conservative estimates.

1. In the video (~7 min histogram) when selecting a threshold for the p-value when would you choose to lower the p-value threshold to get fewer true positives/false positives compared to having a higher threshold and get more true positives/false positives and vice versa? Is it, for example, more favorable to have fewer false positives than more true positives? 
> This is something you always need to consider. Decreasing the p value threshold leads to more false negatives, and increasing leads to more false positives. For each application, one might be more favourable than the other. There are no specific guidelines for this, and you always need to make this consideration for yourself.

1. It is unclear how the value of the thresholds is decided. Do you have to look at what kind of test you are conducting and how big of an 'error' you allow within your results or is there some kind of rule for it?  I was also wondering if you have to take the false negatives into account for setting the threshold or if we are only interested in the false positives.
> Yes, you have to make a choice between accepting either false positives or false negatives.    
> The value of thresholds are arbitrarily defined, which is a rather conventional thing as we define the p-value to be significant. If I understand correctly, the cutt-off here, denoted by t, is the same p-value that we think it is significant below this value. So basically we use the same cut-off (threshold) to calculate p-value and q-value.    
> For the false negative, I don't think we are interested in it, at least for this method. Because true positives and false negatives are in seperate zone of the p-value frequency plot, where true positives are at the left-hand side of the cutoff, and false negatives are in the reverse. In this method, we approximate p-value distribution on the right-hand side of the cut-off as a uniform distribution, and I think in this way we are mixing false negatives and true negatives. But I have a feeling that there will be a method to focus on true negatives and false negatives, maybe it can be false rejection rate or something else (joke).



### pi_0 estimates

1. It is still quite unclear to me how to set a good threshold for lambda when estimating . As I understand you plot a histogram of the p-values and then choose a cut-off point where the curve starts to flatten. Is that correct? What assumptions do we make to say that this can be a suitable estimation for ?
> The lambda value is set based on the data itself. The article describes an automated way to select the lambda value, where they fit a natural cubic spline and plot 𝜋̂0(𝜆) versus λ, then choose the value where  𝜋̂0(𝜆=1). Having a λ that is too high will result in high variance, while a low λ is too conservative. The objective in tuning this parameter is to find a balance.  
> > I still have a hard time understanding how a high lambda threshold becomes too unreliable. I can see it in the formula to calculate π0, where m(1-λ) is in the denominator, and therefore closer to 1 means higher π0. But I don't understand it from a more conceptual point of view. If the p is uniformly distributed, then λ being higher would mean a better estimate of the overall uniform distribution of the truly null p values, since it has less probability of including  truly alternative features the higher you go. And since it is uniformly distributed, I would have understood it as if a higher λ would only give you a more secure estimate of m0. I don't understand how this relationship of higher λ returning a more unreliable q value.
> > > Any estimate based on many datapoints will be have lower estimation errors than one made from only few points. Hence we want to include as many datapoints as possible with using a low lambda, however, we also want as high lambda as possible to include more data points.

1. In the slides, it it shown that when you want to determine the Pi0 value, H1 decreases when you increases the value on the x-axis. However, H0 is not affected by increasing the x-axis value. My questions are: 1) what exactly is the value on the x-axis? 2) Why is H1 affected by increasing this value, but not H0?
> 1) p-values are on the x-axis, ranging from 0 to 1. 
> 2) The p-values are evenly distributed under the null hypotheses. However, this is not the case for the alternative hypothesis. For low p-values the number of alternative hypotheses is higher than for larger p-values.   

1. In the article, they write "If we take λ=0, then 𝜋0(λ)=1, which is usually going to be much too conservative in genomewide data sets, where a sizable proportion of features are expected to be truly alternative." Isn't this always too conservative or are there situations when you can set  λ=0 and use 𝜋0(λ)=1? If so, what situations and why?
> Yes, pi_0=1 is conservative in all cases except for if you belive that all your findings are incorrect, which makes the rest of the analysis uninteresting. The lambda parameter is just a help variable we use to derive the pi_0.

### Applications of FDRs

1. I feel very confused about the application of q-value in the genomewide data set. It says that 'one may use the q-values as an exploratory guide for which features to investigate further.' In my mind, it gives me feeling that it can be used to distinguish the significant genes with different expressions which really contribute to the development of cancer (for example) from the genes which show significant expression changes but do not interfere with the cancer development. In other words, the changes of these genes are only the results of other gene expression change, not participating in the tumorigenesis. Can we apply the q-value to help us to exclude those genes? 
> I think it can not be used to exclude those genes during experiment.
Because in multiple hypothesis testing, q value is used to control the positive false discovery rate and adjust the threshold to get more accurate results. 

1. In the article, they had an example of investigation in loci that spans over a large chunk of the genome, and because of that you perform individual tests for every locus you need very strict p value threshold (less than the "normal" thresholds) in order to avoid false positive rates. Why is it problematic to have very restricted p values?
> I think if you have a very strict p-value threshold you also increase the number of false negatives.

1. What are the drawbacks with using q-value as opposed to false discovery rate (FDR)?
> In my opinion there is no real drawback in using the q-value. It is meant to provide a significance score that increases monotonically with the p-value threshold whereas the FDR does not increase monotonically but has extremes. Therefore, the q-value can be more suitable for making clear statements on the significance.
> > Additionally, I think the units are different. I might be wrong, but I believe the FDR is a whole number, in contrast to the q value, which is a percentage or fraction.
> > > No, both enteties are floats between 0-1, however, such numbers are frequently are repported as percentages.

1. In the article, the authors speak about features and q-values of those features. It is still unclear to me if in that case feature is 1 single gene or a set of genes!?
> One feature is one hypothesis, i.e. one gene that is studied for significance. One feature/gene/hypothesis has one q-value that represents the least possible FDR, that is what is the probability of its significance.

### Other measures of error rates
1. What is the difference between the q-value and the FDR-adjusted p-value using Benjamini-Hochberg method? Can we use these terms interchangeably?
> "The more mathematical definition of the q value is the minimum FDR that can be attained when calling that feature significant (see Remark A in Appendix).   
> So not quite because you search for the minimum  of the FDR which is than your q value.  
> The B-H adjusted p-value gives an upper limit of the FDR, while a q-value is the minimal FDR of any threshold that includes the current p-value. Note that adjusted p-values are not a part of the course.

1. In the article they mention that the error measure that is typically controlled in genome scans for linkage is the family-wise error rate but they also mention that it is too conservative for many genome-wide studies. What is the difference between the family-wise error rate and FDR, and why is FDR better?
> The family-wise error rate (FWER) is the probability of making any type I error at all. Guarding against any single false positive may be too strict for genomewide studies, and can lead to many missed findings. False discovery rate (FDR) is the expected proportion of type I errors among the rejected hypotheses. FDR allows type I errors but controls how many of them you make in proportion to your true positives. FDR corrects by preventing as many false positives as possible while also preventing too many false negatives. FDR is better than FWER, as it has greater significant power.

1. The article stressed that q value is not the probability of a feature being a false positive as the q value accounts for the fact that decisions are made for m features simultaneously. What exactly is the difference between the two estimates and when would it be necessary to also estimate the probability of a feature being false positive?
> FDRs are used to isolate sets of features. If we are only interested in one single feature, we might want to calculate its posterior probability. This is known as posterior error probability (PEP) or local-FDR.



