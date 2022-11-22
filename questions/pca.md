## Outline of lecture
1. The direction that explains most variance.
1. Eigensamples and Eigengeses

# Questions and Answers on Principal Component Analysis.

### Nomenclature

The nomenclature on these type of analysis is challenging, as there are multiple fields re-inventing this type of analysis over and over again.  
* In factor analysis one factorize a matrix into latent factors and loadings 
* In PCA one factorize data into principal components and principal axes, each pair have their amount of explained variance.
* In SVD one factorize data into left and right eigenvectors, each pair has their own eigenvalue indicative of its magnitude.

As we can flip the calculation of left and right eigenvalues (and principal components and principal axes) by [transposing](https://en.wikipedia.org/wiki/Transpose) the data matrix (e.g. flipping the columns to rows), the distinction seems to matter less. Hence Wall *et al.* instead names the vectors according to what they represent. E.g. the first eigensample describes the variation of the genes for a sample, and a eigengene describes variation of the samples for a gene. You can see a eigenesample as the readouts for a typical sample, or more preciesly you model each sample as a linear combination of a value and the eigensample. In analog, you model each gene as a linear combination of a value and the eigengene. The relation between an eigenvalues and the explained variance is given [here](https://stats.stackexchange.com/questions/171539/percentage-of-variation-in-each-column-explained-by-each-svd-mode).


### General properties of PCA 
1. In VaderPlas' introduction to PCA, the principal axes seem to be orthogonal, is that really the case? Will it always be the case? Are two principal axes always orthogonal?
   > Yes, every principal component is orthogonal to all other principal components. Here is a [more detailed explanation](https://stats.stackexchange.com/questions/130882/why-are-principal-components-in-pca-eigenvectors-of-the-covariance-matrix-mutu)
### Dimensionality reduction with PCA
1. Would dimensionality reduction for PCA not lead to loss of information? Or is it not affected since you are only zeroing out the smallest components?
   > If you retain all components of a SVD, there is no loss of information (except for rounding errors). However, as soon as you drop components you naturally lose information.
   > > The first few components contain the most information about variance in the dataset. Their ratios of signal to noise are the highest, while the following components predominantly describe more noise. Therefore, this is the information we are losing, which is why the loss is not really an issue. Most of the variance or information we are interested in is not lost at all. 
   > > > Yes it does reduce the information. The aim of dimensionality reduction is reduce the number of features to a low-dimensional feature space, i.e to simplify the model. Indeed, it is important to not remove features with meaningful properties. However, some features could be quite redundant, such as noise in the data, which are features that are important to reduce. 

1. When doing PCA, it is said it does some kind of dimension reduction. As I understand, the algorithm looks at 2 features with the most variance and merges them as a new feature. Does it mean that at this point, the 2 previous features are out of the matrix containing all the features?
   > From my understanding, PCA does not really merge the two features with the highest variance. Rather, it selects components that explain the most of the variance of the data. The direction of these components come from linear combinations of features, such that this linear combination forms a "new feature", if you will, that explains the most of the variance.    
   This way you can present your data according to these new artificial features instead, which is what is called dimensionality reduction. In this representation, all features we had from the beginning are excluded (except that they have been used to construct the new features), not only the most informative ones.


### PCA for high dimensionality data

1. In the last section of VanderPlas (summary) is written that "PCA is not useful for every high-dimensional dataset". For what type of high-dimension dataset isn't it useful and is there a limit on the number of dimensions a dataset can have for performing PCA?
    > It could be useful for every dataset that have strong co-variation between its variables. The notebook has a case with 13047 genes. I would say that is pretty high-dimensional.

### Choosing the number of components

1. How can I select the number of components for my analysis? Is that any principle for choosing the the number of components?
   > VanderPlas makes the case that you should select variables based on the explained variance. See the section ["Choosing the number of components"](https://jakevdp.github.io/PythonDataScienceHandbook/05.09-principal-component-analysis.html#Choosing-the-number-of-components). 



2. It seems like from most of the examples that we are trying to reduce the dimensions to 1 or 2 regardless of the dimensions from the start. Is it possible to use PCA/SVD and get even more dimensions? It seems from intuition that some data could be better described. If it is possible, which are the cases where that would be desireable?
   > On the first question, yes you could extract more than 1 or 2 principal components and you usually do so. I think the reason why we did not go through this in the video lecture or in the example, is because only very simple data was used as an example and we managed to explain all the variance of the dataset in 1 or 2 PCs. Lukas explained it shortly in the lecture at around minute 6. If you have your initial matrix M and you calculated your first PC (PC1) you get vectors u1 and v1. You can calculate then  M−u1∗v1. The this will result in a new matrix, let's call it M1, which is basically a matrix with reduced variance (redundant to the equation, M1 is matrix M but without the information contained in PC1). You can then proceed to extract the next PC (PC2) from M1 and so on until you decide to stop or you have explained most of the variance in the data. So, if you explained most of the variance of the set there is not much sense in extracting more components since there is little information can be extracted. (I am not sure if you would get an error, but there is just nothing else to extract, you would otherwise  just get 0s back). Also the maximum components you can derive are the number of rows or columns you have in the matrix (genes or samples), since you would be just right where you began with, dimension wise.   
   > > The primary reason for selecting one or two PCs are that it facilitates the plotting of the variables.


1. After we reduce the dimension of our data by PCA, gain principle components and visualize in the PCA figure, how can we assess the quality and reliability of the analysis results? 
   > I think, as they have also done in the Vanderplas reading, you can map the inverse transformation of the reduced datapoints back to the original datapoints. This would be a visual check if your data is still sufficiently accurately described by your reduced matrix.
   > Besides that, I believe that PCA is known to be robust as an algorithm, but the tricky part is choosing the right amount of principal components to fit your data. Two possible methods for doing this are setting a threshold for the variance of each PC, or using a permutation test to see if your asssumptions still hold [source](https://towardsdatascience.com/pca-102-should-you-use-pca-how-many-components-to-use-how-to-interpret-them-da0c8e3b11f0).





### Eigensamples and Eigengeses
1. I found the section about Eigensamples and Eigengenes in connection to SVD difficult to understand. If this is important could you try to describe it more in the lecture?
   > I would recommend this [video] (https://www.youtube.com/watch?v=FgakZw6K1QQ&ab_channel=StatQuestwithJoshStarmer). He explains it far better than I would. The video explains relation between PCA and SVD in a very graphical way which makes it very intuitive. He doesn't call them eigensamples and eigengenes, but eigenvectors. I think that the matrix way was maybe not not the easiest to grasp if one has almost no previous knowledge on PCA. 


### Overfitting/Underfitting
1. You mentioned in the video that PCA is an unsupervised algorithm and thus is not prone to overfit. How do we know whether the result is underfit or not? Are there any validation method for PCA?
   > The reason that unsupervised algorithms are not prone to overfit is that you do not define a specific response variable to train the data on like for supervised machine learning methods. So it takes the data as it is and gives you principal components which eventually explain the variance in your data, allowing you to find patterns in the high-dimensional data. I think one way to evaluate whether your PCA is overfitted or not is to hold out a subset of the data and see if the held-out data fits into the clusters you got from the PCA model. Or like Ireen wrote in response to Houze further down in this forum: "I think, as they have also done in the Vanderplas reading, you can map the inverse transformation of the reduced datapoints back to the original datapoints. This would be a visual check if your data is still sufficiently accurately described by your reduced matrix."

1. You said in the video that the PCA wasn't prone to overfit, I don't really understand why this is?
   > There is no labels for the data and hence there is no clear definition of what it means to overfit. 

### Limitations of PCA
1. It was mentioned that PCA's main weakness is that it tends to be highly affected by outliers in the data. Does it have any other limitations?
   > PCA have many different properties that is worth knowing of. One property that quite often is hindering is that PCA is a linear technique, and hence does not capture non-linear trends as well as one could do.


1. Can you do PCA or SVD on any type of matrix?
   > Short answer: Yes. Correct answer: Yes, if the rank of the matrix equals to the lowest value of the number of rows and the number of columns. 
   > > Yes, we can do PCA and SVD for any type of matrix. As I know, PCA is essentially also a type of SVD, instead of doing SVD on the original matrix, PCA does SVD on covariance matrix. Also, SVD will be unique to any matrix. The difference will be that PCA skipps less significant component, while SVD considers all data points. As we can choose the number of component vectors, PCA will be less computationally heavy than SVD.
   > > > A Matrix is only nxm, so there should not be limitation! but at some point if you can not fint  two eigenvectors which have the highest impact on the Data it makes no sense for visitation because you only can Plot at least in 3D, 2d (is better).  See e.g. https://youtu.be/FgakZw6K1QQ?t=1189
### Eigenvalues
1. I am a bit confused by what are eigenvectors and eigenvalues even with the explanation in stackexchange.  Is the eigenvectors used to diagonalise the observation matrix and the resulted values on the diagonal are the eigenvalues?
   > Yes! An other way to think about them is that the eigenvalues capture the magnitude of each of the eigenvectors.
   > > The way I see it, is that the eigenvector and eigenvalues are their respective own terms. The eigenvector is obtained by setting the length of your obtained vector (that shows the relation between two PCAs) to 1 and deriving the x and y values from it. The eigenvalue is a number that indicates the sum of squared distances between the projected data points on two PCAs and the origins of your non-normalized (so length is not set to 1) eigenvector.

### SVD vs PCA

1. The relationship between PCA and SVD is a bit unclear to me. Some sources describe SVD as a possible method for a step in PCA, while others describe them as two separate methods altogether. Can anyone clarify this?
   > If you subtract the feature averages of your data prior to analysis SVD is a great way to perform a PCA. SVDs have [other applications](https://en.wikipedia.org/wiki/Singular_value_decomposition#Applications_of_the_SVD) in linear algebra than PCA, and there are other methods to perform PCA than SVD. 

1. How are PCA and SVD related? Further, I don't really understand if it is two different methods that both can be used for dimensionality reduction in data or if SVD is a way to perform PCA? 
   > In Wall et al the relationship is described as "Relation to principal component analysis. There is a direct relation between PCA and SVD in the case where principal components are calculated from the covariance matrix." which I think can be explained as SVD being one method of calculating the matrix that is used in PCA. So yes, SVD is essentially (one part) of one way to perform PCA. 

1. I know that PCA can be an iterative process where you can get as many PCs as there are dimensions in the data. How is this for SVD? Can it be used iteratively, or would it be a one step reduction method only by definition?
  > In SVD the algorithm calculates all the PCs in one go. Frequently we just retain the first couple of components though, despite them all being calculated. 



### Affine transformations
1. "This transformation from data axes to principal axes is an affine transformation." Why we need to do it (transformation from data axes to principal axes), and after this, all the vectors will have the same lengths?
   > With PCA we rotate and scale the axes in such a way that we can explain the most of the variation of the dataset.
   > > You want to transform the data axis into principal axis to be able to perform dimensional reduction. The PCAs that account for the most variance will be chosen to plot your data in two dimensions. When you use SVD for PCA, the vector length of your PCA is set to 1 for normalisation. When length is set to 1, your Singular Vector or Eigenvector can be derived by measuring the x distance and y distance for your vector. You will see that cubing the eigenvector values and summing them will always be equal to 1, due to the theorem of Pythagoras. 

### Notebook
1. In the jupyter notebook, the genes that are most responsible for the difference in expression among patients are explored by looking at their eigenpatients. What does it mean by "genes pointing in a positive/negative direction of the two components"? And how were these genes identified?
   > Does the gene have a positive or negative weight within each eigenpatient?

