# Questions and Answers on Clustering.

## Normalization

1. In the notebook when log-transforming the data, the base 2 logarithm is used, while the natural logarithm was used in the notebook for linear models. Any base works to transform log-normal data to normally distributed data (according to Wikipedia), so is the choice of base here arbitrary or is there any reason you use different bases?
  > No this is entirely an arbitrary choice.  In fact, they are just a scalar factor from each other as, *log<sub>a</sub>(x)= log<sub>b</sub>(x)/log<sub>b</sub>(a)*

1. It is said in the notebook that the RNA-seq data follows the log-normal distribution, however, some people online say it follows the negative binomial distribution. Does it change depending on the dataset? Do we check the distribution firstly?
  > E.g. DESeq2 uses negative binomial distributions for modelling differential expression in RNAseq data. Such methods are very practical when modelling differential expression, and you might be able to normalise your data using such procedures as well. However, log normalisation is easier to implement, and that is why I used them in this course.

## Supervised vs. Unsupervised learning

1. There are advantages of unsupervised learning over supervised learning in terms of use of labels but people still continue use supervised learning. Thus, what kind of cases or data is convenient to use in supervised learning but not in unsupervised and vice versa?
   > Supervised leaning is more efficient when labels are available. However , in many applications we just don't have labels -- then clustering is helpful.

1. In the video you mention that when using supervised learning, you lose the ability to do statistical testing, could you explain this a bit further?
    > Once you used the labels for training, you can not use them for testing. In the notebook for supervised learning, we used our labels to train a perfect separation between PR+/- patients. If we would have used the same labels for assigning confidense of the predictions, we would have said that we had full confidence in our prediction, which in that case was the wrong .

