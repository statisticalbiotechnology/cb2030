# Questions and Answers on Clustering.

## *k* means vs GMMs

1. * Could you provide instances when one can decide which method to follow for clustering between GMMs and k-means? The paper seems to suggest GMMs as the preferred approach.
   * GMM seems to be superior over k-means clustering. Are there situations in which the use of k-means clustering offers an advantage over GMM?
   * Due to the high amount of errors probable, it seems that it's smarter to use other methods such as GMM instead of k-means clustering on real-world data. Is there any occasion where we would prefer using k-means clustering instead of GMM for non-ideal data?
> Yes. k-means is a simpler and faster algorithm, and is hence more popular,

1. What are the differences between a spherical covariance model using GMM and a k-means result? Both of them would result in a circular (or spherical) cluster, but it is mentioned that while they have a similar outcome, there are differences.
> They are very similar in behavior. One difference, though, is that you get probabilities for the points in a GMM, but not in k-means.

1. Do you use GMMs if the results of the k-means does not make a lot of sense, such as if the clustering seems wrong, or is GMMs the preferred method?
> No there is no rule for this.

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

1. If the k-means algorithm is not effective for clustering our data set, in which cases should we proceed with PCA and when with a Gaussian mixture model?
> FIXME

1. When we should use dimension reduction before applying either k-Means clustering or GMMs? When we are not necessary to do the dimension reduction?
> FIXME


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

1. From the reading material, I understood that *k*-means is a simpler clustering method than Gaussian Mixture Models (GMM). However, in the notebook the separation between the two cases is more clear for the k-means clustering. Why is the separation of the PR-ER- patients less clear when using GMM?
> It can be a random effect. There is nothing saying that there should be a separation into PR-ER- patients in the first place, so we would not know which is the better result at this point.

1. In the Jupyter notebook, we saw that the Gaussian Mixture Model algorithm had a less clear separation of the PR/ER negative and PR/ER positive samples than the k-means algorithm. However, in the VanderPlas text, I interpreted it as GMM was superior to k-means clustering. Should we trust the outcome from the GMM clustering more even though it did not generate a good separation? If not, how do we know which method to use? Should we always try with both clustering methods?
> You can always try with both methods.
