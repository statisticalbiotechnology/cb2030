# Questions and Answers to Supervised Learning.

## General machine learning

5. What are the advantages and disadvantages of supervised learning compared to unsupervised and semi-supervised learning?
   > To my understanding, the main advantage of unsupervised and semi-supervised learning is that these methods are less biased than supervised learning since they make conclusions/look for patterns inherent to the dataset rather than based on labels. The goal of supervised learning is to predict the output when it is given new data labelled in a similar way to the training dataset. Meanwhile, the goal of unsupervised learning is to find the patterns in unlabeled input data. Unsupervised learning is very useful for explanatory analysis, for example in clustering data points. 
   > The main disadvantage of supervised learning is that we can have a high risk of overfitting the data, which would lead to disproportionate conclusions. On the other hand, unsupervised learning can lead to poor correlation/patternization between data points, which would not be a very useful analysis.

## Kernels
2. In Noble, I do not understand how it's possible that the dataset can be linearly separated when projected in 4 dimensions. Figure [1K](https://www.nature.com/articles/nbt1206-1565/figures/1). How does dimensionality increase translate into better linear separation?
   > A1: A good illustration of how added dimensionality can improve separation is given in [Figure 1i and 1j](https://www.nature.com/articles/nbt1206-1565/figures/1)   
   > A2: Introducing another axis with an accompanied function allows for separation that previously was not possible with a straight line in the original data dimension. For example, under the Beyond Linear Boundries: Kernel SVM section in the In-Depth: Support Vector Machines article, by applying a RBF kernel they achieve a separation of the apparent middle cluster from the rest of the data points which allows for the positioning of a plane that can translate this difference into labels. In the article, they similarily applied a kernel function to achieve a separation in a higher dimension for which a hyperplane could be used to separate the 2 classes.


## Kernels for non-vectors

1. In the article by Noble,  it is said that an advantage of kernels is that they can be used on non-vector inputs such as to classify DNA and protein sequence. As I understand it, the kernel function in e.g. the example on slide 7 in the pdf for the video lecture is the expression value squared, and in VanderPlas about SVM's there is an example where RBF is used, but what kind of kernel functions are used in cases where we have non-vector inputs?
   > An example is the [string kernel](https://en.wikipedia.org/wiki/String_kernel). 

## Hinge loss
1. Video 6:15. How this Hinge Loss Function plot is produced and what it represents? It seems a little confusing to me.
   > So as I understand it, a perfect decision boundary would simply classify all data points with the correct category label but since this is rarely the case we need a way of making up for incorrectly classified data points, using a so-called loss function. The Hinge loss function is an example of such a function, and is used for finding the optimal decision boundary for classification. A typical approach in misclassification loss is that all incorrect classifications are treated the same and retrieve an equal penalty. The Hinge loss function is instead based on how far away from the decision boundary that a data point is located. This distance dependent variable, notated ẑ, is used for magnifying the penalty of a mismatch so it is proportional to the distance, i.e. mismatches further away receive a higher penalty than the ones close to the boundary. The appearance of the Hinge function has to do with it using a penalty margin of 1 and is maximized to avoid negative penalties, giving you penalty of 1-ẑ if you get a data point incorrect and 0 if correct.

1. 10:2416 Nov at 10:24
Is the Hinge loss function the only one used in SVM for generating soft margins? Are there other loss functions that can be utilized in certain situations depending on datadistribution, high noise levels etc?
  > Yes, hinge-loss is the function used together with SVMs, however, for other types of ML there is a plentiora of other loss functions.

## Maximum margin separating hyper planes

6. In the video about supervised machine learning, around minute 6 where you talk about the hyperplane. I do not understand why and how the hyperplane always fall on those three data points that are known as the support vectors?

1. Why is it that there are always 3 support vectors? If we changed the image at [5 min] so that instead of two white dots being side-by-side and equidistant to the hyperplane, we only have one white dot in front of all other white dots (like for the black dots), would not two support vectors be enough and give the same result as using three?

## SVMs

4. It is mentioned at ~6 min into the video that you can use the Hinge loss function, is this connected to the use of a soft margin if you were to have data points that cross the maximum margin hyperplane, and is it with this function that you estimate the parameters for how you should define the soft margin, i.e. how much error you allow?

1. From the article by Noble, I am a little confused about this, which are actually the "support vectors" in the SVM algorithm?
   > Support vectors are data points which influence the position of the hyperplane in the data set. They are points which lie closer to the hyperplane and help in deciding where the hyperplane should lie in the data set. In other words, the optimal hyperplane will remain unchanged if any other points or instances are changed but expect the support vectors. Thus, these points help us to build the support vector machine. 

## Training

2. VaderPlas on Support vector machines, part Beyond linear boundaries: Kernel SVM.
“A potential problem with this strategy—projecting N points into N dimensions—is that it might become very computationally intensive as N grows large.”. Could you develop this a little more and explain why it might become very computationally intensive as N grows large?
   > This is a question that goes beyond what we will talk about. A hint is given in this [thread](https://www.quora.com/What-is-the-computational-complexity-of-an-SVM)

## Cross validation

1. Video 12:20 about cross validation "We can give accuracy estimates based on all the training and test data without having trained on the same examples that we tested." What does it mean that we do not train on the same examples we tested? Do we not use the same data on all the learners?
   > When using machine learning, we want to train an algorithm in such a way that it will be able to assess future data and accurately classify it. In order to teach the algorithm what is right and wrong, we use training data that is already annotated. When we are done training the algorithm, we want it to predict the outcome of a new case, and in order for us to assess how well the algorithm performs, this new data has to come from outside of the training set (as the training set is familiar to the algorithm). Therefore, we do not want to train the method on the same data that we then test its performance for. In order to avoid this and to avoid generating even more data besides the training data to test on, which is expensive and time consuming, we can divide the training set in 3 bins where we train each learner on a set of them and test its performance on the last. We do use the same data in all 3 learners, however, we use different parts as training and test sets within them and can thus estimate the performance of the individual learners based on the different training/test sets. 


2. Is it possible to asses hyper parameters with simple cross validation (and no nested cross validation) if the training dataset is large enough?
   > You stand the risk of overfitting to your data if you do.

3. [Video 12.40] How do you select the number of folds you group your data into, and how does this selection affect the training? Can the number of folds be made into a hyperparameter to optimize?
   > This is a trade-off between time to training your N models, and leaving out the 1/N of your training data that is used for training. 

## Pre conditioning

1. In the article about SVM, is it possible to help the algorithm select a correct solution with multi-dimension data set by combining the dimensions that are similar to each other together before projecting the data?
   > Yes, there are several such schemes. You can for instance use PCA, which we will discuss in a later lecture.


2. In the article about SVM，When we transfer the data into the higher dimensional space, what method we used to separate the data? is it still the maximum-margin hyperplane method? 
   > SVMs us hyperplanes to separate datapoint in kernelspace.


## Other
1. What is the difference between using kernel machine and allowing for more complex separation model/function? What a potential advantages and disadvantages of using? (When) is "kernel trick" robust to overfitting?

1. (Video; 8:55) When applying a Kernel to transform a support vector machine to increase its dimensionality, do we operate under any biases or assumptions? What are the consequences of this transformation? How do we decide what type of kernel to apply?

1. VaderPlas on Support vector machines, part Beyond linear boundaries: Kernel SVM. “A potential problem with this strategy—projecting N points into N dimensions—is that it might become very computationally intensive as N grows large.”. Could you develop this a little more and explain why it might become very computationally intensive as N grows large?

1. Video 9:49-12:41 How are the training sets validated, and how many training sets are required to produce analgorith that is robust for practical use?

1. Video Lecture (10 minutes) and article by Noble. To detect and avoid overfitting we want to train and test the method on different data sets, and we can use cross-validation to do so. But I am a little confused about how we measure overfitting here? For supervised regression (with a continuous output variable) we can calculate a training and test error where a high test error and low training error indicate overfitting. Is it the confusion matrix that is used for supervised classification to estimate these errors? 
   > Overfitting is when the model fits the training data so much that it ends up modeling noise rather than the important properties that we want to model, such that it works well on the training data but not the test data. Here is an example taken from Vanderplas: 
   > ![](https://jakevdp.github.io/PythonDataScienceHandbook/figures/05.03-bias-variance.png)
   > We see to the right of the image that the overfitted model follows each and every point, leading to a very large variance in the model. When we apply a model like this to a different data set, we might not get the classification we intended because the model was so precisely fitted to the training data that it does not actually reflect real life. 
   > So we want to make sure that our model is not overfitted to the training set that we used. When we perform cross-validation, we split the training set so that we, in practice, end up with different training sets. We can then compare how well the data fits these different training sets. Since the training sets are annotated such that we know the "true" classifications, we can create a confusion matrix based on this to measure the performance of the model. There is a really good example in the VanderPlas book where they calculate these values for [face recognition](https://jakevdp.github.io/PythonDataScienceHandbook/05.07-support-vector-machines.html)  (Links to an external site.)
   > Using this confusion matrix, if we identify that the test set fits the model better for one of the training sets, we can determine that the model is overfitted to that training set. Ideally, the different test sets should fit their respective training sets equally well. 

1. In the VanderPlus section under “Tuning the SVM: Softening Margins”, the tuning parameter C is described as a parameter that controls the hardness of the margins. How is a suitable value of C chosen? It is mentioned that cross-validation or a similar procedure should be used, how is this used to determine C?

1. The article by Noble states that  a SVM can classify microscopy images by using an appropriately defined kernel function. How would you describe a maximum-margin hyperplane that separates the images - would that hyperplane also be an image?   
   > No, a hyperplane is always a [hyperplane](https://en.wikipedia.org/wiki/Hyperplane).

1. In the provided papar, it shows The maximum-margin hyperplane can maximizes the SVM's ability to predict the correct classification of previously unseen examples. So it means the necessnary step of SVM? I am not sure. It indicate we choose the hyperplane in this way all the time? It's common to all dimentional space? 

1. In the Nobel article I found it a little bit hard to understand what they meant with A linearly nonseparable two-dimensional data set, which is linearly separable in four dimensions. Could you explain this a bit more?

1. How does one decide which supervised classifier is best for a given set of data. The performance metrics definitely give us an idea but how do we use each one in particular with different kind of data? For example, can a supervised classifier with high ROC score be bad for some kinds of data etc.

1. From what I have understood SVM ( from Nobel paper) works more or less similar to Machine Learning basic algorithm ( you teach the system that this is the particular pattern you are looking for and then give several examples so that it can iterate itself to a best possible conclusion). If they have the same basic algorithm why cant we simply use Machine learning, why do we have a separate entity called SVM? I don't understand what biological advantage or edge this SVM provides?
   > Yes, SVMs are a type of Machine Learning algorithms.

1. 9:1116 Nov at 9:11
The article mentions that sometimes algorithms are used as to get fast approximations instead of the SVM. Is it very time consuming then to run the SVM? How much time difference is it in comparison to the algorithm?

1. In the article about SVM, under Extensions of SVM it is mentioned that for nonbinary classification problems training multiple one-versus-all classifiers is a good solution, meaning that you test separately A vs nonA, B vs nonB and C vs nonC and then combine the results. But why wouldn't you instead test A vs B, A vs C and B vs C? Would that just introduce additional complications or would it actually give you better results?
  > Often it is better to use all data, however, I agree that there might be situations where your suggested scheme would work better.

1. In the VaderPlas a facial recognition example is introduced, the images here are on a grayscale, but I wonder if we are to use SVM and want to include color and its intensity in the separation, how would one add that to the model if a kernel is already used to set us into a higher dimension. 

1. From a paper 'What is a support vector machine?' I learnt about the soft margin, which allow support vector machine to make a certain number of mistakes so that the other points could be still classified correctly. I was wondering how many mistakes can we let in a data set in %? Does it depend on a data set you have every time so there is no strict percentage for that? 

1. In Noble it is stated that projecting data into very high dimensional spaces can be problematic due to the curse of dimensionality. A projected hyperplane with very high-dimensional kernel function will result in a boundary between the classes that is very specific to the training data set and will not generalize well when new data is presented. What is consider to be a too high dimension? Is it specific for a data set or can it be somewhat generalized? It is also stated that one should choose a kernel function that allow the data to be separated but without introducing irrelevant dimensions. When is a dimension consider to be irrelevant? 

1. In the video lecture about cross validation three different “learners” are trained/tested on different bins of the original training data. What are the different learners in this case? Are they later combined somehow and in that case, how is that done? 

[11:13]