1. In the reading material on GMM, it mentions that it can be used to find the distribution of particular data set. This sounds some what similar to the supervised learning where the distribution of the data is found but also the labels are used to separate. In this case why would it be better to use GMM instead of Supervised learning where it not only does the same but also provide the separation based on data labels? Can the GMM itself be used as a learner (classifier) for the supervised learning algorithms, considering it does the same?
  > GMMs are frequently used as [generative models](https://en.wikipedia.org/wiki/Generative_model) within both supervised and unsupervised ML. When used in supervised context, one train separate mixtures for positive and negative examples, and evaluate them to find the posterior probability of the classes for any test data.

1. In the video, you mention that with unsupervised clustering you can perform statistical tests to check whether the generated clusters make sense with the labels. However, I had previously understood that unsupervised clustering is precisely used to avoid using labels or when you don't have them. If you already had labels why would you use unsupervised clustering with that dataset? Would labels, in this case, only be used for validation of the clustering algorithm?
  > In situations where you have just a few labeled cases, it can pay off to cluster data first, and use the clustering structure to classify your labeled examples. In such case you can assign performance figures to the labels.



## Applications of Clustering

1. It seems to me that you need to decide beforehand how many cluster centers to use (i.e. how many clusters there are in your data set) when using k-means clustering. This seems to be based on how many clusters can be visually observed. If you can already see distinct clusters, why use clustering? And if you can not see distinct clusters, is  not k-means clustering especially weak when the distinction between clusters is unclear? In what situations is k-means clustering really useful?
  > To me k-Means clustering is mostly useful when there is a clear reason to believe that there are a certain number of clusters in your data. E.g. you know that you have 4 different types of cells in your data.  
  > An other application is when you really know nothing about your data, were you can select a couple of different clustering to evaluate what you think is the best division of your data. You often see this when evaluating e.g. time series data. By clustering expression profiles, we can find possibly co-regulated analytes. E.g. Figure 3 of this [article](https://www.mcponline.org/content/13/8/2042/tab-figures-data)

1. The clustering function in k-means and also in GMMs in the examples are always very smooth. Even if it might not be practical, is it possible to have a more "bumpy" surface to allow for a kind of soft margin applied in SVM?
  > The k-means will always give an answer. When applied to non-separatable data, the cluster centers may end up at undesirable places.

1. How does k-means deal with new data? For example, discovery of new cell type. This cell type will cluster separately, but if we pre-define the number of clusters then how would we be able to get that separation? Can this be understood looking at clustered data?
  > Your hope is that the data points from the "new" cell type distinguish themselves from the other data points, and the cluster centers. In such case a new clustering with an increased number of components will hpoefully form a cluster around the "new" cell type.

1. Is there any real-world case that we would actually prefer to use k-means instead of GMMs or it is just a simplification that we mainly learn in order to understand GMMS?
  > In general, simpler is preferred over complicated technology, as it is easier to understand what is done. Hence k-Means are much more frequently used than GMMs in life science.


## *k*-means vs. GMMs
1. - K-means is less complex than GMM (it doesn’t allow for covariance and probability of assignment measurement) and is slow for large datasets. With this in mind, in which cases would K-means be preferred over GMM?
1. - The Gaussian Mixture Model in the simple cases it could work like kmeans, so why wouldn't we just used the GMM is all the cases?
  > There is no real reason for not always using GMMs, as far as I know. The theory of k-means is simpler I guess. Also GMMs have a different historical background.

1. I can know how k-means used step by step, but I cannot know how GMM is used exactly. Can you give an example of GMM algorithm ?
   > I will not cover the exact algorithm for GMMs. It, however, is similar to the k-Means, in that it in its standard form is a EM algorithm. Here is wikipedias description of the mathematical formulation of [GMMs](https://en.wikipedia.org/wiki/Mixture_model#Gaussian_mixture_model).



## Starting positions of cluster means in k-Means

1. I assume that it is possible that a different starting position for the randomly chosen cluster centers k at the beginning can lead to different outcomes. Is it therefore helpful to repeat the k-means clustering several times and then choose the most frequent scenario?
   > Yes, that is the prefered way to cluster data.

1. If a data point is situated exactly between two cluster centers, where will it go?
  > That will seldom happen. And if it does, it would be dependent on the implementation, as there is no rule for such situations.

1. In the K-means calculation, the command random_state is set to 0. when changed, the orientation of the clusters change. Why does this happen? What does the command Random_state do?
    > The variable `random_state` sets the [radom seed](https://stackoverflow.com/questions/28064634/random-state-pseudo-random-number-in-scikit-learn) for the operation. This assures the same random numbers being selected each time the code is executed.

1. In the In Depth: k-Means Clustering text they state that k-means sometimes has problem finding the globally optimal configuration and it's common to let the algorithm run for several starting guesses, e.g. Scikit-Learn used 10 starting guesses as default. But after doing several runs with different starting guesses how do the model chose which starting guess had the most globally optimal configuration?
      > This is normally done by investigating the likelihood of the data.

## Selection of *k* in *k*-Means

1. - For determining K in K-means clustering, is there a preferred strategy?
   - In k-means clustering, the number of centroids are randomly assigned. How do we determine the number of centres to be used? Also, do larger number of centroids lead to overfitting?
  > No, in *k*-means we provide the number of clusters, *k*, as an input parameter.  There is no rule for how to select *k*. Also, there is no good way to define overfitting, in the context of *k*-means clustering.

## *k*-means

1. In k-means clustering, the outliers could "drag" clustering centers and a number of outliers might get their own cluster. How does k-mean clustering algorithm avoid these kind of errors?
 > It can not overcome such problems. However, most of the times, there are more non-outliers than outliers in the data, and hence the cluster centers will be relatively stable.


## Selection of the number of components for GMMs

1. The VaderPlas article about Gaussian Mixture Models mentions methods like AIC and BIC to choose the optimal number of components to use, but these are chosen for optimal density estimation and not clustering. Does using Dirichlet Process Prior use the optimal number of components for density estimation too or is it more suited for clustering?
  > Yes it do optimize the number of selected components. It is just a relatively reasent introduction to the library, so VanderPlas dont mention Dirichlet Processes for GMMs. However, as this is great software, I added it to the notebook.

1. While the VaderPlas article says nothing about the Dirichlet Process GMMs, the Wikipedia article on Dirichlet processes mentions clustering a lot.
  > Much of the workings of the algorithm is given in the documentation of [sk-learn](https://scikit-learn.org/stable/modules/mixture.html#bgmm)

1. I have a hard time to fully understand the clustering in the last step of the "cluster_brca": "We use the same technique, however instead of clustering our 20,000 dimensional data, we select a subset of 16 known cancer associated genes." I guess my biggest confusion is what the "subset" (.fit(Xlim)) of the genes means actually means. We have a maximum roof of 30 clusters, from that we get 11 clusters (left part of the output table) and samples (right part of the output table) but how/where does the subset of genes come in the picture?
  > Out of all the genes tetsed, we just select the genes that are listed in the list "brca_names". That is what I mean bu a "subset of 16 ... genes." Generally, when you run into problems with understanding the code,  try to print variables, lists and dataframes, to see what they contain in different parts of the execution.

1. Is the reason for using Variational inferences of the number of components in the "In Depth: Gaussian Mixture Models" section that you want to avoid over-fitting?
    > No, it is just to get a reasonable estimate of the number of components.

1. The start point of cluster centers can have an important impact on final clustering result. How to make it more precise? And how to confirm the number of cluster centers?
  > Neither of the questions have a good answer. What helps is running the algorithm a couple of times and check the clusters consistency.


## Covariance matrices in GMMS

1. In the VaderPlas page about GMMs and to choose covariance type they say "...it is essential to set this carefully for any given problem.",  but I feel that they do not really state when to use what. Are there any rules/guidelines for when to choose the different types of covariance? Can you predict this before doing your clustering?
  > It depends on how your features behave. Check the sklearn documentation for [GMMs](https://scikit-learn.org/stable/modules/generated/sklearn.mixture.GaussianMixture.html), particularly in the description of  *covariance_type*.  If you don't know, you should probably try to plot the relationship between a couple of their variables.

1. For the Gaussian Mixture Models, I understand that the result is a probabilistic model that describes the distribution of the data, but did not understand how the co-variance hyperparamter fits into this. It seemed from the VanderPlas reading that this parameter is set manually, if so, how is the optimal co-variance decided on?
    > The covariation matrix is estimated for each component separately.



## Global optimality
1. How would you determine which clustering method works best? Just trial and see if it works? Are there any methods that consistently outperform others or are favored in certain situations?
  > Just trial and error. You check the clusters, and see if they make sense to what you would expect. Also, you should try to build in any prior knowledge into the features or your clustering method. That said, there are [couple of metrics that people use](https://en.wikipedia.org/wiki/Determining_the_number_of_clusters_in_a_data_set)
like [silouette analysis](https://scikit-learn.org/stable/auto_examples/cluster/plot_kmeans_silhouette_analysis.html). None of these are guaranteed to single out one single optimal solution.

1. What is meant by using cross-validation to avoid over-fitting, when applying GMM to evaluate the likelihood of the data under the model?
  > When you use GMMs as density estimators, their goodness of fit can be evaluated using the datapoints likelihood. This in turn can be used for evaluating an optimal number of components. However, when doing so, one need to regularize using AIC or BIC as demonstrated in the [example](https://jakevdp.github.io/PythonDataScienceHandbook/05.12-gaussian-mixtures.html#How-many-components?), or one use cross-validation or separate train and test datasets.  


1. In VaderPlas it says that the globally optimal result may not be achieved in k-means clustering, since particular starting guesses may lead to poor results. It also says that this is solved by letting the algorithm to be run for multiple starting guesses. By this, I guess that the globally optimal result is much more likely to occur (i.e. it is obtained for a majority of the starting guesses)? And that the globally optimal result is chosen based on this likelihood? If not, how is the globally optimal result chosen out of the clustering results? And how many starting guesses should be applied in order to ensure a globally optimal result?
  > There is no real good way to evaluate how good a clustering is if no labeled data is available. However, minimisation of the "Sum of squared distances of samples to their closest cluster center", i.e. the remaining variation is frequently used.

1. - How is the accuracy score calculated after k-means clustering? Are we assigning gold standard datapoints?
1. - I understood that since the GMM can also measure uncertainty assigning the datapoints in clusters as well as allowing the cluster boundaries to be elipses instead of only spheres, it should give more accurate results than kmeans clustering. This is not the case in the breast cancer notebook. Why?
  > It is hard to give an exact reason. There is, however, no real reason to believe that  the data should cluster in any particular way. Hence there we can not say that the results are more or less accurate, they just cluster the things we want them to cluster or they don't. That is not the same thing as accuracy.

1. One disadvantage of the E-M procedure mentioned is that, there is no assurance that it will lead to a global best solution . What exactly does global best solution mean in this context ?
  > The solution with the globally highest likelihood.

1. In the VanderPlas article about k-Means clustering, it is stated that the algorithm fails to divide data points when the geometry of the clusters is not linear. How can one know that the observation values will adopt non-linear cluster geometries?
  > There is no general answer to the. You need excessive analysis and plotting of variables to find out if there are non-linear relationships in your data.




# Kernels in clustering
1. Is there implementations of *k*-means clusters using kernels?
  > Yes, *k*-means clustering can operate in kernel space, e.g. [kernel *k*-means](https://sites.google.com/site/dataclusteringalgorithms/kernel-k-means-clustering-algorithm) do so.

1. - In reading assignment number 2 they explain that they kernelize the k-means by using the graph of the nearest neighbours to compute a higher-dimensional representation of the data, and then assigns labels using a k-means algorithm. I have a hard time understanding how they did this, is there a way to explain this with words and not just code, or could you explain what the code does ?
   - From the VaderPlas section: I have a hard time grasping how the Kernel works in this context. In SVM, the kernel transforms the data and projects it to higher dimension space. Here, it seems as though the data remains intact, but some kind of transformation to higher space has occurred. Can you please explain how this works?
   - VanderPlas suggests using kernels to transform the data to a higher dimensionality space, so that the data points can be linearly separated in this new context. In the example presented in the article, the ‘SpectralClustering estimator’ is used to transform the data. How does this work?
   > In the example given they called the function [sklearn.cluster.SpectralClustering](https://scikit-learn.org/stable/modules/generated/sklearn.cluster.SpectralClustering.html). The function use the same type of RBF kernel as an SVM, and forms its clusters in kernel space rather than among the input space. As said previously, we do not cover kernels in details in this course.  

1. Does the use of kernels allow for non-circular clusters during k-means clustering?
   > Yes they do.



## Bayesian GMMS

1. It seems reasonable to use the Bayesian variant of GMMs, since the number of clusters don't have to be chosen beforehand, are there any cases where that approach isn't possible?
 > Yes this is my interpretation as well. However, as VanderPlas writes for another technique to select the number of components: "Notice the important point: this choice of number of components measures how well GMM works as a density estimator, not how well it works as a clustering algorithm. I'd encourage you to think of GMM primarily as a density estimator, and use it for clustering only when warranted within simple datasets." That note applies here as well.

1. What is a suitable number of clusters for a Bayesian Gaussian mixture model? How is the number selected for a Bayesian Gaussian mixture model?
  > The point of the Bayesian GMM procedure is that you just have to select an upper bound for the number of clusters, and the procedure will then select an optimal number for you.

1. - How does the Bayesian part of GMM work, and what is it exactly?
   - What is a Dirichlet process?
   - I really didn´t understand the way that the optimal number of components is being calculated in the breast cancer notebook.
  > You will need quite a lot of probability theory to understand how a [Dirichlet process](https://en.wikipedia.org/wiki/Dirichlet_process) is working. I included the example to make you see that there is technology available that can help you solve the important problem of how to best select the number of components.

1. How is sklearn's BayesianGaussianMixture different from using BIC/AIC (a part for the fact that you have to set a maximum number of components)? Also, how is it that in the last given example, some of the recognized clusters only contain 1 or 2 data-points? It doesn't look like a likely outcome to me. Is it because the setting "n_components=30" was excessively high?
    > It is just another algorithm to do the same thing in a different way.


## Visualisation

1. Some cluster boundaries in a simple 2d visual representations can be easily shown to have geometries in a nonlinear pattern.
How do one determine the existence of nonlinear patterns where it's not as obvious, e.g. a more complicated 2d representations or representations in higher dimensions?
  > This is indeed hard with linear transformations. A couple of resent techniques are frequently used for dimensionality reduction for the purpose of visualization. These include [t-SNE](https://en.wikipedia.org/wiki/T-distributed_stochastic_neighbor_embedding) , [UMAP](https://umap-learn.readthedocs.io/en/latest/basic_usage.html), and some other [manifold learning techniques](https://scikit-learn.org/stable/modules/manifold.html).

## Python
1
. In VaderPlas, at first we don’t know how much clusters should be, so it set rseed=2, how can we find the final number of clusters, I cannot understand this part of coding. In Jupyter Notebook, it set k-means clustering with k=2, how to choose appropriate k for different data sets?
  > rseed is just the [random seed](https://en.wikipedia.org/wiki/Random_seed), so it does not relate to *k*. There is no real good method to select *k*.

1. In the VanderPlas chapter on GMM, the section "Generalizing E-M: Gaussian Mixture Models", I don't quite understand the code chunk [10] (where two functions are defined). The plots that are generated from this contain "double" circles or ellipses, at what point in the definition of the functions is this specified, and what does the inner and outer border signify, respectively?
  > They are actually three circles. Check the ``draw_ellipse(...)`` function, the iteratively increasing parameter ``nsig`` is just a multiplicative factor to the covariance components.

## Breast Cancer example
1. In the notebook you used only two k-means clusters. In practice, would you attempt different numbers?
  >  I would first of all try to figure out for myself what I want to accomplish with my clustering. If there is a clear reason for why we would see two clusters, then *k=2* is a good choice.

1. In the example presented in the Jupyter notebook:
  Why/how was it decided that (only) two clusters would be used? How can the optimal number of clusters to be used be determined/evaluated?
  > I wanted to evaluate what the most natural division of the dataset was when using 2 components. Hence, I selected k=2. When you yourself rerun the example, what happens when you select another value of k? Did you find other types of outcomes?

1. It is said that the Gaussian Mixture model is more powerful than the K-means clustering, but why in the notebook it did not get a  more clear separation for  Progesterone receptor Negative and Estrogen receptor Negative patients than the k-means clustering?
    > The GMM gave a different clustering than the k-means. The k-means clustering was co-insiding with some labels I assigned to the data in a better way than the GMM.

1. The GMM approach is presented as a method that overcomes the limitations of k-means clustering. But in the notebook, the GMM approach does not appear to be able to provide a clear separation between samples that are ER and PR negative, and those that are not. How can this be explained?

























1
