# Questions and Answers to Supervised Learning.


## General machine learning

5. What are the advantages and disadvantages of supervised learning compared to unsupervised and semi-supervised learning?
   > To my understanding, the main advantage of unsupervised and semi-supervised learning is that these methods are less biased than supervised learning since they make conclusions/look for patterns inherent to the dataset rather than based on labels. The goal of supervised learning is to predict the output when it is given new data labelled in a similar way to the training dataset. Meanwhile, the goal of unsupervised learning is to find the patterns in unlabeled input data. Unsupervised learning is very useful for explanatory analysis, for example in clustering data points. 
   > The main disadvantage of supervised learning is that we can have a high risk of overfitting the data, which would lead to disproportionate conclusions. On the other hand, unsupervised learning can lead to poor correlation/patternization between data points, which would not be a very useful analysis.


## Performance metrics
1. At the end of the video lecture, the last thing you say is that everything above a ROC score of 0.5 would be seen as a good predictor. Intuitevely this feels as a low requirement for implementation of predictors, therefore I am wondering if this is true? Do you use predictors with a ROC score of example 0.6 in clinics? If yes, why is the ROC score allowed to be so close to random (0.5)?
  > No, you are right. A ROC score of 0.51 will often not be very valuable. I meant to say that a ROC score > 0.5 is a score that is better than a random prediction. Also, this is somewhat dependent on the research question. Sometimes one accept predictors with very low ROC score as other information is unavailable.

1. On slide 12 in the video lecture, sensitivity and TPR are the same thing (which is true according to Wikipedia), why are they given separately?
     > For no ther reason than that I wanted the abbrivaiations and the named metrics as separate metrics.

