# Questions and Answers on Principal Component Analysis.

1. Is there any other dimensionality reduction methods utilizing a metric other than the covariance measure? I.e. can you capture other features of the data in question by the same procedure as PCA?
  > One related type of analysis that is using a [different orthogonality criterium](https://stats.stackexchange.com/questions/35319/what-is-the-relationship-between-independent-component-analysis-and-factor-analy) than PCA is [Independent Component Analysis (ICA)](https://en.wikipedia.org/wiki/Independent_component_analysis).

1. Would calculating a covariance matrix between genes in a microarray and then performing a PCA yield exactly the same result as performing SVD on it?
1. I don’t really understand, is SVD a method that is always used to perform PCA or are they two different/independent methods for dimensionality reduction but that they combined together? (I felt that SVD was difficult to understand and I don’t think I understood exactly its connection with PCA).
> SVD is an algorithm for performing PCA.  
> A more elaborated answer:  
[]"What is the difference between SVD and PCA? SVD gives you the whole nine-yard of diagonalizing a matrix into special matrices](https://jonathan-hui.medium.com/machine-learning-singular-value-decomposition-svd-principal-component-analysis-pca-1d45e885e491) that are easy to manipulate and to analyze. It lay down the foundation to untangle data into independent components. PCA skips less significant components. Obviously, we can use SVD to find PCA by truncating the less important basis vectors in the original SVD matrix."

1. ![](img/explainedV_nrComp.png)  
   In the summary of the PCA section in the book by Jake Van der Plas, the author states that 'Certainly PCA is not useful for every high-dimensional dataset, but it offers a straightforward and efficient path to gaining insight into high-dimensional data'
   In his examples, a plot of the cumulative explained variance resembled a [pareto curve](https://en.wikipedia.org/wiki/Pareto_distribution) (as above). Is this behaviour a requirement for a successful principle component analysis?
> It is not a requirement on the problem, instead it is a property of the analysis. 1st PC contains the most of the variance, 2nd PC the next-to most of the variance, etc. As the PCs are ordered, each new component adds a smaller and smaller contribution to the variance explained. Hence, the type of plot you see above.

1. When PCA is used in machine learning do we need to do dimensional reduction to 3D or 2D or can they handle higher dimensions? And does a higher dimension generally show a clearer picture than a lower dimension?
> You frequently strive to reduce your problem to as few components as possible, but not less.


1. What are the applications of singular value decomposition？
 > Any situation where you would like to explain the covariation in multi-dimensional data with a fewer number of components.


1. Both PCA and SVD are associated with the regularization term. Can you explain what regularization is and how it is linked with PCA and SVD?
> No, I do not think that is right. Neither of the methods are using [regularization](https://en.wikipedia.org/wiki/Regularization_(mathematics)).


1. What information could the S matrix give us in the jupyter notebook example?
> The S matrix (also called sigma matrix) in a [SVD](https://en.wikipedia.org/wiki/Singular_value_decomposition) contains the eigen-values. In this context, they are indicating the relative importance of the PCs of how well they explain the variance within your gene-expression matrix.

1. Is the "first Eigen gene" means the first principal component and the "second Eigen gene" means the second principal component? So are they both the linear combination of a set of different genes? In Jupyter notebook's illustration, it seems really similar to how we illustrating PC1, PC2, etc.  
Eigen genes. These illustrate the linear combinations of genes that explains the variance of the genes. First one describes the most, the second explains most of the variance when the variance of the first gene-compination is removed. Here we only explore the first two component, but one could plot the other ones as well.)
> Yes, the nomenclature in the notebook follows the section 2 of [Kluver et al.](https://public.lanl.gov/mewall/kluwer2002.html)

1. Are there vectors of a dataset that can be used to decide whether PCA or SVD are more suitable for the analyses or are both dimensional reduction algorithms always applicable?
> Not sure I understand. FIXME

1. In what circumstances are we interested in the properties of "eigenpatients", rather than "eigengenes"?
> The eigen patient contains the variation within the patients, e.g. the first eigen patient contains the most descriptive difference between the patients. So the eigen patient is a vector containing one value per gene that gives the relative weight of that gene.  Conversely, the eigengenes contains the variation within the genes, e.g. the first eigengene contains the most descriptive difference between the genes. So the eigengene is a vector containing one value per patient that gives the relative weight of that patient.

1. I did not understand what we should extract from SVD. I understand we can see the single value matrix as the equivalent of PCA "explained variance", but what do we do then? Do we take the corresponding eigenassay column or the eigengene row for further analysis? Honestly, I don't understand what is contained in the other two matrices defined in SVD.
> Right, it might be a bit abstract at first. I will try to run some examples during the seminar, if you were not convinced by the examples in the video.

15/11
