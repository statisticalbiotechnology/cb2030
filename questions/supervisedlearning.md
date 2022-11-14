# Questions and Answers to Supervised Learning.

### Multiclass SVMs

1. A support vector machine is used when the data has exactly two classes. Why can’t we use it to separate more than two sample groups? Wouldn’t we be able to do that by, for example, adding another separating hyperplane?
   > We can do separation for more than 2 classes using SVM. For instance, one can take a one-vs-all approach when we first separate 1 class from all the rest (considered as one class) and then repeat this process until all the classes are identified. Alternatively, optimization algorithms of SVM can be generalized to multiclass classification.
   > It is worth noting that the book contains an example of [multiclass prediction with SVMs](https://jakevdp.github.io/PythonDataScienceHandbook/05.07-support-vector-machines.html#Example:-Face-Recognition)

### The curse of dimensionality
A nice wikipedia entry describing these problems can be found [here](https://en.wikipedia.org/wiki/Curse_of_dimensionality)

1. In the article of William S Noble it is said that "projecting into very high-dimensional spaces can be problematic, due to the so-called curse of dimensionality: as the number of variables under consideration increases, the number of possible solutions also increases, but exponentially". Therefore it is problematic to select the GOOD solution.   
I am wondering how "different" are those solutions and if we couldn't apply the "maximum margin" principle to select the solution being the most in the middle?
   > I think very different. In the given examples, the clusters are clearly separated which made constructing a clear hyperplane easy. However, in a lot of instances the clusters will not be so easily defined and separated, making the maximum margin principle applicable from various angles, creating multiple solutions. As you can imagine, these solutions will increase tremendously when increasing the dimensions. 


### Tuning of Hyper parameters
The jupyter notebook describes how to tune hyperparameters using GridSearch. There is also a section in VanderPlas describing how to [select the best model](https://jakevdp.github.io/PythonDataScienceHandbook/05.03-hyperparameters-and-model-validation.html#Validation-in-Practice:-Grid-Search). 

1. In the section describing support vector machines, they write that the tuning parameter that controls the hardness of the margin should be tuned using cross-validation or a similar procedure. How is cross-validation used to tune the parameter? How do we make the trade-off between the size of the margin and the hyperplane violations?

### Cross validation
1. What is the applicatory benefit/limitations between the choices of 3-fold (or even 4-fold or 5 fold) cross validation, or implementing nested validation for training data sets?
   > Selecting a larger number of cross validation bins has the benefit of you traing the model on more data, but the drawback that you have to train more models, i.e. it is slower.

1. Would an x-fold cross-validation (with an increasing number of x) not lead to a bias towards similar data sets, i.e. reducing the "learning impact" of a dissimilar data set?
   > If the data set is not representative of the real world data, yes.

1. In the video (Cross Validation) it is stated that the training set is separated into three cross validation bins and that three different learners are trained and tested on the different bins. What exactly are the learners? Are they connected in some way and for example combined after training/testing of the set or are they used individually as three separate "sets"?
   > The outcome of the procedure are three separate classifiers, and their performance figures. There are different strategies for creating a final predictor: 1) Often a final classifier is trained based on all data. However, such a classifier should not be used for reporting performance. 2) One can select one of the predictors, either by random or by its performance. 3) One can use all predictors and use the majority vote between them as a final prediction.


### Kernels

1. In the section about support vector machines it is mentioned that a fit on kernel-transformed data can be done implicitly by using the kernel trick. How does this work?
   > It is a [nice piece of mathematics](https://en.wikipedia.org/wiki/Kernel_method#Mathematics:_the_kernel_trick) that speeds up the calculations of the similarities of datapoints in kernel space. It is well worth studying, but we will not walk it through in the course.

### Feature normalization
[Feature normalization](https://en.wikipedia.org/wiki/Feature_scaling) is standard practice in most ML algorithms. It strives to give all features the same influence on the model by compensating for the difference in magnitude of different features.

1. Regarding the notebook, why do we scale all the gene expression values to a standard deviation of 1 and a mean of 0?
   > In general, before training any machine learning model one should normalize data just because it can come from very different distributions. Here is a nice [blog post on the subject](https://towardsdatascience.com/why-data-should-be-normalized-before-training-a-neural-network-c626b7f66c7d).
