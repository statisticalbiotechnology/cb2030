# Questions and Answers on Principal Component Analysis.

## What is PCA
1. Is PCA considered as a kind of linear regression which shows the correlation between two variables?
 > No, not really. However, the principal component will show that the variance of some variables are better described as a linear combination of the variables. That is would be a sign of co-variation of the variables.

1. It seems as though, in the stackexchange answer, they want to convey that the first principal component is the eigenvector with the highest eigenvalue when factoring out covariance. What is the importance of factoring out covariance, and would there not be biological significance in the covariance?
  > All data analysis aims at explaining the variation in the data. PCA is a nice way to do so for covarying data. The point is that you factor out the covariation to specifically study the covariation.

1. - Could you clarify in which situation of unsupervised learning it is useful to use PCA rather than k-means clustering? Could we combine k-means clustering and PCA in the same analysis as comfirmation?
   - How do we select between Clustering and PCA as unsupervised learning techniques?
   > PCA focuses more directly on the explanation of the underlying phenomena driving the variation of the data. If there is one or a few factors with a linear influence to many of the observed variables, then PCA is a great method to find such factors.
   It is a very good idea to perform both types of analysis side by side to see if you get corroborating results.

## Applications of PCA

1. - What is the main use of PCA in life science? Is it to more easily visualize data (through dimensionality reduction) or to determine the most important features/variables in terms of variance?
   - Could we say that PCA is a clustering algorithm? Can it be used for clustering except visualization, feature selection and dimensionanily reduction?
  > No PCA is **not** a clustering technique. The analysis itself does not give you any groups of data points. PCA have multiple applications. It can be used for visualization, for dimensionality reduction and as a technique to give mechanistic explanation of any linear effects that you are trying to assess. It can also be used for determining biases of your patient material, [for missing value imputations](https://stats.stackexchange.com/questions/35561/imputation-of-missing-values-for-pca).
  > A very nice and applied explanation: One example is in genomics, where, when we set up an experiment, we have biological and technical replicates. Usually what we are looking for is a biological difference between two conditions, and to be sure that this is the case PCA can be used as a kind of quality control. What we want to observe is that most of the variance is explained by biology and not by technical factors, i.e. that principal component 1 is larger than principal component 2. I hope that this was clear enough and a correct explanation. If not, looking at the PCA of this article might help:
  ![https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4972086/figure/f1/]( https://www.ncbi.nlm.nih.gov/corecgi/tileshop/tileshop.fcgi?p=PMC3&id=61776&s=62&r=1&c=1)
Here they did RNA-sequencing for differential gene expression on Zika-virus infected cells using two different sequencing platforms (MiSeq and NextSeq). When they did the PCA, they could show that 50 % of the variance between the samples was due to whether the cells were infected with Zika virus or not, and 20 % the variance was due to the platform that they used (MiSeq or NextSeq).


## Variance explained and singular values

1. What are the singular values themselves, and how can they be interpreted?
  > They are directly related to the amount of variance explained by each principal component. As explained [here](https://stats.stackexchange.com/questions/171539/percentage-of-variation-in-each-column-explained-by-each-svd-mode), you can directly use them to calculate the proportion of the variance explained for each PC.

1. Could you explain how the variance is calculated, and how the sum of the variance are correlated to the sum of the total error?
     > Variance of uncorrelated variables are always [additive](https://en.wikipedia.org/wiki/Variance#Sum_of_uncorrelated_variables_(Bienaym%C3%A9_formula)). So, are the variances explained by the principal components.

1. When transforming a dataset into PC: is there no net loss of information, as a result of reducing its dimensions?
    > No, not if all dimensions are used. Otherwise, yes, obviously.

1. - PCA uses maximum variance as a key driving element for the dimension reduction. Does this mean that the smaller effects are lost or neglected in PCA? Or should one simply look at higher component numbers to find these smaller effects.
   - For eg. transcriptional noise  of genes expression can be regulated by multiple factors. Of which TF, accessibility, ribosomal availability, small regulatory elements (RNA) etc. TF is one of the biggest regulator and small RNA (microRNA) have smaller role as compared to TF. In this scenario if we are interested to study the effects from microRNA then can we use PCA? Or will the small effect of microRNA be ignored in the PCA? Or will I have to look at PC 10 or PC 20 instead of PC1?
   > Yes, subtile differences migh be lost in the analysis.


## Relation PCA and SVD

1. Is SVD simply a way of performing PCA.
  > Yes, SVD is a method for PCA. A more elaborate answer can be found [here](https://math.stackexchange.com/questions/3869/what-is-the-intuitive-relationship-between-svd-and-pca).

1. Does SVD allow for faster computation, or are there any other advantages of using one method over the other?
    > Normally one use SVD as it is more numerically stable than other methods to compute PCA.

## Orthogonality of Principal components

1. A requirement in Principal Component Analysis is that the individual principal components are linearly independent (and therefore orthogonal to each other). Does this requirement only apply in respect to the initial/first principal component? Otherwise I don’t understand how this method would be applicable for more than 3-dimensional plots.
  > No all Principal components are orthogonal to each other. *N*-dimensional spaces can contain max *N* vectors that are orthogonal to each other.

## Interpretation of principal components

1. In the video in the example about the height and the weight it is said that the second principal component seems to be more interesting for interpreting the results but I didn´t manage to understand the reason for that.
    > You would normally assume that a tall person allso is a heavy person. This implies that there is a linear relationship between squared length and weight. That relationship will be explaining most of the variation of your data, and end up in PC1. The PC1 would normally not be interesting to study, at least not in e.g. T2D studies. However, hopefully, PC2 will capture the [BMI](https://en.wikipedia.org/wiki/Body_mass_index), which might be of larger interest.
    ![BMI](https://upload.wikimedia.org/wikipedia/commons/b/b0/BMI_chart.svg "Image from wikipedia entry.")

1. What is the reason for the transformation from data axes to principal component axes? The transformed graph will always look like a sphere, with all the principal component vectors beeing the same lenght.
      > Good question. After the transformation the PCs will have an eigen value attached to them so that you know how much of the variance they explain. Particularly PC1 will be the linear combination of data that optimally explains the variation of the data.  

1. The PCA plots given in papers almost always have the axis labelled as Principal component 1 or PC1 and so on, but it never mentions the actual element or the feature based on which this component refers to. Why is it done so? Wouldn't it be more useful and intuitive to use the name of the feature itself (based on which the component is actually made) as the axis title?
  > These are linear combinations of features, hence ther is no single feature to refer to.

1. Also, is there any particular reason for why the genes in the notebook pointing in either positive or negative directions in both PCs are more interesting than those pointing positive on one PC and negative on the other?
    > In general, features that covary between the PCs can be signs of there being a bias in the patients, that we might be able to detect by studyin the eigen genes.

1. What is their relationship with the original data (e.g. "eigen gene 1" with "gene 1" values)?
      > An eigen gene is the linear combination of patients that would explain most of the variation of the data.

1.  Is there any reason why the principal components are pointing in the direction they are pointing? I mean for example in the second picture in VaderPlas reading material, wouldn't it be the same if the second principal component was pointing up instead of down?
  > No this is an arbitrar choice. You can fip the signs of the elements in the eigen patients and the eigen genes and they would still explain the same thing.


## Eigen genes and Eigen Samples

1. In the video lecture at around 6:50 , It is said and understood that the columns of U represent the projections of the data onto the PC1. But what does it mean that the rows of Vt represent projection of different samples inside of X?
    > I like the concepts of [Kluwer et al.](https://public.lanl.gov/mewall/kluwer2002.html). Eigen genes is the best representation of how a gene behave, and eigen assays (or eigen experiments, eigen patients) are representations of how patients behave.
    ![Eigen genes](https://public.lanl.gov/mewall/kluwer2002/SVD_GEA.jpg "Image from Wall et al. Unkown License.")

1. Do the concepts of eigen genes and eigen assays/samples only come up when you do a SVD for PCA (as in the jupyter notebook and Kluwer et al. reading)? Or are the same concepts relevant when you do just a PCA (as was done in the VanderPlas reading with the commands: pca = PCA(n_components=2), pca.fit(X))? I do not understand the relationship between PC1 and PC2 and eigen genes and eigen samples/assays.
    > There are some subtle [differenes between PCA and SVD](https://stats.stackexchange.com/questions/134282/relationship-between-svd-and-pca-how-to-use-svd-to-perform-pca), so they PCs and the eigen vectors differs a by a scalar factor. Modulo those differences: If the data in the [introduction to PCA](https://jakevdp.github.io/PythonDataScienceHandbook/05.09-principal-component-analysis.html#Introducing-Principal-Component-Analysis) was gene expression values for two different patients,  the components in the figure for cell 6 would be the eigen patients one and two and the direction of the axises of the input space is the eigen genes. The eigen gene equivalent is also available through `pca.components_` in cell 4.
    ![Kluwer](https://jakevdp.github.io/PythonDataScienceHandbook/figures/05.09-PCA-rotation.png)


1. In the JupyterNotebook, I don't understand why the Eigenpatients (and not the Eigengenes) are used to obtain the genes that are most responsible for the difference between cancer types.
      > The first eigen patient, is a what a gene expression profile from the single patient that would explain most of the variation in the data would look like.

1. In the notebook the SVD is used to get eigengenes and eigenpatients, are these the principal components? From what I understood it seems that they explain just the variance of patients and of genes respectively, how would a PCA function choose which of these to use as principal components to explain the variance of the whole dataset?
  > They PCs are telling you what linear combinations of variables that will explain the most of the variation of the variables.

1. Could you please explain the last part of the stackexchange answer, from the point that it starts talking about matrices. I don't understand what are the eigenvectors and eigenvalues.
  > That part of the answer is not essential for the understanding of PCA, however: A [covariance matrix](https://datascienceplus.com/understanding-the-covariance-matrix/) is a description of how much variation you have in the data in each dimension(in the diagonal) as well as how much the datapoints dimensions are covarying with (non-diagonal elements). The answer makes the point that PCA is a projection from input space to a co-ordinate system where there is no covariation in the data, i.e. the covariation matrix is diagonal.

## Relation to other techniques

1. tSNE is another most commonly used clustering technique apart from PCA. I understand that tSNE is probabilistic while PCA is statistical in nature. When is PCA preferred and when is tSNE preferred?
  > Neither of the techniques are clustering techniques. PCA is a simpler technique than tSNE, and gives mechanistical insights to the data. It's worth noting as well that many consider tSNE to be [overused](https://towardsdatascience.com/how-exactly-umap-works-13e3040e1668).  

1. What is the difference between orthogonal and oblique rotation methods to interpret the components?
    > I guess you mean factor analysis. PCA is a type of factor anaysis.


## Number of dimensions of the data
1. Is it possible or common to have higher dimensionality in PCA, or is it limited to the 3 correlations and PC1/PC2?
  > The upper bound of the number of the PCs are the rank of the expression matrix, which often equate to the min of number of columns and rows of the analyzed matrix.

1. How do you determine how far the dimensionality reduction should be taken (i.e. how many principal components to keep)?
    > It is a matter of a) how much variance remains to be explains and b) your taste.

1. Are Eigen vectors unit vectors and which direction do they generally point? Also Do eigen values give the significance of a particular component and help to choose the components with highest significance?
      > Both the eigen genes and eigen assays of Kluwer et al are unitary vectors. There is no significance associated with them, per se.

1. Is there any threshold to select the number of components?  How can we decide the number of components to have a more accurate analysis?
  > The question directly relates to how much of the variance you want to cover.



## Preprocessing

1. Could you go through this piece of code in your notebook (In [3])?
  ```
  from numpy.linalg import svd
  X = combined.values
  Xm = np.tile (np.mean(X, axis=1)[np.newaxis].T, (1,X.shape[1]))
  U, S, Vt = svd(X-Xm, full_matrices=True, compute_uv=True)
  ```
  What is actually happening here? I do understand that the generated output is the U matrix containing the eigensamples and genes, S matrix which is the singularvalue matrix and Vt which is the samples and eigengens. However, I do not follow what is happening beforehand and what the Xm is used for.
  > Great question. We often centralize (i.e. remove the mean of each probe) our data before SVD. In the code, `np.mean(X, axis=1)[np.newaxis].T` will render a one dimensional matrix with the mean expression value for each gene. Subsequently, you `tile`, i.e. copy that 1-dimensional vector in `X.shape[1]` copies into a matrix od the same dimension as `X`.   


## Kernelized versions of PCA
1. Do the parameters you are investigating have to be linearly correlated or can they be non-linear correlated?
  > Not in the standard formulation of PCA. However, there are [kernelized versions of PCA](https://en.wikipedia.org/wiki/Kernel_principal_component_analysis)

  1. Can one combine the dimension reduction in PCA with the addition of a dimension in kernel function to linearly separate data points?
    > Yes you can.


## Linear transformations

1. In the article "SVA analysis of gene expression data" they write that n is the columns of gene expression data, and that if r<n the transcriptional responses of the genes may be captured with fewer variables if we use gi' instead of gi (gi being the gene transcriptional response). Also they write that due to presence of noise r=n in any real gene expression analysis application.
Could you clarify this? I have a hard time understanding what r is, why r has to be less than n for gi' to capture the response instead of gi, and why r is always equal to n due to noise in real applications?
  > I am guessing that you are reffering to Kluwer et al.  This is hard to explain if you did not read algebra and geometry in your curiculum. r is the [rank](https://en.wikipedia.org/wiki/Rank_(linear_algebra)) of the matrix, which in some cases can be lower than the lowest dimension n.

1. "If r < n, the transcriptional responses of the genes may be captured with fewer variables using g'i rather than gi. This property of the SVD is sometimes referred to as dimensionality reduction"
  In the above statement, it says that if the rank of the assay matrix X is less than the number of columns, (i.e- assays), the transcriptional response can be defined by fewer variables. How does this happen? Will the reduction in rank of the assay matrix reduce number of dependencies?
    > *r<n* only when a column or row in the matrix X is a linear combination of the other.


## Notebook

1. What do the sentences “the genes pointing in a positive/negative direction for the two components” at the end of the jupyter notebook mean?
  > The genes with the higest resp lowest Eigen patients 1 and 2.

1. In the final steps of the exercise presented in the notebook, the aim is to identify the genes that are more likely to be responsible for the observed difference among of lung cancer data points. The eigenpatients associated with the genes are investigated, and the KRT17 gene is identified as the minimal eigengene for eigenpatient 1 (i.e. the gene that least explains the variance in the dataset) and as the maximal eigengene for eigenpatient 2 (i.e. the gene that most explains the variability). Is this correct?  If so, does this mean the KRT17 gene explains the variation in the dataset better than the other 2 identified genes? Could you please elaborate a bit further the interpretation of these results?
  > Your interpretation that KRT17 drives both eigen patient 1 and 2 and hense is a better explanation of the data than the other genes could be right. [KRT17](https://www.proteinatlas.org/ENSG00000128422-KRT17/pathology) is a known cancer related gene. At this point of the analysis, it is not fully clear what the biological interpretation of PC2 is.  From the eigen gene plot, it is however clear that PC1 seem to capture the difference beween LUAD and LUSC.



## Other

1. The whole "Kluwer et al." paper is beyond my comprehension. From the Jupyter notebook I've barely understood what SVD does in general, but I still don't get the main concepts.
  > It would be helpful if you point out at what part of the paper you stopped understanding the text.

1. What's the form of the eigenvectors?
  > Vectors?

1. Are they "ranked" according to their relevance in describing the overall variance?
  > Yes that is right. PC1 describes more or equal of the variance than PC2.

1. If you have m patients and n genes, you'll obtain m+n eigenvectors in total, but the PCA components should be mxn (one per dimension): how can you compare the two things?
  > No, you have <= min(m,n) principal components.

1. The VaderPLas page seems to describe PCA in two different ways in the case of low-dimensional data and in the case of high-dimensional data: I’m failing to reconnect this two descriptions. The first case is based on the process of projecting the data points on the component’s line: this is fairly easy to imagine (and to do) for bi- or tri-dimensional data, but is this concept applicable to high-dimensional data as well? I would say that in theory it’s feasible, but then, in the digits example, it is suggested to imagine the construction of a single picture as:
image(x) = mean + x_1 *(basis1) + x_2*(basis2) + x_3*(basis3)+...
  It appears to me that the concept of “projections” is lost here. I also wonder if it’s possible to apply this latter kind of simplification to bi-dimensional data sets.
  According to the example, image(x) is a single data point and [X_1, X_2, ...] are its pixel values. It is also stated that PCA can calculate both the “mean” and the 64 basis and that you can obtain a close-resembling reconstruction of the digit’s picture only by exploiting the first 8 components. If the “mean” and the various “basis” are constant for every data point, that would mean that only the first 8 pixels values (the upper line of each picture) are enough to characterize 10 different types of digits (hard to believe). On the other hand, if these values are not constant, that would mean that PCA works on clusters and not on the whole data set (which would make perfectly sense, but then why this fact is not even mentioned?).
  >  I excluded this part of the text as preparational material, as it might be confusing, The word [projection}(https://en.wikipedia.org/wiki/Projection_(mathematics)) has the meaning of a function that maps data points in one space to another space. Also, in the eigen digit example, VanderPlas only keep 8 values, but they do so together with their "basis" (eigen digits), which each have the same dimension as the orignial images. However, given that they have a large number of images 8 values per image + 8 eigen digits is a compression of data.
