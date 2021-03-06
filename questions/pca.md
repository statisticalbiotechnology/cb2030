# Questions and Answers on Principal Component Analysis.

## General properties of PCAs
1. Are the eigenvectors given from the SVD or are they needed beforehand?
> They are given by the SVD.

1. Is there a limit of how many dimensions PCA can be applied to? Does the maximum number of dimensions that PCA is suitable for depend on the size and/or quality of the data set? In that case, how?
> The notebook contains an example of PCA on 20k dimensions. There might be that you can hit an over limit by using even more dimensions, however, I have not experienced any problems with the size of the problem.

## Difference between PCA and SVD
1. * According to wikipedia SVD is a different name for PCA, depending on the field of application. But I read somewhere else that PCA is built upon SVD, and it seemed like the PCA method was an extension somehow. So, is there a difference between the two and, in that case, what is it?
  * Would calculating a covariance matrix between genes in a microarray and then performing a PCA yield exactly the same result as performing SVD on it?
   * I don’t really understand, is SVD a method that is always used to perform PCA or are they two different/independent methods for dimensionality reduction but that they combined together? (I felt that SVD was difficult to understand and I don’t think I understood exactly its connection with PCA).
> SVD is an algorithm for performing PCA ([give and take some small considerations](https://math.stackexchange.com/questions/3869/what-is-the-intuitive-relationship-between-svd-and-pca)).  
> A more elaborated answer:  
["What is the difference between SVD and PCA? SVD gives you the whole nine-yard of diagonalizing a matrix into special matrices](https://jonathan-hui.medium.com/machine-learning-singular-value-decomposition-svd-principal-component-analysis-pca-1d45e885e491) that are easy to manipulate and to analyze. It lay down the foundation to untangle data into independent components. PCA skips less significant components. Obviously, we can use SVD to find PCA by truncating the less important basis vectors in the original SVD matrix."
1. Can you explain more about the relationship between PCA and SVD?
> Yes I can.

## Singular Value Decomposition

1. **(4 votes)** I found it hard to understand what the three matrices in the SVD represented. Could you explain this a bit more?
> Not very much more than i.e. the description in Kluwer et al. Hopefully this will become clear after the seminar.

## Eigenvectors and Eigenvalues

1. **(5 votes)** In what circumstances are we interested in the properties of "eigenpatients", rather than "eigengenes"?
> The eigenpatient contains the variation within the patients, e.g. the first eigenpatient contains the most descriptive difference between the patients. So the eigenpatient is a vector containing one value per gene that gives the relative weight of that gene.  Conversely, the eigengenes contains the variation within the genes, e.g. the first eigengene contains the most descriptive difference between the genes. So the eigengene is a vector containing one value per patient that gives the relative weight of that patient.

1. **(5 votes)** I did not understand what we should extract from SVD. I understand we can see the single value matrix as the equivalent of PCA "explained variance", but what do we do then? Do we take the corresponding eigenassay column or the eigengene row for further analysis? Honestly, I don't understand what is contained in the other two matrices defined in SVD.
> Right, it might be a bit abstract at first. I will try to run some examples during the seminar, if you were not convinced by the examples in the video.

1. **(3 votes)** What exactly is S and why is it a diagonal matrix?
Why is the Eigengene matrix transposed?
> The S matrix is a diagonal matrix containing the eigenvalues. The eigengene matrix is transposed as it is the way it comes out from a SVD.

1. Do the Eigengenes and Eigensamples with their values actually exist in the data (= are there samples and genes which have exactly those values) or are those hypothetical 'genes' and 'samples' which describe the variance across the dataset?
> No, there is no individual sample or gene that takes the same shape as the eigengene. They are an average behavior across all genes/samples.


## Explained variance

1. ![](img/explainedV_nrComp.png)  
   In the summary of the PCA section in the book by Jake Van der Plas, the author states that 'Certainly PCA is not useful for every high-dimensional dataset, but it offers a straightforward and efficient path to gaining insight into high-dimensional data'
   In his examples, a plot of the cumulative explained variance resembled a [pareto curve](https://en.wikipedia.org/wiki/Pareto_distribution) (as above). Is this behaviour a requirement for a successful principle component analysis?
> It is not a requirement on the problem, instead it is a property of the analysis. 1st PC contains the most of the variance, 2nd PC the next-to most of the variance, etc. As the PCs are ordered, each new component adds a smaller and smaller contribution to the variance explained. Hence, the type of plot you see above.

1. **(3 votes)** What information could the S matrix give us in the jupyter notebook example?
> The S matrix (also called sigma matrix) in a [SVD](https://en.wikipedia.org/wiki/Singular_value_decomposition) contains the eigen-values. In this context, they are indicating the relative importance of the PCs of how well they explain the variance within your gene-expression matrix.

1. Is it possible that for instance when investigating 10 genes/dimensions that at least 4 of them accounts for equally large variance and are thus equally relevant and therefore PCA cannot convert the data into dimensions that are displayable?
> That is entirely possible.

1. **(3 votes)** What are some good ways to identify an optimal number of reduced dimensions?
> The amount of explained variation is a typical mean to identify which components that are relevant.

## Covariation

1. * I don't really get the covariance matrix. Do we have to compute that to be able to perform PCA?   
> No.  
   * Why would we need to look at the covariation of each pair of data points? In the explanations of PCA you just look for the dimensions that explains most of the variance.
> Yes that is all a PCA does for you, it finds a rotation where the the variance in the data is best explained in order of the principal components.
  * Is it that when this is done computationally (and not by eye as in the explanations) the best way to compute this is to base it on calculations of covariance between all data points?
> No, there is no separate covariance calculations involved. Just let the SVD do its job. In practice the PCA replaces linear combinations of covarying variables with new variables.


## Dimensionality Reduction

1. When doing a dimensionality reduction using PCA it is said that it involves "zeroing out" one or more of the smallest principal components. Are these considered outliers or why is it necessary to "zero out" these? Also, what exactly does it mean to "zero out"?
> VanderPlas means that you can make a dimensionality reduction of your problem by just selecting a subset of the principal components.



## Number of PC's to extract.

1. **(2 votes)** When PCA is used in machine learning do we need to do dimensional reduction to 3D or 2D or can they handle higher dimensions? And does a higher dimension generally show a clearer picture than a lower dimension?
> You frequently strive to reduce your problem to as few components as possible, but not less.

1. When combining components do you / the computer try different variations to see which one has the best separation, or do we decide ourselves what we think is appropriate?
> You have to choose the number of dimensions yourself.

1. **(2 votes)** As I understood, to plot the results of a PCA in 2D we need to select two principal components. What can we do if PC1 and PC2 can only explain a small amount of the total variance? Is there a way to include more components within the PCA plot?
> You are free to include as many components you want. However, they are sorted in the order of amount of explained variance. Hence if your first two components did not explain that much variance your third component is also not likely to explain much.

## Applications
1. What are the applications of singular value decomposition？
 > Any situation where you would like to explain the covariation in multi-dimensional data with a fewer number of components.


## Regularization

1. Both PCA and SVD are associated with the regularization term. Can you explain what regularization is and how it is linked with PCA and SVD?
> No, I do not think that is right. Neither of the methods are using [regularization](https://en.wikipedia.org/wiki/Regularization_(mathematics)).

1. In VaderPlas section on principle component analysis it is briefly explained that PCA's main weakness is its tendency to be highly affected by outliers in the data. This has neccecitated the development of robust variants which can account for this by itterativly discarding datapoints. Is there a point where this can lead to overfitting the data where eliminating datapoints can compromise the validity of the constructed components? Is this commonplace in PCA?
> There is no really nice way to characterizing overfittings to data for unsupervised learning. However, just as for supervised learning, the more parameters you introduce the more prone an algorithm is prone to fit a particular dataset. Conversely, if you select a too rigid model (with too few parameters), it will fail to generalize.

1. It is said that PCA is affected by outliers and that some variants of the method can compensate for that or remove them in some way, but I have difficulties understanding how outliers can be identified as such and not just as points showing an actual effect, especially when the aim is to investigate the data.
> VanderPlas mention SparsePCA and explains that it uses a regularization scheme called L1-penalty, i.e. it penalizes not just for squared errors of the decomposition, but also for number of non-zero elements in each principal components. Feel free to try the method yourself in e.g. the jupyter notebook.

## Kluwer *et al.* nomenclature
![](https://public.lanl.gov/mewall/kluwer2002/SVD_GEA.jpg)

1. **(5 votes)** To me the eigengenes/eigensamples and principal components seem like kind of the same thing, what's the difference?
> None. Eigengenes/eigensamples is just a more direct nomenclature.

1. **(3 votes)** I had problems with understanding what eigenassays are. From what I understood they correspond to the columns (U<sub>k</sub>) in the left (m x  n) matrix U in X=USV<sup>T</sup> and it is mentioned that they are analogous to  principal components. I still don't understand what they represent in a gene expression analysis.
> The eigenassay contains the variation within the patients, e.g. the first eigenassay contains the most descriptive difference between the assays. So the eigenassay is a vector containing one value per gene that gives the relative weight of that gene.

1. Is the "first Eigen gene" means the first principal component and the "second Eigen gene" means the second principal component? So are they both the linear combination of a set of different genes? In Jupyter notebook's illustration, it seems really similar to how we illustrating PC1, PC2, etc.  
Eigen genes. These illustrate the linear combinations of genes that explains the variance of the genes. First one describes the most, the second explains most of the variance when the variance of the first gene-compination is removed. Here we only explore the first two component, but one could plot the other ones as well.)
> Yes, the nomenclature in the notebook follows the section 2 of [Kluwer et al.](https://public.lanl.gov/mewall/kluwer2002.html)

1. Can you explain the connection between PCA and eigengenes/eigensamples again? Does  the eigengenes and/or eigensamples describe the principal components of the data set?
> Yes, Kluwer *et al.* calls principal components eigengenes and eigenassays.

## Limitations of PCA

1. **(3 votes))** It is mentioned in "principal component analysis summary" that PCA is less useful for high-dimensional data sets. Is this due to the loss of information or is it other factors limiting the use of PCA?
> I dissagree, VanderPlas states that: "Certainly PCA is not useful for every high-dimensional dataset, but it offers a straightforward and efficient path to gaining insight into high-dimensional data.", that is not really the same thing as you state.
> PCA is frequently used in high dimensional data, as we are in more need of dimensionality reduction in high dimensional data.

1. It is mentioned that PCAs main weakness is outliers in your data. Does this mean that there are examples of when PCA or dimensionality reduction is possible but not recommended? Such as when there is a lot of variance between samples and data?
> The main limitation is that PCA is a linear technique. If the association between two variable is not linear, you might not catch such associations.

1. In Kluwer paper, it is demonstrated that the difference between SVD and other analysis methods is the ability to detect the 'weak signal'. How could we define this 'weak signal', if it means that when the data cannot be clustered by k-means/GMM, or the dimension of data is much larger, SVD and PCA could be the better choice?
> Weak signals can be sometimes be captured by other clustering methods as well. What is great with PCA is that it allows you to strip of one effect at the time from the data (just as Kluwer et al. demonstrates).   


## Notebook

1. In the notebook (PCA of Carcinomas) it is explained that the data from both types of cancer are merged a just one single dataset and from this "new merged data set" the principal components are obtained which are later used for the SVD analysis. I don't quite understand how you plot the "new merged data set" for obtaining the principal components when you only have the transcripts count as the variable? I mean, in the youtube video you explain that a single data set from patients could be plotted in order to get the principal component 1, though there you had 2 variables (height and weight). In the notebook we only have one single variable (counts of transcripts), so how does the code produce the principal component? Does it choose random transcript counts and plot them against each other?
> Each of the two sets contains patients' gene expression values (about 20k gene exression values per patient). Here the data is given as a 500 x 20k array, patients as columns, genes at rows. You add the patients containing the two types of cancer in one large set,which here is  represented as a 1k x 20k matrix. This is a typicalthing that is easier viewed in the notebook directly.  

## Design of Experiments

1. **(2 votes)** In your youtube video you say that the difference we can see in the first plot in the jupyter notebook could be due to biases in the data sets, such as that they have been normalized separately. How can such biases be avoided? Moreover, is the data always normalized before performing PCA and if so how is the normalization done?
> You conduct your experiment exactly the same way for all samples. That is easier said than done, though.

## Other types of Dimensionality Reduction

1. **(4 votes)** Is there any other dimensionality reduction methods utilizing a metric other than the covariance measure? I.e. can you capture other features of the data in question by the same procedure as PCA?
  > One related type of analysis that is using a [different orthogonality criterium](https://stats.stackexchange.com/questions/35319/what-is-the-relationship-between-independent-component-analysis-and-factor-analy) than PCA is [Independent Component Analysis (ICA)](https://en.wikipedia.org/wiki/Independent_component_analysis).

1. **(2 votes)** Other dimensionality reduction methods such as t-SNE are often also used for example in gene expression analysis.  When do we prefer to use PCA in front of other methods, and could we then for example also use t-SNE on the data in the jupyter notebook?
> [t-SNE](https://scikit-learn.org/stable/modules/manifold.html#t-distributed-stochastic-neighbor-embedding-t-sne) is a non-linear technique. We wont cover it here, but it is great for visualisation of multidimensional data. Feel free to try it out in the notebook example, it is relatively straightforward to implement.

1. It has been shown that PCA is not useful for every high-dimensional dataset. Being the outliers affection in the data one of the PCA's main weakness.  
Scikit-Learn is one of the strongest iterative alternatives to discard poorly described data points from the dataset. This method contains interesting variants on PCA, RandomizedPCA and SparsePCA.  
RandomizedPCA approximates the first few principal components in a fast but non-deterministic way. While SparsePCA introduces a regularization term enforcing sparsity of the components.  
In which cases, would it be better to use RandomizedPCA, achieving a fast discard of the data points and when it would be better to introduce and regularize the components through the SparsePCA variant?
> Why don't you find out by trying them out?

## Outliers

1. When you have outliers in the PCA, how do you know if you can discard them? The text says that you can discard "data points that are poorly described by the initial components", but what defines if they are poorly described?
> You! It is a subjective call.

1. In the lecture video, the most extreme genes for Eigen Patient 1 and 2 are considered the most relevant. How do we know these are not outliers? Has the data been filtered before the analysis?
> No I do not say that they are more relevant, just that they describe the most of the variation in the data. They could contain outlier data, so it might be worth plotting their expression values.

## Other

1. Are there vectors of a dataset that can be used to decide whether PCA or SVD are more suitable for the analyses or are both dimensional reduction algorithms always applicable?
> Not sure I understand your question.

1. Would it be possible to explain Singular Value Decomposition a little bit better with regard to the gene expression data analysis?   
> Sure I can. Which aspect was unclear in e.g. Kluwer et al.?
