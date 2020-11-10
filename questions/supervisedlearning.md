# Questions and Answers to Supervised Learning.

1. How can we find the right kernel? The Noble article mentions trial and error, is this the most common way to do it?
> Yes that is it. Trial and error is often the most frequent waty to select models and hyper-parameters in other types of ML.

1. How do you decide how many variables (genes in the jupyter notebook on the TCGA breast cancer set) to use to avoid over - and underfitting of the training data set?
> Again, trial and error is the most common method. You often to your feature selection on a separate dataset, to avoid overfitting. This said, [feature selection](https://en.wikipedia.org/wiki/Feature_selection) is a research topic of its own.

1. What must be taken into consideration when we choose the soft margin parameters?
> That your classifier should work well.

1. To perform multiclass classifications, Noble describes that: “the simplest approach is to train multiple, one-versus-all classifiers” (Noble, W. What is a support vector machine?. Nat Biotechnol 24, 1565–1567 (2006)). He mentions that there are a variety of methods to perform multiclass classifications which are more sophisticated. Could you elaborate on how these optimized SVM algorithms work?
> Here are some examples from [sklearn](https://scikit-learn.org/stable/modules/svm.html#multi-class-classification)

1. In cross-validation, how do we know how many bins to divide the data in, and later on how many bins to use for training / testing?
> Its a choice between speed and risk to not detect overfits. However, in practice a low number like 5 or 3 works well for many problems.

1. I understand that a consequence of too many dimensions, especially when the number of dimensions surpass the number of individuals in the training set, is making the algorithm overfit the data. Is there any recommended maximum limit for the number of dimensions based on the number of points in the dataset?
> No, it depends on the problem. A bit circular: You should include as many features as needed, but not more. There are some theory associated with the number of selected features like [Aike's Information Criteron](https://en.wikipedia.org/wiki/Akaike_information_criterion), however, it is nort always applicable.

1. I think I understood the SVM classification when it is explained based on as in the provided article on two genes/dimensions, but how does it work for all the 6817 genes? Like, is it possible to visualize how the hyperplane is generated when using so many variables?
> Not in a visual way. You have to use your imagination, or possibly use a [dimensionality reduction](https://en.wikipedia.org/wiki/Dimensionality_reduction) scheme to project your data to a 2d plot.

1. In the Python Data Science Handbook it is mentioned that SVM methods are computationally expensive when the training data set is large. In practice, how large can the training data set be before the method becomes so time-consuming that it makes sense to use simpler, faster methods first?
> I am currently working with datasets of 25 million datapoints. Given you can use not too advanced classification you can expand the number of datapoints pretty far.

1. In the case of having multiple genes, can the SVM algorithm be modified to weigh different genes differently? If differential expression in some genes might be more impactful for the classification, can this be taken into account in the SVM algorithm?
> Yes, this is the point of the SVM.

1. In Noble:
  1. It is mentioned in the end that the running time of the SVM scales quadratically. Is there any way to reduce or optimize this to make SVM algorithm faster?
  > Use a linear classifier?
  2. It is also mentioned that there are some fast approximation algorithms that scale almost linearly and perform nearly as well as the SVM. Could you elaborate a bit more about these algorithms?
  > Here is an example of one such implementation in [sklearn](https://scikit-learn.org/stable/modules/generated/sklearn.svm.LinearSVC.html)

1. When finding training data for creating a support vector machine it was stated in Noble that support vector machines have difficulties differentiating between data from samples taken with different methods. However if you would want to expand your available testing or training data how similar does your data need to be in order to not compromise the SVM.
> When designing a classifier, you need to make sure that your training data is representative for what you [actually want to classify](https://www.youtube.com/watch?v=t4DT3tQqgRM). SVMs are not very differnt in this than any other classifier.

1. In cross-validation, after the learners were trained and tested on the different sets, how is the resulting information combined again? Can I imagine it as each of the three learners fitting a set of parameters to the training data and if so, how is this information combined from the three learners afterwards?
> There is no fix scheme for this. However, [I normaly combine](https://link.springer.com/article/10.1186/1471-2105-13-S16-S3) the classifiers' test results based on their SVM score.

1. How does the kernel function go from a low dimension to a higher one?
> By introducing new dimensions. A nice example for this is the quandratic dimension in [Figure 1](https://www-nature-com.focus.lib.kth.se/articles/nbt1206-1565/figures/1)j

1. Could you give further examples of kernel functions than those described in "What is a Support Vector Machine?" Furthermore, are there "simple" data sets where it is impossible to employ kernel functions?
> [Wikipedia](https://en.wikipedia.org/wiki/Kernel_method) mentions a couple of kernels.

1. In the softening margins step, we should set up the proper parameter C to control the margin. But in jupyter notebooks, these C parameters are usually adjusted manually at 0.1, 10, or 0.0001, 1000. In a practical case, should this C parameter be confirmed empirically or are there any algorithms to help us decide the proper C?
> I normally set C with cross validation or nested cross validation, as shown in the notebook.

1. Can the quality of a training set be judged by looking at the predictive power the resulting trained algorithm has on the test set?  If not, how can you assert the quality of a training set - i.e. when is a training set sufficiently broad yet representative.
> You know that you have a good training set when you get good performance on a classifier trained on the set. However, if you get low performance, it could be an indication that the design of your classifier and not the training set is to blame.

1. I had some trouble understanding how cross-validation works and how it is performed, would you mind elaborating on this? Furthermore, it is mentioned in the text In-Depth: Support Vector Machines that cross-validation is used to choose a suitable softening parameter C, how is this done?
> Could you tell me where in the notebook you go astray?


1. Can the machine learning algorithm become better than the quality of the data? Say we have to label the data as positive or negative but we are only correct 90% of the time will this then also be true for the algorithm?  
> Yes, normally manually annotated labels are incorrectly set, and some ML algorithms can to some extent overcome such problems. However, it is tricky to prove that you improve on manual annotation, since you do not have any ground truth.


1. The ouput of an SVM is not probabilistic, but can we estimate the false positive rate using the fraction of data points within the margin?
> Yes, to some extent scientists rely on different [heuristics](https://en.wikipedia.org/wiki/Platt_scaling) for this.

1. Is there a case where linearity is still inseparable in high dimensions? For example, the noise in the data has the same characteristics but different class labels. How to deal with this kind of cases?
> Yes, under such condition we need more advanced ML methods e.g. a SVM with a more advanced kernel.

1. When setting a maximum margin hyperplane among two clusters, one constructs the hyperplane centrally among the closest two data points of the two opposing clusters (support vectors), therefore two of the outer data points of each cluster.  
Suppose one has two spread-out clusters, possibly growing into each other. Wouldn't it be possible to determine the centre of both clusters and construct a hyperplane based on the two centre points of each cluster?
> Yes, there are classifiers using such methods, e.g. [Logistic Regression](https://scikit-learn.org/stable/modules/generated/sklearn.linear_model.LogisticRegression.html)

1. From what I understood, the SVM algorithm does not work in cases where we have more than two categories/classes to classify/separate, but usually we need to handle these types of cases. Which method(s) can be used for this type of classification besides the one-versus-all classifiers method which seems (for me) to be not so optimal if we have a large number of classes?
> [Multi-class SVMs](https://scikit-learn.org/stable/modules/svm.html#multi-class-classification) could work.

1. When we measure the performance of the supervised classifiers we calculate scores for the different outputs for the classifiers and we put a threshold for what is being considered positive and negative results or outcomes (kind off just like when we looked at the FDR). However, how do we minimize type II errors in this case and how do we minimize type I errors? Is it still the same for when we looked at the FDR? And can we teach the algorithm, if such errors occur, to avoid doing the same type of error again?
> We could either move our classification boundary in the SVM, or we could use different sklack penalties for our positive and negative examples during training.


1. When we are doing a grid search in the jupyter notebook the C parameter vary from 0.0001 to 1000 to find the best parameter. As I understand it, if we increase the C parameter we also increase the risk of overfitting the training data and thus getting bad predictions on our test data. Would there be cases where we would allow higher C parameters even though we risk overfitting the data?
> As long as we test on separate data from our testing, this should be detectable.

![](img/margin.png)
1. About the softening Margins in VanderPlas:  
We have a plot shows the data have the overlap. Then basically if we don't project them into a higher dimension, we should not able to find any maximum margin hyperplane between them.  
As I understood that C has an ability that adjusts the SVM so that small C will allow points to go into the margin. Indeed in the figure C=0.1 we got more points inside the margin, and C=10.0 still strict for points that not entering the margin. But where are those overlaps? Why the overlap disappeared if we do the softening Margins?
> Not sure that I understand what you mean with overlap in this context.

1. Is it a lot more complicated to have a complex separation that follows the maximum margin principle but with no misclassified samples (no soft margin)? Is that kind of algorithm ever used, or do we always prefer a hyperplane with a soft margin?
> No that is the easy case. We introduce soft margins to take care of less clear or outlier datapoints.

1. Is there a way to score the effectiveness of a kernel function in mathematical terms, rather than just looking at the result? Why aren't nonlinear "hyperplanes" used more often (or linear hyperplanes transformed by the inverse of a kernel function)?
> A hyperplane is easy to express. A kernel is warping the feature space to be separable by the (linear) hyperplane, instead of what you are suggesting, i.e. warping the decisions boundary.
