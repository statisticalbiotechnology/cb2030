# Questions and Answers to Supervised Learning.

1. At the end of the video lecture, the last thing you say is that everything above a ROC score of 0.5 would be seen as a good predictor. Intuitevely this feels as a low requirement for implementation of predictors, therefore I am wondering if this is true? Do you use predictors with a ROC score of example 0.6 in clinics? If yes, why is the ROC score allowed to be so close to random (0.5)?
> No, you are right. A ROC score of 0.51 will often not be very valuable. I meant to say that a ROC score > 0.5 is a score that is better than a random prediction. Also, this is somewhat dependent on the research question. Sometimes one accept predictors with very low ROC score as other information is unavailable.

1. Except squaring the expression value, what are other types of dimensions that can be used when adding kernel functions?
> Yes there are several different available kernels. Perhaps the most well known kernel is the [RBF Kernel](https://en.wikipedia.org/wiki/Radial_basis_function_kernel)

1. In the VaderPlas article when using the radial basis function as kernel function in Scikit-Learn to fit the non-linear data, 7 points are marked as support vectors. What does the number of support vectors depend on and why did it increase from 3 to 7 when going from 2D to 3D (or did it project on a higher dimension than 3)?
1. Will three support vectors always be enough to uniquely define a maximum margin separating hyperplane, or will the number depend on the dimensions of the data?
  > It will be dependent on the shape of the data, but tends to increase with the dimensionality of the data and slack penalty. See e.g. this [stack exchange post](https://stackoverflow.com/questions/9480605/what-is-the-relation-between-the-number-of-support-vectors-and-training-data-and). The minimum number of support vectors needed, tend to be independent on the number of [dimensions of the data](https://stats.stackexchange.com/a/310749)

1. In the article by Noble it is said that "kernels can be defined on inputs that are not vectors", what is meant by this?
> A well known case in bioinformatics are so called [string kernels](https://en.wikipedia.org/wiki/String_kernel), that evaluates similarities of text or amino acid strings. Another examples in phylogeny, is [tree kernels](https://en.wikipedia.org/wiki/Tree_kernel)

1. Would it be possible to walk through the last code chunk of the jupyter notebook in a bit more detail? I find it a bit difficult to understand what is hapenning.
  > Could you help me by pinpoint where it gets challenging?

1. In the Jupyter notebook you mention that in cross validation you train different classifiers and combine their results. How does this work for nested cross-validation, what different things are you training within each classifier? Choosing hyperparameters is mentioned as an application, so is it to use different sets of the data to find different optimizations of the parameters and then merge those?
> Often one use nested cross validation to select suitable hyperparameters, and then one use the optimal hyperparameters to train a regular cross validation net. That way the best hyper parameters are found for each cross valiadatuion set indpendently.

1. On slide 12 in the video lecture, sensitivity and TPR are the same thing (which is true according to Wikipedia), why are they given separately?
   > For no ther reason than that I wanted the apprivaiations and the named metrics as separate metrics.

1. I understand that choosing kernel function is based on trial and error but is  there any trick or practical method to select the right kernel? And how do you know that the selected kernel is right? Is it right when it can sufficiently separate different conditions through transformation non-linear to linear problem?
   > Sometimes one can select kernels that makes sense based on what makes sense for the problem. In the example at slide 7, we would perhaps know that an absolute value was more suitable for classification, and would hence select a quadratic kernel.

1. The idea behind the cross validation is to save money by dividing the available data into cross-validation bins (this idea is even further expanded for nested cross validation). If however, the amount of data is very limited in the first place, does it really make sense to sub-divide the given data into even smaller packages and risk inaccurate outcomes?
  > No, the bearing idea is that we avoid overfitting, or at least are able to detect situations where we overfitt, by using cross validation.

1. What is a suitable ratio of data points in a training set to data points in a testing set? How are the data points for the different sets chosen from the data?
  > There is no rule. I often use 70/30.

1. How significant is the difference in accuracy when combining cross validation with nested cross validation vs no combination?
  > It depends on the problem, however, the idea is that we want to detect situations where we overfitt.

1. Is there any reason to not combine with nested cross validation apart from computional performance requirements?
  > To some extent there is a withhold of data when you cross validate. Also, it is easier to extend your prediction for new datapoints. I.e. which of your *k* trained predictors from *k* fold cross validation should you use when you encounter a new example.

1. Since it is common for data analysis to aim to reduce the complexity and dimensionality of the data, are there negative consequences of introducing higher dimensionality (other than increased computational requirements) to use kernels in combination with SVM?
  > Yes, [there indeed are](https://en.wikipedia.org/wiki/Curse_of_dimensionality). Your finite number of data points will spread wery thin in a high-dimensional feature space. This is true for any machine learning problem.

1. Why is it an advantage that very distant points don't affect the fitting of a SVM  boundary line?
  > Such data points are normally obvious, and might not to effect the classifier descission.

1. Regarding the 3-fold cross-validation: if three different learners are created, do we choose the one with best performance as the final classifier or is the final classifier a combination between the three?
   > There are different strategies for this. Often a final classifier is trained based on all data. However , such a classifier should not be used for reporting performance.

1. Can you give an example that how to cross validate a model? it seems you only take a re-sampling, what the function of test samples here?
   > The notebook provide such an example.

1. Can you explain the function of hinge loss? why use yi times wx-b?   
  > Here is wikipedia's entry on the [subject](https://en.wikipedia.org/wiki/Hinge_loss). However, that is not what I think you wonder about. *y_i(wx_i-b)* only makes sense as *y* is either -1 or 1, and you try to make *wx_i-b* take values >1 or <-1 depending on y.
