# Questions and Answers on Clustering.

## k in k-Means (Number of clusters)
* From the k-Means clustering VanderPlas: What determines how many clusters we use? Is this based on the number of expected groups (e.g. sick vs healthy) or can this be something that the software recognizes? Since the algorithm is unsupervised, how do we otherwise determine how many clusters there should be?
   > I believe it could be random or you can select how many if you know the group number.
   The book mentions that the number of clusters must be selected beforehand. 

* The selection of a number of clusters is quite subjective, but silhouette analysis is sometimes applied just for selecting the cluster numbers. Is silhouette analyses not of standard practice when choosing the number of clusters and why? Since it can decipher bad picks for the data, makes one thinks it should be applied all the time when doing k-means clustering. 

* With k-means one needs to select the number of clusters beforehand. Are there any guidelines to follow when selecting how many clusters to form or does one through visual inspection of the data try to estimate the most suitable number of clusters?
   > There are decision methods we can use to determine the optimal number of clusters. The elbow method is usually used for this purpose. If I understand correctly you perform clustering with different values of k / number of clusters. For all k-values, a squared error is calculated (within-cluster sum of squares). The error is related to the distance between the data points and their center and we choose the value of k that gives the largest change/reduction of the error. 

## Inflated number of clusters

The answers to these questions are that we want a cluster to characterize an underlying phenomena. The fact that you can represent your data well with a high number of clustra do not help you to see the actual patterns in your data.


* In the end of VaderPlas on GMMs it says that "...this choice of number of components measures how well GMM works as a density estimator, not how well it works as a clustering algorithm". My question is then if there a way to asses how well it works as a clustering algorithm for a given data set? 

* In both k-means clustering section, VanderPlas uses a moon/crescent-shaped dataset to highlight the problem of clustering data without linear boundaries. The proposed solution is using a kernel transformation and then k-means clustering of the transformed data. I wonder: Would an alternative solution be to simply increase the number of cluster centers, similarly to the proposed solution for the same problem in the GMM section? 
   > Yes, that would work, however, you must then come up with a method to cluster your clusters, just so you can get an interpretable cluster.

* It is mentioned that overfitting in GMM can be corrected for by AIC or BIC, but can overfitting occur in K-means clustering as well? if so, would it imply a too small or large k-value?
  > Overfitting can absolutely occur for K-means clustering as well, and for clustering in general. One example of this is setting a too high k-value (number of cluster centers) such that each and every point in itself becomes its own cluster. Indeed, you would successfully cluster the points, but it would not reflect reality and it would be meaningless to perform the clustering in that case. Overfitting would then only occur for a too large k-value, while a small k-value would lead to underfitting (consider k=1). Another way of overfitting could be having a too high number of starting guesses, which does improve the clustering because you could find the global best solution among the obtained solutions, but this would mean that the clusters are too tightly fit to the training data instead of reality.

* In VaderPlas Gaussian Mixture Model and in the section where data of the make_moon function was used to explain fundamentally, GMMs is actually a density distribution model, initially, they use two GMMs clusters to describe the shape of the moon, but the clusters are not very exact, instead they applied 16 GMM clusters which describes more pricisely the shape, I would like to know whether the cluster centres can be reclustered in this case, for example hierarchically clustering the data as the 16 clusters actually belong to the same cluster.

## Global vs local Optimum

* "First, although the E–M procedure is guaranteed to improve the result in each step, there is no assurance that it will lead to the global best solution... Here the E–M approach has converged, but has not converged to a globally optimal configuration.  For this reason, it is common for the algorithm to be run for multiple starting guesses..."
How does repeating the clustering with different starting guesses for the centers help us find the global optimal configurations? 

* For the k-means clustering in VaderPlas it is mentioned that the E-M procedure might not always lead/converge to the global best solution and therefore the algorithm is run several times with different starting guesses. How do you asses when the global best solution is reached? 

* It is described in the VanderPlas section on k-means clustering that the globally optimal configuration might not always be achieved. This is because the results are depending on the starting guesses and that the algorithm thus should be run multiple times to try different starting guesses. Approximately how many times should be tested to be able to trust the results and how do you select the best clustering if the different runs lead to different results?
   > As many as practical.

* Question: The initial of K means cluster select K points randomly then perform clustering analysis, How can we make sure the clustering result can be repetitive for each time? Or how can we make sure the clustering is reasonable and reliable?

## k-Means

* The first step in k-means clustering is to randomly select cluster centers, but wouldn’t this random selection cause a slightly different clusters being formed every time? 
   > The randomly selected starting points do sometimes lead to different groupings, to combat this the function "Scikit-Learn" use 10 different starting settings as default but it can be changed with n_init. So basically if we runt the EM method with a few different starting points we can hope that the most common end result is the true one.
  