## Preprocessing
1. How to perform normalization in supervised learning?
Frequently, one [standardize](https://en.wikipedia.org/wiki/Feature_scaling) each feature before training and testing.

1. I understood that PCA was used as data preprocessing in the example with the same recognition in order to extract features. Is this type of preprocessing a common practice for other  types of data or it applies only to image identification?
  > It is not uncomon to use PCA as a dimensionality reduction technique prior to classification.


## Curse of dimensionality
1. Since it is common for data analysis to aim to reduce the complexity and dimensionality of the data, are there negative consequences of introducing higher dimensionality (other than increased computational requirements) to use kernels in combination with SVM?
  > Yes, [there indeed are](https://en.wikipedia.org/wiki/Curse_of_dimensionality). Your finite number of data points will spread wery thin in a high-dimensional feature space. This is true for any machine learning problem.
1. Noble mention the problem of the curse of dimensionality which menas that you could actually separate any given data but it would yield many more possible solutions and it will get harder to get the right solution, which I guess means that the problem of accuratly divide datapoints with a hyperplane still persists?
    > Yes, the  curse of dimensionality is just a description of a problem, the name offers no solution in itself.

1. Are there any other ways to tackle the "curse of dimensionality" except those mentioned in the article with cross-validtion and beginning with Simple SVM and experimenting with standard kernel functions?
  > You can always redisign your problem so that it becomes a lower-dimension problem.


## Overfitting and separation of test sets

2. * Given a dataset which percentage of it would it be used for training and which for testing? Are the bins showed in the presentation the same size? Is there a golden rule of how the dataset would be seperated?
   * What is a suitable ratio of data points in a training set to data points in a testing set? How are the data points for the different sets chosen from the data?
    > There is no rule. I often use 70/30.

1. Overfitting as I understand it is that your delimiter between two classes is two specific and cannot be generalized; is this correct?
    > When you overfit, you learn how to make accurate predictions on the dataset you trained on but you are unable to make predictions on novel data.

1. Does overfitting only occur when projecting data to higher dimensions?
      > No, you can easily think of a scenario where you overfit in one dimension. Say that you collect two patient, one with lung-cancer that does not smoke, and anotherone without lung cancer that smokes 30 cigarettes a day. A lung cancer classifier that takes the number of smoked cigarettes a day as an input, with the decission boundary of 15 cigaretes a day, would perfectlyt separate the training data, but might not be very valuable in the clinic.

1. Is the only countermeasure to overfitting the choice of a better Kernel, or is there something else you can do?
  >  More training data, less noicy data, less complex architectures (i.e. kernels) and more regularization of the classifier reduces overfitting problems.

1. The Kernel function selection is based on trial and error. And as we know, trial and error based exploration of data can be misleading at times. Could that be a problem here, when working with the prediction. Even though we know that the data is pre-classified and annotated and the kernel function based selection is based on this annotated data, but is there any chance of it giving a misleading separation or an artifact completely?  
  > This situation should be detected in the testig stage of the classifier

1. In the  notebook, it seems like that if we use the least differentially expressed genes to train linear SVM, we can get a favorable result for train data set but bad result for another independent test data set, because larger number of variables make model to overfit to the train data set. And in low dimensional classifier, it uses most differentially expressed transcripts to train an SVM. So does this mean choosing larger differentially data set can avoid overfitting effectively?
    > A larger dataset reduces the problem of overfitting, but there are no guarantees it will remove the proiblem.

## Cross validation
1. Can you give an example that how to cross validate a model? it seems you only take a re-sampling, what the function of test samples here?
   > The notebook provide such an example.

1. In the Jupyter notebook you mention that in cross validation you train different classifiers and combine their results. How does this work for nested cross-validation, what different things are you training within each classifier? Choosing hyperparameters is mentioned as an application, so is it to use different sets of the data to find different optimizations of the parameters and then merge those?
  > Often one use nested cross validation to select suitable hyperparameters, and then one use the optimal hyperparameters to train a regular cross validation net. That way the best hyper parameters are found for each cross valiadatuion set indpendently.

1. The idea behind the cross validation is to save money by dividing the available data into cross-validation bins (this idea is even further expanded for nested cross validation). If however, the amount of data is very limited in the first place, does it really make sense to sub-divide the given data into even smaller packages and risk inaccurate outcomes?
    > No, the bearing idea is that we avoid overfitting, or at least are able to detect situations where we overfitt, by using cross validation.

1. How significant is the difference in accuracy when combining cross validation with nested cross validation vs no combination?
  > It depends on the problem, however, the idea is that we want to detect situations where we overfitt.

1. Is there any reason to not combine with nested cross validation apart from computional performance requirements?
    > To some extent there is a withhold of data when you cross validate. Also, it is easier to extend your prediction for new datapoints. I.e. which of your *k* trained predictors from *k* fold cross validation should you use when you encounter a new example.

1. Regarding the 3-fold cross-validation: if three different learners are created, do we choose the one with best performance as the final classifier or is the final classifier a combination between the three?
  > There are different strategies for this. Often a final classifier is trained based on all data. However , such a classifier should not be used for reporting performance.

1. In the video, the part that explains cross validation example, is a bit unclear to me. I understood that each learner has the data divided into 3 bins and the training and testing for the learner is done based on those 3 bins and that data set. However, I do not understand as to why there are three different learners?
 >  So that none of the learners trains and tests on the same data.

1. In 3-fold cross validation, the data set is divided into three different bins that fills different functions (train/test) for three different learners. What is ment by learners in this case? Is it three different Support vector machines?
   > Yes!

## Kernels
1. Could you develop more about the kernels, I could understand that it is a type of mathematical transformation but I wasn't able to grasp the "mechanism".
  > [Kernel functions](https://en.wikipedia.org/wiki/Kernel_method) could cover a full course of its own. However, here we stop at the fact that they are ways to introduce new dimensions to your data that makes it possible to divide the data into different classes.

1. Except squaring the expression value, what are other types of dimensions that can be used when adding kernel functions?
  > Yes there are several different available kernels. Perhaps the most well known kernel is the [RBF Kernel](https://en.wikipedia.org/wiki/Radial_basis_function_kernel)

1. * When using kernels, how do you know which/what type of kernel to use for your specific data?
   * In Noble it is said that "kernels can be defined on inputs that are not vectors", what is meant by this?
  > A well known case in bioinformatics are so called [string kernels](https://en.wikipedia.org/wiki/String_kernel), that evaluates similarities of text or amino acid strings. Another examples in phylogeny, is [tree kernels](https://en.wikipedia.org/wiki/Tree_kernel).

1. In the Support Vector Machines Notebook it is mentioned that the parameter c that controls the margin hardenss should be adjusted, as well as the parameter gamma. What is the role of gamma? How can the optimal parameter be calculated?
    > Gamma is a parameter that controls the width of an RBF kernel.

1. I understand that choosing kernel function is based on trial and error but is  there any trick or practical method to select the right kernel? And how do you know that the selected kernel is right? Is it right when it can sufficiently separate different conditions through transformation non-linear to linear problem?
  > Sometimes one can select kernels that makes sense based on what makes sense for the problem. In the example at slide 7, we would perhaps know that an absolute value was more suitable for classification, and would hence select a quadratic kernel.

1. When Noble talks about kernels in the articel they mention that you have to be "lucky or smart and use trial and error" when choosing your kernel in order to get a good separation in a higher dimensional space. What if you are unlucky or don't come up with a kernel that will separate the data in a good way, is the data then unseparable or can one use another method?
  > There are several other supervised machine learning techniques available, such as Artificial Neural Networks, Naive Bayes, Random Forest, etc.

1. What is ment by changing the linear kernel to a radial basis function?
  > Instead of using one kernel, we use another kernel.  

1. Is the kernel is considered to be a hyper parameter?  
  > Yes, the choice of Kernel can be tuned just the same way as we tune hyperparameters.

1. In Noble, it is explained that kernel functions add dimensionality to the data, so as to make the data points separable by a linear hyperplane. He mentions that in order to space up data points from a two-dimensional space to a four-dimensional space, one could calculate the products of all pairs of features. I do not fully understand how this would work.
  > You multiply the features together and use these products as additional features? The point is that this is an operation that a kernel performs for you.

1. You mention in the video it is possible to add dimensionality levels to the space by calculating, for instance, the product of the expression values of the points in the data sets. What other kernel functions are used to increase the dimensionality of the data set?
  > **Any** function you like.

## Soft margins

1. * In the video it is mentioned that the Hinge loss function is a part of the Support vector machine. What are Hinge losses?
    * Can you explain the function of hinge loss? why use yi times wx-b?   
    > Here is wikipedia's entry on the [subject](https://en.wikipedia.org/wiki/Hinge_loss). However, that is not what I think you wonder about. *y_i(wx_i-b)* only makes sense as *y* is either -1 or 1, and you try to make *wx_i-b* take values >1 or <-1 depending on the value of y.

1. The soft margin allows for datapoints to be misclassified by our classifier. What size is reasonable to set the soft margin to? How do we determine a suitable soft margin?
1. How do you choose the number of data points that are allowed to cross the soft margin, and how far they are allowed to go?
     > You dont choose how many datapoints that cross the boundary, you just choose how much you will penelize the ones that do cross the soft margins.

1. The video then moves on to a mathematical formula (based on the Hinge loss function) that should be minimized to optimize the Support vector machine. I am confused by this, since the hyperplane for the Support vector machine should be selected based on maximizing the seperation detween the two classes. How does the selection of the maximum-margin hyperplane relates to the minimization of the above mentioned formula?
     > The SVM is just an optimization of a function. The optimize function allows for datapoints to cross the hyperplane, but with a penalty (through a hinge loss function).

## Support Vector Machines

1. I understand that the soft margin allows some data points or examples to go into the margin, if this allows a better fit, and that the amount of "hardness" of the margin is controlled by the parameter C. The VaderPlas reading said that a larger C is a harder margin and a smaller C is a softer margin, however the "What is a support vector machine?" paper states that the soft margin parameter "specifies a trade-off between between hyperplane violations and the size of the margin" (page 2). The SVM will select the maximum margin hyperplane, or the hyperplane with the largest margin. I do not understand how the parameter C relates to the size of the margin or how the margin "hardness or softness" relates the size of the margin? Are they related?
 > The SVM optimes a function with two different components. \|\|*w*\|\| is the inverse of the size of the margin, the *&Sigma;max(0,1-y_i(wx_i-b))* is the slack penalty. The training of the SVM involves minimizing the sum of the two. We weight the relationship beteen the two terms, either by C or &lambda;.

1. I tried to read up on the calculation on the weight vector w  and bias(?)b, but found it a bit complex. How is that done?
  > I find this [Stack exchange](https://math.stackexchange.com/questions/1305925/why-is-the-svm-margin-equal-to-frac2-mathbfw) post helpful. More generally, distances between hyperplanes can be calculated by formulas from this [wikipedia entry on the subject](https://en.wikipedia.org/wiki/Distance_from_a_point_to_a_plane).

1. Are hyperplanes always defined by multiple linear functions? or can they also include polynomic or quadratic functions? Also is there a good way of thinking of hyperplanes higher then 2 dimensional?
  > Yes, it is always a [hyperplane](https://en.wikipedia.org/wiki/Hyperplane).

1. * In the formula that is used to decide the hyperplane(minimize formula), you say that lambda is a parameter that decides how much weight to put on two things , can you explain how we select this value ?
   * As I have understood it, there is the soft margin parameter C that needs to be determined in the training process. Is the soft margin parameter the same as the parameter lamda referred to in the video lecture? Is the slack penalty that same as the soft margin? Besides the soft margin parameter (and lamda parameter if it is a different parameter), are there any other hyper parameters that need to be optimized during the training?
  > The slack penaly, *C=1/&lambda;* is hyperparameter. The notebook contains an example of how one select hyperparameters with grid search. And yes there might be other hyperparameters in need of optimization during training.

1. How does margin maximum hyperplane work? According to the article, one would choose the distance from the separating hyperplane to the nearest expression vector. How would one choose the margin hyperplane? Could it be between any two points? In the article, gene expression values from AML and ALL patients are separated using the separating hyperplane. So, what would the the margin hyperplane be in this scenario and what would the expression vector be, would it be at the AML or ALL side?
  > We want a hyperplane that separates the AML and ALL patients, the margin would sit inbetween the AML and ALL patient samples.

1. Why is it an advantage that very distant points don't affect the fitting of a SVM  boundary line?
  > Such data points are normally obvious, and might not to effect the classifier descission.

1. Would it be possible to use the support vector machine model for unsupervised learning? If so, what would be the quantity of test-data you would need to achieve a good predictor?
    > SVM are normally only used for labeled data sets. There are some interesting exceptions, like outlier detection with [one class SVMs](https://scikit-learn.org/stable/modules/generated/sklearn.svm.OneClassSVM.html). Also, kernels by themselves have some interesting applications in unsupervised learning, for instance in visualization techniques such as [UMAP](https://umap-learn.readthedocs.io/en/latest/basic_usage.html)

1. Is the soft margin a parameter of the Kernel, because in principle, shouldn't softening your margin make the delimiter less specific?
      > The soft margin is a feature of the SVM, not the kernel.  

1. * In the VaderPlas article when using the radial basis function as kernel function in Scikit-Learn to fit the non-linear data, 7 points are marked as support vectors. What does the number of support vectors depend on and why did it increase from 3 to 7 when going from 2D to 3D (or did it project on a higher dimension than 3)?
   * Will three support vectors always be enough to uniquely define a maximum margin separating hyperplane, or will the number depend on the dimensions of the data?
  > * That will be dependent on the shape of the data, but tends to increase with the dimensionality of the data and slack penalty. See e.g. this [stack exchange post](https://stackoverflow.com/questions/9480605/what-is-the-relation-between-the-number-of-support-vectors-and-training-data-and). The minimum number of support vectors needed, tend to be independent on the number of [dimensions of the data](https://stats.stackexchange.com/a/310749)
  > * Support vectors are defined as the data points closest to the decision boundary. Each data point is a vector and those closest span the margin and are the only ones needed to define the decision boundary, and I guess are those supporting it.

1. Regarding the plot produced by In [15] in VaderPlas, I interpret it as if all the data points with circles around them are supporting vectors. Is this correct? Are sometimes more than three supporting vectors used?
  > Yes and Yes!

## Supervised ML

1. Can the machine learning algorithm become better than the quality of the data? Say we have to label the data as positive or negative but we are only correct 90% of the time will this then also be true for the algorithm?  
> Yes, normally manually annotated labels are frequently incorrectly set, and some ML algorithms can to some extent overcome such problems. However, it is tricky to prove that you improve on manual annotation, since you do not have any ground truth.

1. The hyperplane is used to separate data in a n-dimensional space. Instead you could also do a complexity reduction (e.g. PCA) and then apply a linear function (or one with low dimensionality) to separate the data. Is the hyperplane more precise as no complexity reduction is carried out? Is one of the methods preferred in certain cases?
> Supervised ML is preferred when you trust your labels, and often for lower dimensional problems. Unsupervised ML is preferred in other cases.

1. Supervised Learning such as SVM are based on creating a classifier from an annotated dataset. Does this mean that the classifier only can get as precise as the annotations in the dataset? Can a small set of erroneous annotations ruin a dataset? How is this in contrast to unsupervised learning?
> Yes and Yes! In unsupervised learning there are no errornous annotation to ruin your classification.


## Over-fitting to data

1. I understand that a consequence of too many dimensions, especially when the number of dimensions surpass the number of individuals in the training set, is making the algorithm overfit the data. Is there any recommended maximum limit for the number of dimensions based on the number of points in the dataset?
> No, it depends on the problem. A bit circular: You should include as many features as needed, but not more. There are some theory associated with the number of selected features like [Aike's Information Criteron](https://en.wikipedia.org/wiki/Akaike_information_criterion), however, it is nort always applicable.

1. When finding training data for creating a support vector machine it was stated in Noble that support vector machines have difficulties differentiating between data from samples taken with different methods. However if you would want to expand your available testing or training data how similar does your data need to be in order to not compromise the SVM.
> When designing a classifier, you need to make sure that your training data is representative for what you [actually want to classify](https://www.youtube.com/watch?v=t4DT3tQqgRM). SVMs are not very different in this than any other classifier.

## Training vs. Test sets

1. Can the quality of a training set be judged by looking at the predictive power the resulting trained algorithm has on the test set?  If not, how can you assert the quality of a training set - i.e. when is a training set sufficiently broad yet representative.
> You know that you have a good training set when you get good performance on a classifier trained on the set. However, if you get low performance, it could be an indication that the design of your classifier and not the training set is to blame.

1. You mentioned in the video lecture that we need to optimise hyper-parameters by another separate test dataset. Why is it that we cannot optimise the hyper-parameters from the training set?
> We can set hyper-parameters based on training data, but we might overfit.

1. How can we define the statistical significance of hyperplane, margin, etc. ?
> We measure performance based on test sets?

1. ![](img/moving_examples.png)
Is there any risk of a hyperplane in the real data to be off enough, that some data could be misinterpreted? And if so do we just disregard that kind of data?
> Yes, a classifier's performance is based on its ability to generalize from training data.


## Soft margins

1. What must be taken into consideration when we choose the soft margin parameters?
> That your classifier should work well.

1. ![](img/margin.png)  
About the softening Margins in VanderPlas:  
We have a plot shows the data have the overlap. Then basically if we don't project them into a higher dimension, we should not able to find any maximum margin hyperplane between them.  
As I understood that C has an ability that adjusts the SVM so that small C will allow points to go into the margin. Indeed in the figure C=0.1 we got more points inside the margin, and C=10.0 still strict for points that not entering the margin. But where are those overlaps? Why the overlap disappeared if we do the softening Margins?
> Not sure that I understand what you mean with overlap in this context.

1. Is it a lot more complicated to have a complex separation that follows the maximum margin principle but with no misclassified samples (no soft margin)? Is that kind of algorithm ever used, or do we always prefer a hyperplane with a soft margin?
> No that is the easy case. We introduce soft margins to take care of less clear or outlier datapoints.

## Support Vector Machines
The derivation of the mathematical formulation of a support vector machine is given e.g. in the wikipedia entry on [SVMs](https://en.wikipedia.org/wiki/Support_vector_machine#Linear_SVM).

1. In the VanderPlas it is mentioned that SVM methods are computationally expensive when the training data set is large. In practice, how large can the training data set be before the method becomes so time-consuming that it makes sense to use simpler, faster methods first?
> I am currently working with datasets of 25 million datapoints. Given you can use not too advanced classification you can expand the number of datapoints pretty far.

1. In the case of having multiple genes, can the SVM algorithm be modified to weigh different genes differently? If differential expression in some genes might be more impactful for the classification, can this be taken into account in the SVM algorithm?
> Yes, this is one of the points of a SVM.

1. In Noble:
  1. It is mentioned in the end that the running time of the SVM scales quadratically. Is there any way to reduce or optimize this to make SVM algorithm faster?
  > Use a linear classifier?
  2. It is also mentioned that there are some fast approximation algorithms that scale almost linearly and perform nearly as well as the SVM. Could you elaborate a bit more about these algorithms?
  > Here is an example of one such implementation in [sklearn](https://scikit-learn.org/stable/modules/generated/sklearn.svm.LinearSVC.html)


1. When we measure the performance of the supervised classifiers we calculate scores for the different outputs for the classifiers and we put a threshold for what is being considered positive and negative results or outcomes (kind off just like when we looked at the FDR). However, how do we minimize type II errors in this case and how do we minimize type I errors? Is it still the same for when we looked at the FDR? And can we teach the algorithm, if such errors occur, to avoid doing the same type of error again?
  > We could either move our classification boundary in the SVM, or we could use different soft margins for our positive and negative examples during training.

## Hyperplane

1. Is there a way to score the effectiveness of a kernel function in mathematical terms, rather than just looking at the result? Why aren't nonlinear "hyperplanes" used more often (or linear hyperplanes transformed by the inverse of a kernel function)?
> A hyperplane is easy to express. A kernel is warping the feature space to be separable by the (linear) hyperplane, instead of what you are suggesting, i.e. warping the decisions boundary.

1. In the article "What is a support vector machine?", it is mentioned that SVM is different from other similar methods due to how the hyperplane is selected.  How do other classifiers select this parameter?
> There are many other methods.

## Kernels

1. How can we find the right kernel? The Noble article mentions trial and error, is this the most common way to do it?
> Yes that is it. Trial and error is often the most frequent way to select models and hyper-parameters in other types of ML.

1. How does the kernel function go from a low dimension to a higher one?
> By introducing new dimensions. A nice example for this is the quandratic dimension in [Figure 1](https://www-nature-com.focus.lib.kth.se/articles/nbt1206-1565/figures/1)j

1. Could you give further examples of kernel functions than those described in "What is a Support Vector Machine?" Furthermore, are there "simple" data sets where it is impossible to employ kernel functions?
> [Wikipedia](https://en.wikipedia.org/wiki/Kernel_method) mentions a couple of kernels.

1. Is there a case where linearity is still inseparable in high dimensions? For example, the noise in the data has the same characteristics but different class labels. How to deal with this kind of cases?
> Yes, under such condition we need more advanced ML methods e.g. a SVM with a more advanced kernel.

1. In the literature we saw two different options for a kernel function: the first was a linear function and the second was a radial basis function. What other types of functions can be used, and most importantly are there any requirements for the selection of the kernel function?
> There are many different kernel functions available.

1. How do we add another dimension to the data for kernel feature? And how do we know which method of adding dimensionality is the best for one particular dataset?
> We do not know, we have to try for ourselves.

## Multi-class

There is a description of a multi-class classification problem in [VanderPlas](https://jakevdp.github.io/PythonDataScienceHandbook/05.07-support-vector-machines.html#Example:-Face-Recognition).

1. To perform multiclass classifications, Noble describes that: “the simplest approach is to train multiple, one-versus-all classifiers”. He mentions that there are a variety of methods to perform multiclass classifications which are more sophisticated. Could you elaborate on how these optimized SVM algorithms work?
> Here are some examples from [sklearn](https://scikit-learn.org/stable/modules/svm.html#multi-class-classification)

1. From what I understood, the SVM algorithm does not work in cases where we have more than two categories/classes to classify/separate, but usually we need to handle these types of cases. Which method(s) can be used for this type of classification besides the one-versus-all classifiers method which seems (for me) to be not so optimal if we have a large number of classes?
> [Multi-class SVMs](https://scikit-learn.org/stable/modules/svm.html#multi-class-classification) could work.

1. In the video about supervised machine learning, separating hyperplanes & kernel algorithm are shown to be useful for the separation of two categories (e.g. disease and healthy mRNA). But, if we want to separate more than 3 categories with the same method,  are there any algorithm / method that we can use for this purpose?  
> Multi-class classifiers might help you.

1. In case of for example expression levels: Is it possible for a simple supervised learning to decide between three groups as well? For example low expression, normal expression and overexpression? Is it common to just have one hyperplane to divide two groups or is it common to use more than one dividing line to distinguish more groups?
> Yes, you use a multi-class classifier.


## Feature selection

1. How do you decide how many variables (genes in the jupyter notebook on the TCGA breast cancer set) to use to avoid over - and underfitting of the training data set?
> Again, trial and error is the most common method. You often to your feature selection on a separate dataset, to avoid overfitting. This said, [feature selection](https://en.wikipedia.org/wiki/Feature_selection) is a research topic of its own.

1. I think I understood the SVM classification when it is explained based on as in the provided article on two genes/dimensions, but how does it work for all the 6817 genes? Like, is it possible to visualize how the hyperplane is generated when using so many variables?
> Not in a visual way. You have to use your imagination, or possibly use a [dimensionality reduction](https://en.wikipedia.org/wiki/Dimensionality_reduction) scheme to project your data to a 2d plot.

## Hyperparameters

1. Could you give us an example of a hypervariable in nested cross-validation? Is it like saying that GC content is a variable of the DNA-melting temperature and H-bond energy of G≡C pair is, in turn, hypervariable of the GC content?
> No, a hyper-parameter is a variable that controls the training procedure it self, that needs to be set for the procedure to work. The soft-margin in SVM training is such a parameter.

## Cross validation

1. In cross-validation, how do we know how many bins to divide the data in, and later on how many bins to use for training / testing?
> Its a choice between speed and risk to not detect overfits. However, in practice a low number like 5 or 3 works well for many problems.

1. In cross-validation, after the learners were trained and tested on the different sets, how is the resulting information combined again? Can I imagine it as each of the three learners fitting a set of parameters to the training data and if so, how is this information combined from the three learners afterwards?
> There is no fix scheme for this. However, [I normaly combine](https://link.springer.com/article/10.1186/1471-2105-13-S16-S3) the classifiers' test results based on their SVM score, or just by the ir classification result, as in the notebook.

1. In the softening margins step, we should set up the proper parameter C to control the margin. But in jupyter notebooks, these C parameters are usually adjusted manually at 0.1, 10, or 0.0001, 1000. In a practical case, should this C parameter be confirmed empirically or are there any algorithms to help us decide the proper C?
> I normally set C with cross validation or nested cross validation, as shown in the notebook.

1. When we are doing a grid search in the jupyter notebook the C parameter vary from 0.0001 to 1000 to find the best parameter. As I understand it, if we increase the C parameter we also increase the risk of overfitting the training data and thus getting bad predictions on our test data. Would there be cases where we would allow higher C parameters even though we risk overfitting the data?
> As long as we test on separate data from our testing, this should be detectable.

1. How does the nested cross validation allow us to select the hyper parameters? What type of information about the hyper parameters does the nested cross validation produce and how do we interpret that?
> The cross validation allow you to test which values that work best for your test data.

1. I'm not sure if I understood it correctly, but is cross-validation a cheaper alternative than supervised machine learning, or is it a manual version of it?
> No It is a way to validate Supervised ML.


## Probabilities

1. The ouput of an SVM is not probabilistic, but can we estimate the false positive rate using the fraction of data points within the margin?
> Yes, to some extent scientists rely on different [heuristics](https://en.wikipedia.org/wiki/Platt_scaling) for this.

## Other types of Supervised ML

1. When setting a maximum margin hyperplane among two clusters, one constructs the hyperplane centrally among the closest two data points of the two opposing clusters (support vectors), therefore two of the outer data points of each cluster.  
Suppose one has two spread-out clusters, possibly growing into each other. Wouldn't it be possible to determine the centre of both clusters and construct a hyperplane based on the two centre points of each cluster?
> Yes, there are classifiers using such methods, e.g. [Logistic Regression](https://scikit-learn.org/stable/modules/generated/sklearn.linear_model.LogisticRegression.html)

