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
   - The Gaussian Mixture Model in the simple cases it could work like kmeans, so why wouldn't we just used the GMM is all the cases?
  > There is no real reason for not always using GMMs, as far as I know. The theory of k-means is simpler I guess. Also GMMs have a different historical background.

1. I can know how k-means used step by step, but I cannot know how GMM is used exactly. Can you give an example of GMM algorithm ?
   > I will not cover the exact algorithm for GMMs. It, however, is similar to the k-Means, in that it is an EM algorithm. A GMM is, however, probabilistic in its formulation, while *k*-means can, but does not have to be probabilistic. Here is wikipedias description of the mathematical formulation of [GMMs](https://en.wikipedia.org/wiki/Mixture_model#Gaussian_mixture_model).

1. It seems reasonable to use the Bayesian variant of GMMs, since the number of clusters don't have to be chosen beforehand, are there any cases where that approach isn't possible?
  > Yes this is my interpretation as well. However, as VanderPlas writes for another technique to select the number of components: "Notice the important point: this choice of number of components measures how well GMM works as a density estimator, not how well it works as a clustering algorithm. I'd encourage you to think of GMM primarily as a density estimator, and use it for clustering only when warranted within simple datasets." That note applies here as well.


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
  > Yes the procedure optimizes the number of selected components. It is just a relatively resent introduction to the library, so VanderPlas don't mention Dirichlet Processes for GMMs. However, as this is great software, I added it to the notebook.

1. While the VaderPlas article says nothing about the Dirichlet Process GMMs, the Wikipedia article on Dirichlet processes mentions clustering a lot.
  > Much of the workings of the algorithm is given in the documentation of [sk-learn](https://scikit-learn.org/stable/modules/mixture.html#bgmm)

1. I have a hard time to fully understand the clustering in the last step of the "cluster_brca": "We use the same technique, however instead of clustering our 20,000 dimensional data, we select a subset of 16 known cancer associated genes." I guess my biggest confusion is what the "subset" (.fit(Xlim)) of the genes means actually means. We have a maximum roof of 30 clusters, from that we get 11 clusters (left part of the output table) and samples (right part of the output table) but how/where does the subset of genes come in the picture?
  > Out of all the genes tested, we just select the genes that are listed in the list "brca_names". That is what I mean bu a "subset of 16 ... genes." Generally, when you run into problems with understanding the code,  try to print variables, lists and dataframes, to see what they contain in different parts of the execution.

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
   > In the example given they called the function [sklearn.cluster.SpectralClustering](https://scikit-learn.org/stable/modules/generated/sklearn.cluster.SpectralClustering.html). The function use the same type of RBF kernel as an SVM, and forms its clusters in feature space (the space of the kernel converted features) rather than in the input space. As said previously, we do not cover kernels in details in this course.  

1. Does the use of kernels allow for non-circular clusters during k-means clustering?
   > Yes they do.



## Bayesian GMMS

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

## *k* means vs GMMs

1. * Could you provide instances when one can decide which method to follow for clustering between GMMs and k-means? The paper seems to suggest GMMs as the preferred approach.
   * GMM seems to be superior over k-means clustering. Are there situations in which the use of k-means clustering offers an advantage over GMM?
   * Due to the high amount of errors probable, it seems that it's smarter to use other methods such as GMM instead of k-means clustering on real-world data. Is there any occasion where we would prefer using k-means clustering instead of GMM for non-ideal data?
> Yes. k-means is a simpler and faster algorithm, and is hence more popular,

1. What are the differences between a spherical covariance model using GMM and a k-means result? Both of them would result in a circular (or spherical) cluster, but it is mentioned that while they have a similar outcome, there are differences.
> They are very similar in behavior. One difference, though, is that you get probabilities for the points in a GMM, but not in k-means.

1. From the reading material, I understood that *k*-means is a simpler clustering method than Gaussian Mixture Models (GMM). However, in the notebook the separation between the two cases is more clear for the k-means clustering. Why is the separation of the PR-ER- patients less clear when using GMM?
> It is hard to say. Probably it is just due to random chance.

1. Do you use GMMs if the results of the k-means does not make a lot of sense, such as if the clustering seems wrong, or is GMMs the preferred method?
> No there is no rule for this.

1. In the Jupyter notebook, we saw that the Gaussian Mixture Model algorithm had a less clear separation of the PR/ER negative and PR/ER positive samples than the k-means algorithm. However, in the VanderPlas text, I interpreted it as GMM was superior to k-means clustering. Should we trust the outcome from the GMM clustering more even though it did not generate a good separation? If not, how do we know which method to use? Should we always try with both clustering methods?
> You can always try with both methods.

1. Could it be possible to somehow assign a probability of a point belonging to a cluster in k-means similarly as for GMM?
> Not without making more assumptions about your data.

1. Is Gaussian Mixture Model more befitting than k-means model just because of cluster shape and lack of probabilistic cluster assignment? My understanding says GMM also faces similar limitations.
> I did not understan what you mean with "similar limitations".


## Features of *k* means.

1. In K-Means clustering, is there a scenario where a new cluster is added in the estimation-maximization steps. That is are the E and M steps only for better estimation of the currently present clusters or can they introduce new clusters as well?
> No, in the standard implementation *k* is fix.

1. How much is the running time of the algorithm affected by the strating guesses in k-means clustering?
 > The starting guess might effect the number of iteration you have to d before converging.

 1. In case of the k-means clustering: Is there a way to find out that the k-means clustering is not a good model for clustering due to overlapping clusters by algorithms?
 > By definition, K-means clusters do not overlap.

1. Once surpassed the linear boundaries of k-means with the kernel transformation proposed by the support vector machines, which would be the next bottleneck or limit to take into account while clustering?`
 > Not sure I know.


## Selecting number of clusters

1. * Before K-means does clustering, we must first determine K which is the number of clusters in the sample. What are the general methods to determine k?
  * When choosing the optimal number of components for GMM,  analytic criterions such as AIC or BIC is used. Is there a similar method for choosing the optimal number for k-means clustering?
> There are no relly good methods for this. However, there are some heuristics avalable such as [silouette plots](https://scikit-learn.org/stable/auto_examples/cluster/plot_kmeans_silhouette_analysis.html)

1. In In Depth: Gaussian Mixture Models, it is said that the choice of number of components with AIC or BIC criterion can only reflect how well GMM works as a density estimator, but not as a clustering algorithm. Why would the optimal number be different between the two uses?
> FIXME

1. Regarding the number of components in GMM, the text mentionts that "as is typical with this sort of problem, the BIC recommends a simpler model". When selecting a correction method (AIC, BIC) to calculate the optimal number of components, is it important to have background information or predictions about the dataset?
> Not sure what you mean with "background information". FIXME

1. * Is a GMM with a Dirichlet process prior the only clustering method we can use when we're not able to specify k?  Do we need to know how the Dirichlet process works?
  * Should we know for the exams how Dirichlet Process Priors work to find the number of clusters, or is it okay to know just that it can work in conjunction with GMM to automatically select k?
> If there are more students that want us to include the theory of Dirichlet Processes in the exam, I can always do so. Let me know if that is the case and I will try to make room for a deep dive into the subject.

1. Could you explain why k-means clustering can not predict how many clusters the data set need? Intuitively, I feel that the code for this should not be to complex?
> I disagree. Intuitively this sounds hard.

1. k-means clustering method is not able to select the number of clusters. As far as I understand this is not possible with GMM either. How do we arrive at the appropriate number of clusters for data sets where it is not obvious by visuals only? And what are other clustering methods that are available that can predict the number of clusters using an algorithm without us having to choose?
> There are some heuristics for this, and there are other clustering algorithms available.

1. It's said in Vanderplas notebooks "In Depth: Gaussian Mixture Models" that k-Means method is not flexible enough for many datasets especially low-dimensional datasets, and also said, "GMMs can have difficulty converging in such a high dimensional space(64 dimensions)".  
In my understanding, that means that both methods are only suited for a certain range of dimension, and the K-means method is not suitable for low-dimensional datasets, while GMMs have better applicability for wider dimensions range, but when the dimensions are larger to like 64 dimensions, then we need to use dimension reduction for both methods?
> No, I do not think there is such a rule.


## EM algorithm
1. In the section on k-means, VanderPlas states that 'undertypical circumstances, each repetition of the E-step and M-step will always result in a better estimate of the cluster characteristics.' What would be an untypical scenario in this case?
> I am not sure myself. However, the [EM algorithm](https://en.wikipedia.org/wiki/Expectation%E2%80%93maximization_algorithm) is guaranteed to not decrease the expected log-likelihood in each iteration.
  * Moreover, does a practical maximum number Expectation-Maximisation cycles exist, after which the process is ended without reasonable cluster generation  (when employing E-M on a dataset witout any apparent cluster, for instance equidistantly ordered items )?
> There will always be k clusters after the alg. ends.

## Properties of GMMs
1. In GMM, how is the probability of a point belonging to a cluster calculated?
  > You just compare the intensity of the current "cluster's" gaussian distribution to the other "clusters'" distributions.

1. * In the text In Depth: Gaussian Mixture Models the author state that it is essential to set the hyper-parameter covariance type carefully for any given problem. Do every problem/data set have an optimal covariance type and if so how do you decide/choose which covariance type to use for your data?
     * How do we choose which covariance type to use on our GMM clustering model?
  > You calculate the covariation and variance between points i a cluster, and try to convince yourself what the covariation structure looks like.  

1. Can you kernelize the data in GMMs as you did with the k-means? Would that help in the number of components the GMMs need?
  > I have not tried to do so myself, but [others](https://arxiv.org/abs/1608.00550) seem to do so.

  1. From GMM, one of the disadvantages of this model is having insufficiently many points per mixture which makes it difficult to estimate the covariance matrices, and the algorithm is known to diverge and find solutions with infinite likelihood unless one regularises the covariances artificially. How can we adjust the covariances artificially? can you give us some examples?
  > One use [regularization](https://en.wikipedia.org/wiki/Regularization_(mathematics)) to keep the covariation matrix from taking extreme values.



## GMMs as estimators

1. In-Depth: Gaussian mixture models, GMM is also used for estimation besides the clustering. Could you clarify the example of GMM for generating new data? In my mind, GMM could just cluster the different groups, why could the new data be generated during clustering, if that means the data is rearranged by GMM? If so, could GMM be used as a tool that provides us with lots of data for training or testing the algorithm, such as cross-validation?
> GMMs are great to mimic general probabilistic distributions, and are hence frequently used in [Bayesian modelling](https://en.wikipedia.org/wiki/Mixture_model#Examples).

1. Using several Gaussians in GMM to create a density estimator of a dataset would create peaks at each cluster center. The number of peaks would change with the number of cluster centers. This seems to create artificial probability “hotspots” that were not present in the original data. Could this be an issue, and if so - how can it be solved? (Ideally, only one probability distribution would exist for one group of data.)
> Not sure I understand. FIXME.

1. GMM is considered to be more of a density estimator rather than a clustering method. Why is GMM only used as a clustering method when the data set is simple?
> Because it is a nice algorithm.



## Global vs. local optima
Here is a wikipedia entry on [local optima](https://en.wikipedia.org/wiki/Local_optimum)


1. * In order to find a global optimum, we have to run the algorithms multiple times. Is there a way to predict an optimal number of repetitions so that there is a high probability of finding the global optimum and at the same time the process is not computationally exhaustive?
  * As stated by VanderPlas in the section on k-means clustering, multiple starting guesses are often used in order to find a good configuration. It is mentioned that the default setting in Scikit-Learning is running the algorithm for 10 guesses. Is this number generally enough? What should we consider when choosing the number of starting guesses?
  > No, this is problem dependent, and you have to try for yourself and see.

2. It is mentioned that clustering might result in a local, but not global minimum and that we can address this by choosing different starting points. Is there any way to assess whether we actually found the global minimum? Or would we just assume that when the same / a similar result is obtained with different starting points, the global minimum is found?
  > No there is no way to tell.

1. Convergence does not imply that you have reached the globally optimal clustering. Many k-mean approaches, as well as GMMs, use repeated clustering, based on different starting cluster centers, to obtain different clustering options. If different results are obtained, how is it then determined which clustering to settle for? I assume (but might be wrong) it’s not so easy as to say that the clustering that occurs the most times is always the one that makes the most sense?
  > That is one possible way. You can also evaluate the solutions based on their log-likelyhood.  
  * How can we find the global optimum?
  > You are not guaranteed to do so.

## Benchmarking clusterings
1. When achieving clusters based on a specific method (say i.e. k-means clustering or Gaussian Mixture Models) how sure are we in the end result of the separation of the different clusters? For very simple and separated data points in a sample we can be fairly certain in our result just by the looking at the different clusters achieved by these algorithms, however, say that we now have a very dense population of data points in our sample. How can we estimate (or give scores) of how well the algorithms have performed in separating the data points in different clusters?
> One might benchmark based on labeled examples.

## Supervised vs. Unsupervised ML

1. In which cases/fields/problems is it better to use unsupervised learning like clustering instead of using supervised learning like SVM (because both methods give a separation/classification of the different categories but in different ways)?
> The obvious case for unsupervised ML is when you do not have labels available.

1. You mention in the video that we cannot do statistical testing on models based on supervised learning, why is that, and are there any other advantages of unsupervised learning when compared to supervised learning?
> The reason is that you already have used-up your labels for training. Remember, *never* train and test a supervised ML method on the same data. However, if you would have an independent test set you are free to use statistical testing on your test data.

1. In the notebook we interpret the two k-clusterings as being emblematic of a certain pathological result (in this case Progesterone and Estrogen receptor negative). Do we have any way to separate and compare these clusters patient data if you would want to find such links and if so is there any computational framework for such analysis?
> Hypothesis testing, followed by multiple hypothesis corrections.



## Dimensionality reduction

1. Since the "curse" of dimensionality tends to make the dots equidistant from one another when working with a high number of dimensions, is it better to apply clustering algorithms after dimensionality reduction?
> I am not sure. It could be worth trying.

## Other clustering algorithms
If you want to have a look at other clustering algorithms, [sklearn contain a large set of algorithms](https://scikit-learn.org/stable/modules/clustering.html#k-means).


1. In both k-means clustering and GMMs, there is a risk of data points being added to different clusters by chance (due to overlap e.g.). Are there any other methods that can make sure that this does not happen?
> No, by definition a data point belongs to just one cluster.

1. When would you use kernelized *k*-means and when would you use GMMs? Should you always compare them or is there some benchmarking involved?
> It is hard to benchmark unsupervised ML.

1. In the reading material about the k-means clustering it is claimed that the expectation-maximization algorithm does not achieve the globally optimal result due to poor starting guesses. However, in the book it is said that this problem is dealt with by using multiple starting guesses. My question is if this problem could be dealt with by other means, such as maybe modifying the algorithm in some way or if there are other types of clustering algorithms that are as simple but does not have this problem at all?
> Clustering is always challenging. There are several other clustering algorithms available.

1. In batch-based k-means algorithms, you have to choose a subset of the data to update the cluster centers with at each step. Is this subset chosen randomly?
> Yes, [Mini-batches are subsets of the input data, randomly sampled in each training iteration.](https://scikit-learn.org/stable/modules/clustering.html#mini-batch-kmeans)  


## Notebook
1. In the last example in the notebook ( Cluster analysis of TCGA breast cancer sets ) a subset of cancer associated genes are used instead of all genes for clustering. What are the pros and cons for these two approaches? And how do you choose which genes are most appropriate if you use the subset approach?
> No we use the full stet of patients with a certain PR or ER label. In practice you probably would like to use as much data as possible.
