# Questions and Answers on Clustering.

1. In the notebook when log-transforming the data, the base 2 logarithm is used, while the natural logarithm was used in the notebook for linear models. Any base works to transform log-normal data to normally distributed data (according to Wikipedia), so is the choice of base here artbitrary or is there any reason you use different bases?
  > No this is entirely an arbitrary choice.  Infact, they are just a scalar factor from each other as, *log<sub>a</sub>(x)= log<sub>b</sub>(x)/log<sub>b</sub>(a)*

1. The VaderPlas article about Gaussian Mixture Models mentions methods like AIC and BIC to choose the optimal number of components to use, but these are chosen for optimal density estimation and not clustering. Does using Dirichlet Process Prior use the optimal number of components for density estimation too or is it more suited for clustering?
  > Yes it do optimize the number of selected components. It is just a relatively reasent introduction to the library, so VanderPlas dont mention Dirichlet Processes for GMMs. However, as this is great software, I added it to the notebook.

1. While the VaderPlas article says nothing about the Dirichlet Process GMMs, the Wikipedia article on Dirichlet processes mentions clustering a lot.
  > Much of the workings of the algorithm is given in the documentaion of [sk-learn](https://scikit-learn.org/stable/modules/mixture.html#bgmm)

1. There are advantages of unsupervised learning over supervised learning in terms of use of labels but people still continue use supervised learning. Thus, what kind of cases or data is convenient to use in supervised learning but not in unsupervised and vice versa?
   > Supervised leaning is more efficent when labels are available. However , in many applications we just dont have labels -- then clustering is helpful.

1. I assume that it is possible that a different starting position for the randomly chosen cluster centers k at the beginning can lead to different outcomes. Is it therefore helpful to repeat the k-means clustering several times and then choose the most frequent scenario?
   > Yes, that is the prefered way to cluster data.

1. In the video you mention that when using supervised learning, you lose the ability to do statistical testing, could you explain this a bit further?
  > Once you used the labels for training, you can not use them for testing. In the notebook for supervised learning, we used our labels to train a perfect separation between PR+/- patients. If we would have used the same labels for assigning confidense of the predictions, we would have said that we had full confidence in our prediction, which in that case was the wrong .


1. I have a hard time to fully understand the clustering in the last step of the "cluster_brca": "We use the same technique, however instead of clustering our 20,000 dimensional data, we select a subset of 16 known cancer associated genes."
I guess my biggest confusion is what the "subset" (.fit(Xlim)) of the genes means actually means. We have a maximum roof of 30 clusters, from that we get 11 clusters (left part of the output table) and samples (right part of the output table) but how/where does the subset of genes come in the picture?
  > Out of all the genes tetsed, we just select the genes that are listed in the list "brca_names". That is what I mean bu a "subset of 16 ... genes." Generally, when you run into problems with understanding the code,  try to print variables, lists and dataframes, to see what they contain in different parts of the execution.

1. In VaderPlas it says that the globally optimal result may not be achieved in k-means clustering, since particular starting guesses may lead to poor results. It also says that this is solved by letting the algorithm to be run for multiple starting guesses. By this, I guess that the globally optimal result is much more likely to occur (i.e. it is obtained for a majority of the starting guesses)? And that the globally optimal result is chosen based on this likelihood? If not, how is the globally optimal result chosen out of the clustering results? And how many starting guesses should be applied in order to ensure a globally optimal result?
  > There is no real good way to evaluate how good a clusterinhg is if no labeled data is available. There are a couple of metrics that people use, like [silouette analysis](https://scikit-learn.org/stable/auto_examples/cluster/plot_kmeans_silhouette_analysis.html) , however, these are seldome conclusive. So yes, frequently reocuring clusters for multiple runs, are often prefered over clusters that just apear in one bout of clustering.

1. If a data point is situated exactly between two cluster centers, where will it go?
  > That willl seldom happen. And if it does, it would be dependent on the implementation, as there is no rule for such situations.

1. In the VaderPlas page about GMMs and to choose covariance type they say "...it is essential to set this carefully for any given problem.",  but I feel that they do not really state when to use what. Are there any rules/guidelines for when to choose the different types of covariance? Can you predict this before doing your clustering?
  > It depends on how your features behave. Check the sklearn documentation for [GMMs](https://scikit-learn.org/stable/modules/generated/sklearn.mixture.GaussianMixture.html), particularly in the description of  *covariance_type*.  If you dont know, you should probably try to plot the relationship between a couple of ther variables.

1. Some cluster bounderies in a simple 2d visual representations can be easily shown to have geometries in a nonlinear pattern.
How do one determine the existance of nonlinear patterns where it's not as obvious, e.g. a more complicated 2d representations or representations in higher dimensions?
  > This is indeed hard with linear transformations. A couple of resent techniques are frequently used for dimensionality reduction for the purpose of visualization. These include [t-SNE](https://en.wikipedia.org/wiki/T-distributed_stochastic_neighbor_embedding) , [UMAP](https://umap-learn.readthedocs.io/en/latest/basic_usage.html), and some other [manifold learning techniques](https://scikit-learn.org/stable/modules/manifold.html).

1. In k-means clustering, the number of centroids are randomly assigned. How do we determine the number of centres to be used? Also, do larger number of centroids lead to overfitting?
   > No, in *k*-means we provide the number of clusters, *k*, as an input parameter.  There is no rule for how to select *k*. Also, there is no good way to define overfitting, in the context of *k*-means clustering.

1. In the K-means calculation, the command random_state is set to 0. when changed, the orientation of the clusters change. Why does this happen? What does the command Random_state do?
  > The varaiable sets the [radom seed](https://stackoverflow.com/questions/28064634/random-state-pseudo-random-number-in-scikit-learn) for the operation. This assures the same random numbers being seected each time the code is executed.

  1. Is there implementations of *k*-means clusters using kernels?
    > Yes, *k*-means clustering can operate in kernel space, e.g. [kernel *k*-means](https://sites.google.com/site/dataclusteringalgorithms/kernel-k-means-clustering-algorithm) do so.

  1. Is the reason for using Variational inferences of the number of components in the "In Depth: Gaussian Mixture Models" section that you want to avoid over-fitting?
    > No, it is just to get a reasonable estimate of the number of components.

  1. The Gaussian Mixture Model in the simple cases it could work like kmeans, so why wouldn't we just used the GMM is all the cases?
    > There is no reason for that, as far as I know. The theory of k-means is simpler I guess. Also GMMs have a different historical background.

  1. - How is the accuracy score calculated after k-means clustering? Are we assigning gold standard datapoints?
  1. - I understood that since the GMM can also measure uncertainty assigning the datapoints in clusters as well as allowing the cluster boundaries to be elipses instead of only spheres, it should give more accurate results than kmeans clustering. This is not the case in the breast cancer notebook. Why?
     > It is hard to give an exact reason. There is, however, no real reason to beleave that  the data should cluster in any particular way. Hence there we can not say that the results are more or less accurate, they just cluster the things we want them to cluster or they dont. That is not the same thing.

  1. I really didn´t understand the way that the optimal number of components is being calculated in the breast cancer notebook.
    > You will need quite a lot of probability theory to understand how a [Dirichlet process](https://en.wikipedia.org/wiki/Dirichlet_process) is working. I included the example to make you see that there is technology available that can help you solve the important problem of how to best select the number of components.

  1. In the VanderPlas chapter on GMM, the section "Generalizing E-M: Gaussian Mixture Models", I don't quite understand the code chunk [10] (where two functions are defined). The plots that are generated from this contain "double" circles or ellipses, at what point in the definition of the functions is this specified, and what does the inner and outer border signify, respectively?
    > They are actually three circles. Check the ``draw_ellipse(...)`` function, the iteratively increasing parameter ``nsig`` is just a multiplicative factor to the covariance components.

  1. In the notebook you used only two k-means clusters. In practice, would you attempt different numbers?
    > Yes, one should try a couple of different clusterings, before selecting one.

  1. How would you determine which clustering method works best? Just trial and see if it works? Are there any methods that consistently outperform others or are favored in certain situations?
    > Just trial and error. You check the clusters, and see if they make sense to what you would expect. Also, you should try to build in any prior knowledge into the features or your clustering method.