* Also, what type of features can we use for X and Y axis and by whom are these features defined?
   > We can really use a wide array of parameters on the X and Y axis if we want, but a good example could be gene expressed for two different genes. 

* In the video it was mentioned that E-step is a step when points are assigned to the nearest cluster center. I was wondering is there any limit of how many times you can repeat the E-step for a one data set? In the video it was showed an example by repeating the step twice but are there any limitations of using it more times or it depends on every data set and how cluster centers are formed in each step?
   > As I have understood it, there is no quantitative limit to how many times the E-step can be repeated as long as the algorithm hasn’t converged. The E-step (assigning points to the nearest cluster center) is followed by the M-step (updating the positions of the cluster centers), and this is then repeated until the cluster center cannot be moved to a more (locally) optimal position. When an M-step is performed, the cluster centers are moved, and this will mean that a new E-step can be performed to re-assign points to clusters. However, when an M-step can’t be performed, you algorithm stops and you can’t do another E-step since the clusters haven’t changed. In the code this is indicated by the line:   
   > ```if np.all(centers == new_centers):  
            break```   

   > So in the video where the E-step was only done two times, this was because the position of the cluster centers couldn’t be updated any further based on the means of the points in the different clusters. So yes, it depends on the data set and how cluster centers are formed in each step. 


* From in-depth k-mean clustering, do we always need to pre-process the data for k-means and randomize the dataset?
   > No not always, as this is not done in the first example given on the page. It is mentioned however that for large data sets, subsets of the data are used to determine the right cluster centers. I would imagine for for this process, a random set of the total data is considered between different rounds of E/M steps. Pre-processing data depends on the context.

* VaderPlas on k-Means Clustering, k-Means Algorithm: Expectation-Maximization   
  Since E-step involves updating our expectation of which cluster each point belongs to, does the order of the evaluated data points matter during this process? Also, does the error introduced at the beginning get bigger during E-step or is there any control mechanism?
   > I don't think the order matters, since as I understand it you perform the E-step for all data points before proceeding to the M-step. So you don't update the new cluster center until all data points have been assigned to the nearest of the previous cluster centers, i.e. you don't assign one data point and then update, then assign a new data point. If that was the case, the order would have mattered.  
   > In regards to the error, in VanderPlas about k-means clustering it is said that each repetition of the E-step and M-step always results in a better estimate of the clusters, so if I understand your question correctly (i.e. about the error introduced at the beginning being poor starting guesses), I would say that the error gets smaller rather than bigger each step but we often end up in local minima instead of global minima at convergence.


* How does one select a kernel method for k-means clustering? How do we go from looking to our data and finding an appropriate kernel to transform the data? Can it always be applied when the data is non-linear, or does it need to meet certain characteristics? 

* I think it should be the same as for the SVM where you generally just have to try different kernel functions to see if something works. Maybe some characteristic of the data can be used to infer if some kernel fucntion would work better as in the case under the Beyond linear boundries: Kernel SVM section in the article In-Depth: Support Vector Machines. A kernel function could always be applied but for it to help with separatation, the datapoints need some pattern that can be emphasized by the kernel function to achieve the separation. If no such pattern exists then a kernel function would not be able to help with clustering. 

* VanderPlas in depth learning: k-means clustering gives an example of where an applied kernel function gives a better clustering results than before. What cases are the limitations in the apliccability of a kernel  function?    

* In the reading material about k-means, what is the criterium to select to subset the data to make k-means runs faster? And would subsetting alter the clusters of the final result?


* Is it possible to perform the k-means clustering for 3 features simultaneously in 3D instead? If yes, will this make kernel application more difficult, since the degree of dimensions increases?
  > Yes, and kernels work well for 3d space as well.


## GMMs

