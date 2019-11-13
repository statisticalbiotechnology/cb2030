# Questions and Answers on Principal Component Analysis.

1. Is SVD simply a way of performing PCA.
  > Yes, SVD is a method for PCA. A more elaborate answer can be found [here](https://math.stackexchange.com/questions/3869/what-is-the-intuitive-relationship-between-svd-and-pca).

1. What are the singular values themselves, and how can they be interpreted?
  > They are directly related to the amount of variance explained by each principal component. As explained [here](https://stats.stackexchange.com/questions/171539/percentage-of-variation-in-each-column-explained-by-each-svd-mode), you can directly use them to calculate the proportion of the variance explained for each PC.


1. Is PCA considered as a kind of linear regression which shows the correlation between two variables?
 > No, not really. However, the principal component will show that the variance of some variables are better described as a liear combination of the variables. That is would be a sign of co-variation of the variables.

1. - Could you clarify in which situation of unsupervised learning it is useful to use PCA rather than k-means clustering? Could we combine k-means clustering and PCA in the same analysis as comfirmation?
  - How do we select between Clustering and PCA as unsupervised learning techniques?
  > PCA focuses more directly on the explanation of the underlying phenomena driving the variation of the data. If there is one or a few factors with a linear influence to many of the observed variables, then PCA is a great method to find such factors.
  It is a very good idea to perform both types of analysis side by side to see if you get corroborating results.


1. How do you calculate the principal component, such as in your example in the video?
  > With PCA?

1. A requirement in Principal Component Analysis is that the individual principal components are linearly independent (and therefore orthogonal to each other). Does this requirement only apply in respect to the initial/first principal component? Otherwise I don’t understand how this method would be applicable for more than 3-dimensional plots.
  > No all Principal components are orthogonal to each other. *N*-dimensional spaces can contain max *N* vectors that are orthogonal to each other.


1. Can you elaborate about 'Eigen genes' and Eigen Samples/Patients'? Are they similar to eigen numbers and eigen vectors respectively?
  > Could you help me by highlighting which opart of [Kluwer et al.](https://public.lanl.gov/mewall/kluwer2002.html) that was hard to follow in this respect?

1. In the notebook the SVD is used to get eigengenes and eigenpatients, are these the principal components? From what I understood it seems that they explain just the variance of patients and of genes respectively, how would a PCA function choose which of these to use as principal components to explain the variance of the whole dataset?
  > They PCs are telling you what linear combinations of variables that will explain the most of the variation of the variables.


1. Does SVD allow for faster computation, or are there any other advantages of using one method over the other?
  > Normally one use SVD as it is more numerically stable than other methods to compute PCA.

1. tSNE is another most commonly used clustering technique apart from PCA. I understand that tSNE is probabilistic while PCA is statistical in nature. When is PCA preferred and when is tSNE preferred?
  > Neither of the techniques are clustering techniques. PCA is a simpler technique than tSNE, and gives mechanistical insights to the data. It's worth noting as well that many consider tSNE to be [overused](https://towardsdatascience.com/how-exactly-umap-works-13e3040e1668).  


1. In the video lecture at around 6:50 , It is said and understood that the columns of U represent the projections of the data onto the PC1. But what does it mean that the rows of Vt represent projection of different samples inside of X?
  > I like the terms of [Kluwer et al.](https://public.lanl.gov/mewall/kluwer2002.html). Eigen genes is the best representation of how a gene behave, and eigen assays (or eigen experiments, eigen patients) are representations of how patients behave.  

1. Is it possible or common to have higher dimensionality in PCA, or is it limited to the 3 correlations and PC1/PC2?
  > The upper bound of the number of the PCs are the rank of the expression matrix, which often equate to the min of number of columns and rows of the analyzed matrix.

1. - What is the main use of PCA in life science? Is it to more easily visualize data (through dimensionality reduction) or to determine the most important features/variables in terms of variance?
   - Could we say that PCA is a clustering algorithm? Can it be used for clustering except visualization, feature selection and dimensionanily reduction?
  > No PCA is not a clustering algorithm. The analysis itself does not give you any groups of data points. PCA have multiple applications. It can be used for visualization, for dimensionality reduction and as a technique to give mechanistic explanation of any linear effects that you are trying to assess. It can also be used for determining biases of your patient material, [for missing value imputations](https://stats.stackexchange.com/questions/35561/imputation-of-missing-values-for-pca).

1. In the video in the example about the height and the weight it is said that the second principal component seems to be more interesting for interpreting the results but I didn´t manage to understand the reason for that.
    > You would normally assume that a tall person allso is a heavy person. This implies that there is a linear relationship between squared length and weight. That relationship will be explaining most of the variation of your data, and end up in PC1. The PC1 is normally not interesting to study. However, hopefully, PC2 will capture the [BMI]((https://en.wikipedia.org/wiki/Body_mass_index)), which might be of larger interest.

1. How do you determine how far the dimensionality reduction should be taken (i.e. how many principal components to keep)?
  > It is a matter of a) how much variance remains to be explains and b) your taste.




1. Could you go through this piece of code in your notebook (In [3])?
  ```
  from numpy.linalg import svd
  X = combined.values
  Xm = np.tile (np.mean(X, axis=1)[np.newaxis].T, (1,X.shape[1]))
  U, S, Vt = svd(X-Xm, full_matrices=True, compute_uv=True)
  ```
  What is actually happening here? I do understand that the generated output is the U matrix containing the eigensamples and genes, S matrix which is the singularvalue matrix and Vt which is the samples and eigengens. However, I do not follow what is happening beforehand and what the Xm is used for.
  > Great question. We often centralize (i.e. remove the mean of each probe) our data before SVD. In the code, `np.mean(X, axis=1)[np.newaxis].T` will render a one dimensional matrix with the mean expression value for each gene. Subsequently, you `tile`, i.e. copy that 1-dimensional vector in `X.shape[1]` copies into a matrix od the same dimension as `X`.   

1. Do the parameters you are investigating have to be linearly correlated or can they be non-linear correlated?
  > Not in the standard formulation of PCA.

1. Could you explain how the variance is calculated, and how the sum of the variance are correlated to the sum of the total error?

1. How do you decide how many dimensions in PCA? because if there are many  principle components,  the data would be more linear correlated, but maybe it is more difficult to analyse?

1. In the article "SVA analysis of gene expression data" they write that n is the columns of gene expression data, and that if r<n the transcriptional responses of the genes may be captured with fewer variables if we use gi' instead of gi (gi being the gene transcriptional response). Also they write that due to presence of noise r=n in any real gene expression analysis application.
Could you clarify this? I have a hard time understanding what r is, why r has to be less than n for gi' to capture the response instead of gi, and why r is always equal to n due to noise in real applications?

1. Are Eigen vectors unit vectors and which direction do they generally point? Also Do eigen values give the significance of a particular component and help to choose the components with highest significance?

1. Could you give an example of a scenario where PCA is not useful for analysis?

1. "If r < n, the transcriptional responses of the genes may be captured with fewer variables using g'i rather than gi. This property of the SVD is sometimes referred to as dimensionality reduction"
In the above statement, it says that if the rank of the assay matrix X is less than the number of columns, (i.e- assays), the transcriptional response can be defined by fewer variables. How does this happen? Will the reduction in rank of the assay matrix reduce number of dependencies?

1. Why is the reason for the transformation from data axes to principal component axes? The transformed graph will always look like a sphere, with all the principal component vectors beeing the same lenght.

1. Could you please explain the singular value decomposition. Is it the same as cross product in vector mathematics? And why is it usefull?

1. How to know whether PCA is applicable on a particular data set or not? What is the difference between orthogonal and oblique rotation methods to interpret the components? What are the alternative to PCA? What is the difference of Linear Square Regression from PCA1? How many reductions can be done and make sense?

1. Can one combine the dimension reduction in PCA with the addition of a dimension in kernel function to linearly separate data points?

1. What type of data would you tackle with SVD? And what would you analyze using PCA? Or would you always choose both?

1. How do you determine how far the dimensionality reduction should be taken (i.e. how many principal components to keep)?

1. What is SVD used for, how is it applied? Is it usually applied together with PCA or is it used on its own?

1. It seems as though, in the stackexchange answer, they want to convey that the first principal component is the eigenvector with the highest eigenvalue when factoring out covariance. What is the importance of factoring out covariance, and would there not be biological significance in the covariance?

1. During the video, when you use the BMI example you state that the PCA2 (Weight in this case) seems to have a more prominent role, however I could not understand why. Could you develop?

1. When transforming a dataset into PC: is there no net loss of information, as a result of reducing its dimensions?

1. I find the explanation of SVD overall very confusing and have a hard time grasping how it is used. One specific thing I am missing is what "r" is. Could you please clarify this?

1. So far I understood PCA as trying to find the Eigenvectors and Eigenvalues of the covariance matrix. How does this relate to SVD and when do you use it?

1. What do the sentences “the genes pointing in a positive/negative direction for the two components” at the end of the jupyter notebook mean?

1. The PCA plots given in papers almost always have the axis labelled as Principal component 1 or PC1 and so on, but it never mentions the actual element or the feature based on which this component refers to. Why is it done so? Wouldn't it be more useful and intuitive to use the name of the feature itself (based on which the component is actually made) as the axis title?

1. I do get the idea of using PC1 or so own, as it describes directly the order of variance we are talking about, but it makes more sense to me to have the actual name of the feature (s) based on which the PC is made written there instead.

1. I don't understand the relationship between PCA and SVD, and when to apply SVD?

1. I already know that in the formula X=USV, the first few values in the S matrix corresponding to more reliable principle component eigenvector. I am wondering if there is any threshold to select these components?  How can we decide the number of components to have a more accurate analysis?

1. PCA uses maximum variance as a key driving element for the dimension reduction. Does this mean that the smaller effects are lost or neglected in PCA? Or should one simply look at higher component numbers to find these smaller effects.

1. For eg. transcriptional noise  of genes expression can be regulated by multiple factors. Of which TF, accessibility, ribosomal availability, small regulatory elements (RNA) etc. TF is one of the biggest regulator and small RNA (microRNA) have smaller role as compared to TF. In this scenario if we are interested to study the effects from microRNA then can we use PCA? Or will the small effect of microRNA be ignored in the PCA? Or will I have to look at PC 10 or PC 20 instead of PC1?

1. During PCA process, the low variance components are considered to be discarded as noise. However, these components support for supervised machine learning outputs. How do we understand these differences?

1. In my interpretation of Figure 5.2 in the article of Kluwer et al, the PCA1, PCA2 and PCA3 seems to be the dimensions that explains the greatest variances of the data. However, are there cases where, for instance, all PCAs up to PCA4 include important data information (in terms of variance) so that reducing the dimensions to 3D would create misinterpretations of the data? If so, how do we treat data that cannot be transformed into 3D in a reasonable way?

1. In the JupyterNotebook, I don't understand why the Eigenpatients (and not the Eigengenes) are used to obtain the genes that are most responsible for the difference between cancer types. Also, is there any particular reason why the genes pointing in either positive or negative directions in both PCs are more interesting than those pointing positive on one PC and negative on the other?
(8:30)
