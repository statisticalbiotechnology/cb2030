# Questions and Answers on Principal Component Analysis.

## Errata

2. At 11:58 in the youtube video lecture, the eigengenes are the columns in the u matrix. However in the slides before, I would make up that eigengenes are the rows in transposed v. What am I seeing incorrectly here?
> Nice catch. I am just missspeaking. As a correlary you can see in the code that I am taking values from Vt. 

## SVDs relation to PCA
* A more elaborate answer can be found [here](https://math.stackexchange.com/questions/3869/what-is-the-intuitive-relationship-between-svd-and-pca).
1. What is the relation between SVD and PCA, is SVD just a method for performing PCA?
   > In simple terms, I believe SVD can be described as a method for factorizing a matrix into factors (containing certain components, e.g. numeric variables) and that PCA is a method for analysing these components, e.g. approximating the factors by only selecting PC1 and PC2.
1. It seems that PCA and SVD are two similar methods used for the same purpose of extracting principal components, but differ in some ways. Can they be used in the same types of cases, or when is it suitable to use one over the other?
   A3I was also confused about this when I read the material. But as I understand it, PCA can be done in more than one way where singular value decomposition is one of the methods we can use (I.e. we use SVD to perform PCA). But I am not sure about when to use SVD over other methods (like eigen-decomposition of the covariance matrix) to do PCA?  

3. SVD, singular value decomposition, is a way to factorize a matrix. Is it always used together with PCA or does PCA has other inbuilt methods for matrix processing?  

## Applications

1. Since we have covered two methods of unsupervised learning, k-means clustering and PCA, how do we know when to use which method? Since the two methods focus on different things, could we combine both methods on the same data set or would this be redundant?
   > Very good question, and you guessed it right, we indeed use both of them usually. They are both unsupervised learnings but they have different goals. We can usually use a dimension reduction method like PCA on our data to filter out the noise and chose the principal components with the highest variance for easier separation. Then we can use some kind of clustering method like k-means on this pre-processed data. Furthermore, sometimes they even combine different dimension reduction methods to gain even better results, so this could be called rather redundant, but it has a positive outcome. 

2. How do we know that we need to perform dimensionality reduction on our data before we perform other types of analyses (such as clustering)? Or is it always good to perform dimensionality reduction? 

7. I can imagine very easily cases where we would want to investigate the co-variance of variables and to find the vectors u and v that form a matrix M, however what are some examples for "real-world" reasons we would be interested in finding the residuals of a matrix (after doing the calculation M-(u*vT))?
  > Say that you want to examine the variation between patients weights and squared lengths. First PC would then cover the linear relation between the examined variables and the second component would capture the patients bmi.  


## Linearity
8.  What will be the effect of outliers on the results of a PCA analysis. Since it works on the principle components, wouldn't it be severely impacted if they are taken into consideration? 
    > Yes, you dont want to have outliers in your dayta when you do any linear correlation analysis.

## Linear rooms
3. I’m a bit confused over what the difference is between principal axes and principal components. From the video I get the interpretation that they are the same based on the way principle components are described in the video compared to how principle axes are described in VanderPlas. Whilst from VanderPlas, principal axes seem to be vectors describing the variance of the data and where the projection of these data points onto the principle axes are principal components. My question is, is there a difference between them and if so, what is it? 
    > I had the same confusion, but what I understood from VanderPlus, the principal component is synonymous with principal axis (or eigenvector) but they are not the same.
    > Principal axis is the direction that indicates the most variance in the data set and gives the relation between the dimensions (x and y values) of the data set. Principal component is the extrapolation/projection of each data points on that principal axis, which is used to measure the variance of the data points. And the number of principal axes depends on the number of dimensions of your data set. The principal component correspond to the coordinates of observations on the principal axes of the data set.

## Explained variation
In VaderPlos you actually get an alternative way of looking at how much variance is explained by a number of componenets, check out the "Example: Eigenfaces" section and how they graph "cumulative explained variance" vs nr of components.


1. [Singular value matrix] It is stated in the page by Wall et al., that the S-matrix is ordered so that the magnitude decreases when going downwards the diagonal. This makes sense since the first principal components sometimes are enough for PCA. How are these relative magnitudes calculated from the data? And would it not be simpler if the values were multiplied into the vectors instead, unless it serves the purpose of transparency of the method?
   > The S matrix values are directly related to the amount of variance explained by each principal component. As explained [here](https://stats.stackexchange.com/questions/171539/percentage-of-variation-in-each-column-explained-by-each-svd-mode), you can directly use them to calculate the proportion of the variance explained for each PC.

2.  From: VaderPlas on the section Principal Component Analysis  I do not understand the Choosing the number of components part. The variance ratio is explained as a function of the number of components. I do not understand the purpose of it,  should we choose the amount of components with a high or low percentage of variance? 
> You want your axis to explain the most amount of variation possible with your new axes.

1. PCA can be used for dimensionality reduction, which means reducing the dimension of the feature set. Will the dimensionality reduction not lead to a huge loss of information which then leads to hard interpretation of the transformed features?
   > A1: Not a huge loss in general. As explained in the VaderPlas on Principal Component Analysis, it only eliminates the least important information along the axes by keeping the parts related to the highest variance to differentiate the components. Therefore, although it based on dimensionality reduction, the main relationships among the data points are still maintained.
   > Considering your question, PCA is probably not very efficient if you have much more complex high dimensional data set since PCA could be affected by the outliers. However, there are different and more complex versions of it as well to tackle the issues mentioned. 
   > In practice, I would say that PCA is an easy and efficient starting point to get an initial idea about high dimensional data. Then, more complex variants of PCA could be implemented. Also, one may try other dimensionality reduction techniques, such as tSNE and UMAP, and compare those and see which one works better. 
   > A2: I would only add up that how much of the information you loose depends on the structure of the data. More precisely, on how well it covaries. We have all seen in the "demo" notebook with shoe sales, how one can reduce seemingly 4D data into 1D (we only use first components) without any data loss. This is of course idealised example - the data covaries perfectly here. Usually that is not the case.   
   > What is nice in PCA, is that you can actally find out how much of the variation in data is maintained on the graph you have used. Eigenvalues (related to the S vector from SVD, indeed L matrix containing eigenvalues will be S^2/(n-1) for the same dataser) correspond to how much variation is explained by each component. You can often see in literature barplots of relative eigenvalues for each PC, i.e. the percentage of all eigenvalues they make (examples of this kind of barplots you can see in Wall et. al.). Then it is explained that this values tells us how much of the variation each PC can explain.
   > Using real data you do loose a lot of information, in that sense. From my small expierience, rel. eigenvalues in range 0.1-0.2 are often seen as very satisfactory, especially for data with high dimensionality. So there is like 60-80% variation missing on the PC1 vs PC2 plot. This does not neccesarily need  to be a drawback. If you can see your data being divided by for ex. some conditions you are interested in, then in a sense, you have managed to capture variation that distinguishes the conditions. (Like lower PCs, if they do not correlate with your condition, might be the noise you wanted to remove, like in the image noise filtering examples from Vader Plas).

1. ''This makes clear what a PCA dimensionality reduction means: the information along the least important principal axis or axes is removed, leaving only the component(s) of the data with the highest variance.'' Why do we want the data with the highest variance? Isn't the goal to find correlations between y and x?
   > As I understood it, the variance you want to maximize is the variance of the data points along the first principal axis when they are projected onto it. You want to choose the principal component that maximizes this variance of the data projection since this means this line accounts for most of the datas' variance (and therefore the majority of the information within the data). From this, it follows that the smallest principal components explain the least of the variance and can be removed, which therefore result in a reduction of dimensionality while still retaining most of the information and the data point relationships.

1. As I understood it, the PC-plot only uses the 2 largest principle components to visualize the data. Is there a certain percentage level to how much the PC1 and PC2 account for the variation before the plot becomes too noisy or unreliable (where other PC account for a more substantial amount of variation)? Do we just determine this by eye?  
> This is primarly a philosophical question. If you know a good answer to the question: "when is your data well described by a measurement you made?" then you know the answer to your problem.

## Linking variation between sets
2. How should one approach a task of correlating specific external data (like discrete conditions or continuous environmental factors) with the PCA analysis?
> Single discrete or continous variables, [PLS-DA](https://en.wikipedia.org/wiki/Partial_least_squares_regression)  
> linking to other multivariate sets, [CCA](https://en.wikipedia.org/wiki/Canonical_correlation)  




## Eigen notaton

These question is best described by Wall et al.

1. Video [9:57] How does "eigensample" (or "eigengene") show variation between different genes (or samples)? By how I mean the interpretation of numbers.
   > Each eigenvector (in matrix mathematics) defines a principal component. Now, in this context, an eigengene set is analogous to an eigenvector set. In the case of an eigengene set here, it accounts for the expression level of every gene in that set. Meanwhile, an eigensample set is simply the set for the samples, and it accounts for the expression level of every gene in EACH sample in that set. So when you plot these 2 matrices as 2 principal components, you get the variation and correlation between the 2 data sets.
3. Do I understand correctly if I say that SVD is used for dimensionality reduction is PCA to simplify the dataset but still keep the maximum variance. I guess in reality it is more complicated than that, can we please cover the eigenvectors and eigenvalues in the classroom.
   > Eigenvalues/eigenvectors are covered excellently in this [video](https://www.youtube.com/watch?v=PFDu9oVAE-g).

## PCA
3. Is there a limit to how many variables one can have when performing PCA?
   > A1: The number of variables one can/should extract from PCA relies on two main factors: eigenvalues (check Kaiser's eigenvalue one criterion) and % amount of explained variance by the factors emerging from the analysis. Additionally, it can be helpful to draw a Cattell's scree plot where you retain all components within the sharp descent.
   > There are some other methods I am aware of like the Horn's parallel analysis, however I have never performed it myself and should better look it up before telling sth. completly incorrect about it. Some people tend to validate their results by the Kraznowski's cross validation approach, but I have heard different reasons not to do it/to do it, so I cannot really comment on it.
   > Finally, a good advice in statistics in general: Make a sanity check and consider what is meaningful.
   > A2: No there is no such limit, you can make PCAs even in infintie dimensional spaces.

4. In VaderPlas it is stated that PCA is certainly not useful for every high-dimensional dataset, when is PCA not useful?
   > When the co-variability between the variables in your set is not linear PCA will not work. 
7. In the Introducing Principal Component Analysis part in VanderPlas, they are discussing the vector that represents the data's principle axes. They say that the length of this vector shows how well it decribes the data distribution. Can we produce several of these vectors and then compare the lengths, or will the program automatically only show the vector that best describes the data set?
1. In the video lecture about "More principal components to your PCA",  we subtract u*v from M to get residues and a new matrix from which second principal components can be calculated from. But how come we get residues when subtracting u*v from M when u*v=M?  
  > You are not substracting u*v from M, but u(1)*v(1) from M. So you basically remove the first principal component. 
3. In the example in van der plaas, the two principal axes seem to be orthogonal, is this always the case?
   > Yes! 

## Dimensionality reduction

1. I didn't quite understand how are the reduction of dimensions is done. Should we just specify how many dimensions we want and then check if it accounts for the percentage of variance acceptable or does the application decides? 
   > Actually, you should specify the number of principle components (PC) that you want to apply to the dataset instead of the of dimensions of interest. Then you only select significant PCs for further downstream analysis. For example, I have a dataset of 2000 dimensions, and I decide to run PCA with 100 PCA to the data. After running PCA, it turns out that only the first 30 PCs are considered significant (P<0.05) . Here I choose only the first 30 PCs and discard the rest for further analysis.

1. In the given example regarding dimensionality reduction the dimensions decrease from 2 to 1. Is this what  the author means with the expression reducing the dimension of the data by 50%?
   > Yes.

1. How does reducing the dimensions assist us if the dimensions after reduction are more 3 and not observable by humans? 
> Its always esier to eyball a lower number of dimensions.

2. When we already have a primary of first principal component from the PCA analysis, why is there a generation of secondary principal component and so on? Isn't the main first Principal component provide with the all the data sufficient for further analysis? Why does the method involve further component classification when this does only probably complicate stuff?
  >  You describe the rule of [Occam's razor](https://en.wikipedia.org/wiki/Occam%27s_razor)!

4. I can kind of understand how PCA is done on 2D data, as explained in VaderPlas book or in the StackOverflow answer. But it is still very hard for me to imagine how this is scaled up for data with 3 or more dimensions?
  > Same here. This [video](https://www.youtube.com/watch?v=FgakZw6K1QQ) has a nice visual explanation for up to 3 dimensions that gave me a better understanding. Although we can’t visualize PCs in more than 3 dimensions, we can still determine them in the same way we did determine the second and third PCA. Basically, the first PC is chosen so that it accounts for as much variation in the data as possible. The second PC is chosen so that it accounts for as much variation in the data as possible, given that it is orthogonal to the first PC, which means that PC1 and PC2 are uncorrelated. The following PCs are chosen so they account for as much variation in the data as possible, given each additional PC is uncorrelated with the previously determined PCs, so that all PCs are uncorrelated.

## Preprocessing

2. Why do we have to use normalized data to perform PCA? Does using non-normalized data alter the PC detection that much? 
   > I think that if we do not normalize data beforehand we will probably have trouble since the principal components will point in a direction that looks to maximize the total variance. If the samples are not normalized it could lead to us thinking that a component had much more to do with the results than it actually did because the total values are larger despite the normalized variance being lower in comparison to the other parameters. 

5. Why is important to standardize the initial variables before performing PCA?
   > I think that the PCA calculates a new projection of our data set. And the new axis are based on the standard deviation of variables. So a variable with a high standard deviation will have a higher weight for the calculation of axis than a variable with a low standard deviation. so we need to normalize our data to make sure that all variables have the same standard deviation, thus all variables have the same weight. Then PCA calculates relevant axis.




## Visualization
1. After you calculate principal component 1 known as PC1 and other PCs depending on how many variables we have, is there any graphical representation to see the variation between PC1, ... ,PC4 and so on? 
   > I think what you're asking for is basically a graph looking like the one in VanderPlas under the heading "PCA for visualisation". In that graph they're showing the datapoints in relation to PC1 and PC2, so where different points end up in the graph depends on where on the different principal axes they were projected when extracting the PCs. In a graph like this you will be able to see how big the variation is along the different axes and also you may be able to see if you can separate the data based on any of the PCs. For example, we could see in the notebook "PCA of Carcinomas" how the datapoints coming from different cancer types seemed to separate quite well based on PC1. And I guess if you would want to visualise the variation between more PCs you could create this kind of plot with more dimensions or perhaps plot PC3 vs. PC1, PC4 vs. PC1 etc. 

## Kernel PCA
5. One of the main limitations of PCA is that it assumes linear relationships between features. Is it possible to apply a kernel to it in order to transform it? 
   > Yes

## Other
1. For SVD, it's a way of decomposition, which is a useful way to perform PCA. It's has been mainly discussed and explained in the video, but it never used in VaderPlas. At first, i thought it very important when i watched the vedio. But then realized VaderPlas didn't mention it.  

2. How would one go about validating the results from a PCA/SVD? I like to imagine that one would like to add a validation test to the model, but how would one do that? 
4. What are the limitations of PCA with high-dimensional datasets?
5. Are there other methods for efficiently doing the same thing as SVD that would be more appropriate to use in different situations?
6. PCA, UMAP, and t-SNE are different reduce dimension methods, I’m wondering in which condition we can use those method to simplify the data?
1.  How many axes can we set for PCA? What would be happen if we set the number as many.

2.  In previous courses, we've learnt that you will get much better, efficient and effective results by combining two or three different methods. I assume that this could also be the case for SVD and PCA, or are there any limitations that would make that impossible?
4. In the book, "rather than attempting to predict the y values from the x values, the unsupervised learning problem attempts to learn about the relationship between the x and y values." is that mean x and y are individual instead of x or y affects the result of y or x? and there is no training or testing, how can we know the results of the PCA are correct?
   > A PCA is always correct! It might be less applicable to some situations though.
3. In VanderPlas, regarding PCA for the 64-pixel hand-written digits, it is estimated that to explain 90% of cumulative variance you need 20 components in the PCA. Is 90% cumulative explained variance a level that you generally aim for when performing PCA? Are there cases where you need to be more or less strict? 
1. Will eigenvectors always have same amount of dimensions as the number of samples/genes/whatever we applying PCA on? If some sample has 0 effect on the variation of the data will it be skipped in the values for the eigenvector?
   