* I read somewhere that in GMM a whole dataset is considered to be composed of several Gaussian distribution variables and the weight of each distribution is what it calculates. How can we relate Gaussian distribution to 2D data points in order to solve this clustering problem?
  > A GMM uses [multinormal distributions](https://en.wikipedia.org/wiki/Multinomial_distribution), i.e. they are gausian in N-dimensions.


* Regarding to GMMs, How does GMMs weight each feature?
   > By selectting the variation of each axis independently. 

* On the topic of GMMs, if I understand correctly each cluster will be represented by individual Gaussian distributions. So in the E-step, how do you decide from which distribution a data point was originally generated? I assume it has to do with the probabilistic model contained in the GMM, but how does it operate?

* Since GMM is a probabilistic model that learns the distribution rather than clustering the data, does it have to have an unfixed number of components/clusters? Or if you know your input dataset originates from a certain number of distributions can you train the model using this predetermined number of components? Or would you use a different model in this case?

 * From VanderPlas In Depth: Gaussian Mixture Models
There it is stated that GMMs are more of a distribution density function rather than a clustering function and should only be used for suitable data, but what type of data is not suitable to this type of clustering? How could you cluster not based on how datapoints occupy similar positions in some definite dimensional space?




## k-Means vs. GMMs

* It seems that GMM is a method that overcomes many of the issues with regular k-means clustering. As GMM seems so much better, are there situations where we would want to use regular k-means clustering over GMM?
   > Gaussian mixture models offer two important benefits (account for variance + return the probability that a specific data point belongs to each of the K-clusters). However, there are also drawbacks such as the time complexity. Theoretically, k-means clustering is computationally less expensive than GMM which have a cubic time complexity (e.g. doubling the number of components results in 2³=8 the required calculation time). In reality, it might happen that GMM is faster though as it ends up in local minima (=non-optimal solutions) earlier. Generally, both GMM and k-means clustering tend to end up in local minima quite often. This means that the global minimum (= best solution) is not found. Hence, it is quite common to use Gaussian Mixture Models initialized with k-Means (increased robustness at the cost of a slightly higher computation time). So rather than choosing just one of the algorithm, the combination is considered gold-standard for many applications.
   > There is a lot of on-going research in that field right now. For instance, the expectation-variance-maximization algorithm was just published last year which seems to outperform the standard EM approach for GMMs.

* Why aren't dual color points introduced for k-means instead of having a harsh line between whats for instance considered yellow and whats considered blue? I.e. why do a cluster membership have to be distinct in k-Means?
  > I.e. GMMs would allow you to evaluate the probability of each datapoint being generated by a GMM. k-Means cluster just do not include such possibility.

* As for the k-means, the first step is guessing cluster centers. So it cannot always get the same result especilly when some point are on the boundary. As it said we need to pre-decide the number of clusters. Then GMM come out, more suitable for complex data. But they have same steps. I am wondering how can i decide which method should i choose  in futurn study or research. It's feasible to decide methods from roughly guess the cluster shape and boundaries without expectation–maximization? or  choose after the expectation–maximization approach.

* I seem to have trouble understanding what "lack of probabilistic cluster assignment" is and how it poses a disadvantage for k-means clustering. 



## Other types of clusetring

* How does one decide when to use a kernel function in k-means clustering and when to try another clustering method?

* VaderPlas on k-Means Clustering, part k-Means Algorithm: Expectation–Maximization
k-means is limited to linear cluster boundaries, what method should you use when you do not want linear cluster boundaries? (other than Gaussian Mixture Models )

* Is there any advantage of using k-means clustering over hierarchical clustering?
   > A1: Hirarchical clustering do not give fix cluster bounaries.
   > A2: I believe it can k-means is often less computationally , especially if k << n (number of datapoints) and we limit the number of iterations (or maybe rather if we have to do that, k-means is not he best choice). In k-means in each iteration we calculate k*n distances, and if the data has the structure we assume, we can usually reach "convergence" (local minimum) after relatively small nr of iterations. In hierarchical clustering we start with calculating n^2/2 distances (initial distance matrix), and then n - 1 times we calculate first ((n-1)^2)/2 distances, then ((n-2)^2)/2. The procces gives us O(n^3) (we would have n^3 as the highest power if we were to derive the full nr of calculated distances) complexity in any case, not only the worst one (while for k-means it can theoretically go much worse, it usually does not, and limiting number of iterations allows us to get results from which we can inferr something is not quite right in a very reasonable time). Hierarchical clustering poses problems also in terms of memory -  initial distance matrix you need to build can take quite some space for large datasets.




## Information criteria
* What is the difference between AIC and BIC? What is measured?
   > BIC and AIC are apparently very closely related. They both introduce penalty terms in order to overcome overfitting that occurs when parameters are added to increase the likelihood of the model. The penalty terms are introduced for the number of parameters in the model. The major difference seems to be that BIC has a larger penalty term than AIC. More depth information can be found in the review by Stoica and Selen  "Model-order selection: a review of information criterion rules", IEEE Signal Processing Magazine 


* Book on Gaussian Mixture Models.
At the end of the chapter it is stated that BIC model for finding the correct number of components gives us a simpler model, as it is typical for this sort of problem. Why is that and what sort of problem is meant here?


* From the in depth:Gaussian mixture models, What is the difference between the Akaike information criterion and the Bayesian information criterion and why does the BIC recommend a simpler model than AIC?
   > They are both doing the same: calculating a value which is based on the degree of freedom (which grows with the number of parameters/clusters), and the "goodness" of the fit (it can be the residue sum or the uncertain points etc.). The main difference is in their math, basically they have different emphasis on the each variable, which gives a different outcome. 










