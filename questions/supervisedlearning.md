# Questions and Answers to Supervised Learning.

## General machine learning

5. What are the advantages and disadvantages of supervised learning compared to unsupervised and semi-supervised learning?

## Kernels for non-vectors

1. In the article by Noble,  it is said that an advantage of kernels is that they can be used on non-vector inputs such as to classify DNA and protein sequence. As I understand it, the kernel function in e.g. the example on slide 7 in the pdf for the video lecture is the expression value squared, and in VanderPlas about SVM's there is an example where RBF is used, but what kind of kernel functions are used in cases where we have non-vector inputs?
   > An example is the [string kernel](https://en.wikipedia.org/wiki/String_kernel). 

## Maximum margin separating hyper planes

6. In the video about supervised machine learning, around minute 6 where you talk about the hyperplane. I do not understand why and how the hyperplane always fall on those three data points that are known as the support vectors?

## SVMs

4. It is mentioned at ~6 min into the video that you can use the Hinge loss function, is this connected to the use of a soft margin if you were to have data points that cross the maximum margin hyperplane, and is it with this function that you estimate the parameters for how you should define the soft margin, i.e. how much error you allow?

## Training

2. VaderPlas on Support vector machines, part Beyond linear boundaries: Kernel SVM.
“A potential problem with this strategy—projecting N points into N dimensions—is that it might become very computationally intensive as N grows large.”. Could you develop this a little more and explain why it might become very computationally intensive as N grows large?
   > This is a question that goes beyond what we will talk about. A hint is given in this [thread](https://www.quora.com/What-is-the-computational-complexity-of-an-SVM)

## Cross validation
1. Is it possible to asses hyper parameters with simple cross validation (and no nested cross validation) if the training dataset is large enough?
   > You stand the risk of overfitting to your data if you do.

3. [Video 12.40] How do you select the number of folds you group your data into, and how does this selection affect the training? Can the number of folds be made into a hyperparameter to optimize?
   > This is a trade-off between time to training your N models, and leaving out the 1/N of your training data that is used for training. 

## Pre conditioning

1. In the article about SVM, is it possible to help the algorithm select a correct solution with multi-dimension data set by combining the dimensions that are similar to each other together before projecting the data?
   > Yes, there are several such schemes. You can for instance use PCA, which we will discuss in a later lecture.


2. In the article about SVM，When we transfer the data into the higher dimensional space, what method we used to separate the data? is it still the maximum-margin hyperplane method? 
   > SVMs us hyperplanes to separate datapoint in kernelspace.
