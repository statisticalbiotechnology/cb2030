# Questions and Answers to Multiple Hypothesis Testing.


## Hypothesis testing
1. By using FDR, we reduces false positive, but a number of true positive is lost simultaneously. Is there any solution for this?
  > A: No. That is the point of the whole point of significance testing. Regardless how you select your threshold, there will be errors. The question is just if you prefer errors of one kind (FP) over the other (FN).

## Relationship of FDR to other ways to report errors.

11. In the article it is mentioned that the Bonferroni correction (controlling the familywise error rate) is too conservative when many true positives can be expected, but it still seems to be used in many studies. Are there any additional advantages or practical considerations underlying this, or could one equally well use a FDR approach in such cases?  
  > A [Bonferroni correction](https://en.wikipedia.org/wiki/Bonferroni_correction) is a way to control for the family-wise error rate (FWER), i.e. what is the probability that at least one of your significant features is generated under H<sub>0</sub>. One good reason for calculating Bonnferroni corrections are that they are very simple to calculate.  


## Usage of FDRs and *q* values

1. When we speak about false discovery rate as the method of looking at the rate of occurrence of false positives when doing multiple comparisons , is it that we measure say 'n' number of false positives occurring for every 'm' number of comparisons? Or we have the average of number of false positives for each comparison?
  > It is a statement of the set of findings we report from an experiment. If we expect 5% of our reported findings to be incorrect, we report a FDR of 5%.

1. In the article it says that "The q value provides a measure of each feature’s significance, automatically taking into account the fact that thousands are simultaneously being tested". Is it that it compares the various features being measured and states how significant is a gene or feature when compared to the other genes or features in consideration?
  > No, each feature is tested individually. However, we want to make an assesment of the errors of the features we called significant.

1. In the context of genomics, is there any case in which it is better to express the significance in terms of the false positive rate rather than false discovery rate?
  > Sure, anytime you are interested in what fraction of all FPs in your experiment that is called significant, an FPR should be used.


## Usage of *q* values/FDR in literature.
1. How is the q-value threshold chosen? (The article mentioned choosing what's practical for subsequent verification, are there other criteria?)
 > There is no rule. However, frequently tresholds of 1% or 5% are used.
1. Are *q* values better than *p* values only when many different features are analysed at the same time, or is it always more accurate?
  > Whenever multiple tests are involved, most journals require you to report FDR/*p* values. However, whenever you have measurements on one indidual substance that you were interested prior to the experiment, you can report *p* values.   



## Estimation of FDR
1. How is m0 estimated from the *p* value distribution?
  > Overall there are *m* features in your assay. Each one of these has a prior probability of &pi;<sub>0</sub> of being null. Hence you can estimate *m<sub>0</sub> = m&pi;<sub>0</sub>* null features.

1. I don't understand the description of the Benjamin-Hochberg FDR calculation as "too conservative". I understand the math behind it, but I cannot grasp it from a conceptual point of view: if &pi;<sub>0</sub> is assumed to be equal to 1, wouldn't that mean that all the features that are considered significant are null?
  > If you do not take any equation in consideration you are right. Your confusion arises when we estimate the number of errors under threshold *F(t) = m<sub>0</sub>t*. This estimation can be done as  *m<sub>0</sub> = m&pi;<sub>0</sub>*, or we can conservatively approxiamte *F(t) &asymp;  mt*. The &pi;<sub>0</sub> = 1 estimate is conservative, as it assumes a larger number of errors than really are present.

1. The false discovery rate can be defined as the number of null hypotheses divided by the total number of hypotheses above the score threshold. Is the “number of null hypotheses” equivalent to the number of “false positive features” because we refer to a certain threshold *t* or is there another reason?
> Yes this is an accurate description. Features are null or not, however the distinction between a TN and a FP is a treshold.

2. What is the meaning of the FDR = E [F/S], why is it not simply FDR = F/S?
> The [expectation value](http://mathworld.wolfram.com/ExpectationValue.html) of any random variable gives a sense of how the variable will behave "on avarage".

3. What does "null p<sub>i</sub> <= t" compared to "p<sub>i</sub><=t" mean?
  > "#{null p<sub>i</sub> <=t}" counts the number of  *p* values under t that were generted under the null hypothesis, while "#{p<sub>i</sub> <=t}"  counts all the *p* values under t.


## From FDR to *q* value.
1. The *q* value is calculated by taking the minimal FDR of any set including the current *p* value. Wouldn't this mean that the actual FDR could be higher than what we are reporting using a *q* value.
 > It means that it exist a treshold that defines a set with a FDR=q that includes the current *p* value. The maximal FDR of any set containg the current *p* value would allways be &pi;<sub>0</sub>.
1. In the example in video, the FDR ranges from 0.15 to 0.2 for the score range of 6.5 to 7, but when reporting q/FDR it reports the minima i.e. only 0.15, missing out to show that the FDR in the range of 6.5 to 7 could be as high as 0.2. Why is this not a problem when handling data sets with large variability?
  > Well it is a problem. However, for large datasets, we do not see much variability in this. The case I show in the video is an exadjerated example to demonstrate why the procedure is needed.

1. Why are the  *q* values are semi-[monotonically](https://en.wikipedia.org/wiki/Monotonic_function) increasing with *p* value, and why is this important?
  > We smooth the FDRs into *q* values by defining a feature's *q* value to be the minimal FDR of any treshold that includes the feature. The procedure is important as we otherwise would not be able to allocate a FDR treshhold to a particular feature (, as there will be multiple such FDRs).

## &pi;<sub>0</sub> estimation

1. When the &pi;<sub>0</sub>(&lambda;) was plotted against &lambda; in the article, Storey and Tibshirani fitted a natural cubic spline with  degrees of freedom limited to 3 to the data, stating that this suited their purposes.  Will this always be the proper way to do it, or does this have to be evaluated on case-by-case basis?
  > The spline procedure is frequently used. However, it should be noted that I in my notebook use a differnt procedure for &pi;<sub>0</sub> estimation than the one described in Storey&Tibshirani. In my eyes, the bootstrap method gives more stable estimates.
