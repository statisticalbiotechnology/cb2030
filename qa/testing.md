# Question and answers -- Hypothesis Testing

Here we store selected questions and answers from previous years incarnations of the course.

## Definition of *p* value

* Q: What is the relation between a *p* value and a probability.
> A: A *p* value **is a** probability. Specifically, it is the probability that an outcome as extreme or more extreme than the one encountered given the null hypthesis being true.

* Q: Until now, if someone would have asked me: "What is *p* value?" I would have answered that "it is the probability of the observed difference between the two populations to be due to chance". However, I did not find this definition in the reading material. Would this definition be wrong?
> A: Yes, your definition is problematic.  
> 1. In testing, we observe samples not populations. The hypotheses, however, are statement about populations.  
> 2. The definition of "due" is vague. Do you mean given the observed difference what is the probability that the observations happened by chance? Or do you mean the probability of the difference and that the outcome happened by chance?  

* Q: Why is the *p* value is uniformly distributed when the null hypothesis is true?
  > A: The uniformity follows from the definition of a *p* value. If Xobs is generated under H<sub>0</sub>, the probability Pr(&Delta;X>=&Delta;X<sub>obs</sub>\|H<sub>0</sub>) is just Pr(&Delta;X>=&Delta;X<sub>obs</sub>), i.e. a [Cumulative distribution function](https://en.wikipedia.org/wiki/Cumulative_distribution_function). The null p values are uniform just the same way that a sample from any distribution, when subject to its own CDF, would render a uniform distribution between [0,1].
  > See e.g. [this stack exchange entry](https://stats.stackexchange.com/a/11288)

* Q: The [Wikipedia entry](https://en.wikipedia.org/wiki/P-value) for *p* value talks about representing the data using the random variable X and using conditional probability to define the statistical significance. However, it states that X is valid only in non-continuous data sets and the simple definition needs to be modified in order to accommodate the continuous data sets.

  What are examples of both the continuous and non-continuous data sets and how does the definition change when it comes to continuous data sets? Further, if we talk about having a normal distribution of the data then doesn't that itself constitute a continuous data set?
  > Non-continuous data can only assume discrete values and you can depict them like clearly separated dots. For instance age (in years) is a type of non-continuous distribution.  
  >  
  > As opposite, continuous data can assume every possible values within a limited or unlimited range: it means that the possible values are infinite and you can always have one more value between other two. For instance height is a type of continuous data.  
  >  
  > So you see that in a non-continuous distribution you can have a certain probability for X to assume a specific value, because the possible values are "limited": you can, for instance, count the number of persons having a certain age. On the other hand, in a continuous distribution the probability for X to assume one specific value is one over infinite (=0): what is the probability for a person to be 173.67809223... cm tall? The only thing you can define is the probability for that person to be, for instance, taller/shorter than 173 cm or to be between 173.0 and 173.5 cm.


## Significance levels

* Q: When you pick a value for your significance level, what should your approach be? How do you know which value is most suitable for your hypothesis? Why are 0,05 and 0,01 the most common ones?  
  > There is no real reason other than convention.

## One- vs two-sided tests

Q: When to use one-tailed *p* value and when two-tailed *p* value?  
  > For instance if you are interested in the differential expression between two samples, you usually want to know only when a gene is expressed at different levels, without considering whether it is over-expressed or under-expressed. In this example the significant  "over-expression outcomes" (i.e. when the average difference is positive) would fall in the extreme right of the distribution, while the significant "under-expression outcomes" (i.e. when the average difference is negative) would fall in the extreme left of the distribution. Since you're interested in both the types of outcomes, you collectively consider them using the two-sided *p* value. If you, for some reason only are interested in testing under or over-expression, you are free to use the more sensitive one-sided *p* value.
  > Here is a  [wikipedia](https://en.wikipedia.org/wiki/One-_and_two-tailed_tests) entry on the topic.

## *p* value hacking

* Q: Like other statistical based sciences, biology is struggling with *p* hacking and a replicate crisis. How is *p* hacking performed (just out of curiosity) and how can it be revealed and identified?  
> A: This cartoon (and it's explanation) explores the problem:  [XKCD](https://www.explainxkcd.com/wiki/index.php/882:_Significant), we will explore this topic further in the lecture on Multiple hypothesis testing.

## Null hypothesis (*H<sub>0</sub>*)

* Q: Why do we need null hypothesis, why cannot analysis whether or not the data fit the alternative hypothesis directly? If we calculate P(data\|H1), and compared with significance level, can we get result to reject H1 or fail to reject H1?
> A: The problem is that we know very little of H1. Under a typical H1 the difference in mean can take any value except for zero. This is why one one at least historically could not model probilities related to H1. H0 on the other hand, asumes a fix value of the difference in mean, e.g. 0, which enables us to estimate the distribution of measurement errors around that value.
