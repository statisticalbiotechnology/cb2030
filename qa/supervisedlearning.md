# Questions and Answers to Supervised Learning.

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

1. In the video, the part that explains cross validation example, is a bit unclear to me. I understood that each learner has the data divided into 3 bins and the training and testing for the learner is done based on those 3 bins and that data set. However, I do not understand as to why there are three different learners? And do each learner itself have different data sets all together or is the same data changed a bit to produce complexity while keeping the data size constant?
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
 > The SVM optimes a function with two different components. *||w||* is the inverse of the size of the margin, the *&Sigma;max(0,1-y_i(wx_i-b))* is the slack penalty. The training of the SVM involves minimizing the sum of the two.

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

## Questions we will not work with during the seminar

1. Would it be possible to walk through the last code chunk of the jupyter notebook in a bit more detail? I find it a bit difficult to understand what is hapenning.
  > Could you help me by pinpoint where it gets challenging?

1. In kernel functions, when the author speaks about non-separable data set, does he mean that the points in the data set are related? Or in case of differential expression he had spoken of, one of the genes is differentially regulated thus preventing any boundary between the two gene sets?
  > Hard to understand.

1. Is there a clear distinguish between hard SVM and soft SVM? I am wondering if it is absolutely Hard SVM when there is no data overlap even the distance between two classes is very small?
    > Not sure what is meant with Hard/soft SVMs.

1. The article mentions one-versus-all classifiers to work well in cancer classification. Do you have an example of when they would not work well?
   > No but I am sure you cabn find such examples if you look for them.

1. Can you show how kernel work? Since it said that it is random by trial and error on the operation for additional dimension. Do we need to random the algorithm for operation?
  > Not sure what is meant.

1. Is the ROC score of 0.5 set by convention or does it differ alot between experiments?
 > Not sure what is meant.

1. What is the probability that a test sample i.e. gene expression of a patient is actually a false positive and is identified wrongly by the SVM? Also is there a method to correct such false positives?
  > Not sure what is meant.

1. What type of data can be used for SVM? And what type of problems could SVM solve?
 > Many classification and regression problems can be solved with SVMs.

1. Does it make sens to do multiple nested cross calidations? several rounds with smaller and smaller subsets? and if so, where is the limit.
  > Yes, if you have a reason to do so, it makes sense.

1. How does the example with the face recognition work?
  > It is not that relevant to this course. Read up on your own, if you have an interest.  

2. How do soft margins work without excluding datapoints or overfit the data?
  > They use hinge losses.

1. How can we choose the support vectors? How many support vectors should be considered and how does this choice affect the accuracy of the SVM?
  > The SVM trainer selects them for you.

1. Given that running times of state-of-the-art SVM learning algorithms scale approximately quadratically, what are the largest amounts of different variables (for example, expression of different genes) for which it is reasonable to use SVM? I.e. the examples used the expression of two genes to classify between two classes, how many genes is it feasible to scale up to?
 >  I am not sure it scales quadratically. I personally never used them for more than 20 million features, so I do not know where the technical limit sits.
