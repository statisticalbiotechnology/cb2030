## Usage of FDR
1. "In light of the definition of the false positive rate, a p-value cutoff says little about the content of the features actually called significant. The q values directly provide a meaningful measure among the features called significant."
  I am not sure I understand this. Is it because of the FDR = FP/(FP+TP) taking all significant features into account while the FPR = FP/(FP+TN) instead include the True negatives?
  > A FDR of 5% means that your findings is expected to contain 5% FPs. A FPR of 5% on the other hand just means that 5% of all null statistics is included in your findings. So a FPR will mean different things for different experiments, while the FDR is a direct statement about your findings. 

1. When we speak about false discovery rate as the method of looking at the rate of occurrence of false positives when doing multiple comparisons , is it that we measure say 'n' number of false positives occurring for every 'm' number of comparisons? Or we have the average of number of false positives for each comparison?

1. In the article it says that "The q value provides a measure of each feature’s significance, automatically taking into account the fact that thousands are simultaneously being tested". Is it that it compares the various features being measured and states how significant is a gene or feature when compared to the other genes or features in consideration?

1. The usage of q-value seems to offer a more "true" result than just using the classical p-value definition. I feel like the pros of using a q-value is described. However, are there any cons, or rather anything we must consider, when using the q-value?

1. Is it common that published genomwide studies use q values instead of p values today? Is there any resistance against switching to q values or is it just a matter of ignorance?

1. Is there any specific case that q-value is more convenient to use than p-value or it can be applied for every statistical test?

1. In the context of genomics, is there any case in which it is better to express the significance in terms of the false positive rate rather than false discovery rate?

1. Are q-values better than p-values only when many different features are analysed at the same time, or is it always more accurate?

1. FDR is number of null hypothesis expected above threshold. However, how do we predict the number of expect null hypothesis that would be above threshold for a completely new and unknown data set or data set generated using relatively new techniques (Something that is never studied before and we do not have an idea of the expected rate of error)?

1. Can  q-value provide biological meaningful data, while rejecting hypothesis? What are the limitations of q values statistics? At what cases q value statistics is applicable?  At what cases p-value is preferable over q-value? Will the q-values still  be accurate if it is applied to enormously big sample size?

1. Could the choice of statistical method also depend on what kind of feature is being investigated or is it only the number of features that are of interest?

1. In the article it is mentioned that the Bonferroni correction (controlling the familywise error rate) is too conservative when many true positives can be expected, but it still seems to be used in many studies. Are there any additional advantages or practical considerations underlying this, or could one equally well use a FDR approach in such cases?

1. Are p-values and q-values used exclusively in publications? P-values can be used to assess scientific literature, while q-values is dependent on pi0 which seems to be estimated by the one conducting the study which increases risk of bias.

## *q* value treshholds
1. Also, how is the q-value threshold chosen? (The article mentioned choosing what's practical for subsequent verification, are there other criteria?)


## Estimation of FDR
1. Can you explain in more detail what the q value is, I didn't understand the explanation in the video
1. I didn't really understand how m0 was estimated mathematically using the p-value distribution and would like to have it explained a bit more.
1. The false discovery rate can be defined as the number of null hypotheses divided by the total number of hypotheses above the score threshold. Is the “number of null hypotheses” equivalent to the number of “false positive features” because we refer to a certain threshold t or is there another reason?
1. Why are the p-values distributed the way they are presented? Shouldnt H0 be non-existent at a p-value of 0, and also the distribution of H1 is quite confusing, we usually dont have a high frequency of low p-values (We would love to have that so)?!
Or in other words? How and why do we get this distribution of p-values?
  > The uniformity of p-values under H0 is something we discussed in the previous seminar. It comes down to that the null *p* values are uniform just the same way that a sample from any distribution, when subject to its own CDF, would render a uniform distribution between [0,1].  
  > See e.g. [this stack exchange entry](https://stats.stackexchange.com/a/11288)
2. What is the meaning of the FDR = E [F/S], why is it not simply FDR = F/S?
> The [expectation value](http://mathworld.wolfram.com/ExpectationValue.html) of any random variable gives a sense of how the variable will behave "on avarage".

3. What does "null p<sub>i</sub> <= t" compared to "p<sub>i</sub><=t" mean?
  > "#{null p<sub>i</sub> <=t}" counts the number of  *p* values under t that were generted under the null hypothesis, while "#{p<sub>i</sub> <=t}"  counts all the *p* values under t.
4. I understand that pi is an estimated parameter due to the lack of information on TP and FP, but what is lambda?
  > Depending on which treshold &lambda; we place ourselves we get different estimates of &pi;<sub>0</sub>. The point the article makes is that if you select lambda too low, you will getr a too high estimate of  &pi;<sub>0</sub>, if you place yourself too high, there will be too much variabilityin the estimate. Hence the authors use a spline to fit their data.   
5. The last step (calculation of q<sub>i</sub>) is done computational considering all tresholds? Does this lead to an mathematical underestimation of FDR by picking the best t-values?
  > In sort of a way yes, however, this is intrinsic to the definition of a *q* value.


# From FDR to *q* value.
1. The q value is calculated by taking the minima of the FDR. Wouldn't this mean that the actual FDR could be higher than what we are reporting using q value. Why take minima and why not maxima when calculating q value? Further, how is the range for x' selected to calculate min(FDR)?  
  In the example in video, the FDR ranges from 0.15 to 0.2 for the score range of 6.5 to 7, but when reporting q/FDR it reports the minima i.e. only 0.15, missing out to show that the FDR in the range of 6.5 to 7 could be as high as 0.2. Why is this not a problem when handling data sets with large variability?

## &pi;<sub>0</sub> estimation

1. What is the relation of the threshold (lamda) to &pi;<sub>0</sub> as a function?  How do you find the ideal treshold?
1. When the &pi;<sub>0</sub>(&lambda;) was plotted against &lambda; in the article, Storey and Tibshirani fitted a natural cubic spline with  degrees of freedom limited to 3 to the data, stating that this suited their purposes.  Will this always be the proper way to do it, or does this have to be evaluated on case-by-case basis?
  > The procedure is frequently used. However, it should be noted that I in my notebook use a differnt procedure for &pi;<sub>0</sub> estimation than the one described in Storey&Tibshirani.
