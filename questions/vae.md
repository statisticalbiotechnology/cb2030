## Outline
3. Loss functions (again)
1. Gradient descent
2. Gradient calculations
4. GPUs
5. ANN optimization
6. Latent spaces

# Questions and Answers on Principal Component Analysis.

### Notation

The symbol ![](https://www.geeksforgeeks.org/wp-content/ql-cache/quicklatex.com-4c14f913b3923bb3f6f1496803e1d9e0_l3.svg) should be interpreted as "is member of", and is used when describing elements in sets.


### Degrees of freedom
1. I don't understand the link between the degree of freedom of the autoencoder and the possibility to encode and decode without information loss. "In such case, the high degree of freedom of the autoencoder that makes possible to encode and decode with no information loss (despite the low dimensionality of the latent space) leads to a severe overfitting implying that some points of the latent space will give meaningless content once decoded" (blog on VAE)
   > I am a bit confused with the terms the author use as well. You could expect to use about the same number of neurons in an AE as in a VAE. Normally, we use the number of weights (which is proportional to the number of neurons) as a measure of the degrees of freedom for an ANN. However, here the author seem to point to the fact that the regularization scheme in a VAE restricts the degrees of freedom of the learner in a practical sense. The noise injection of the regularization scheme limits how much a VAE could be overfitted, as we for each example have to assure that not just the point estimate, but the whole distribution of latent variables generate a good enough output. 

### Tensorflow Playground
1. In Artificial Neuron Networks (specifically playing around with the additional tool from playground tensorflow), how does the combinations of different stacks of hidden layers affect the end result exactly? How does it work?
   > The [tool](https://playground.tensorflow.org/) colors the decision surface of each neuron so that you can follow how the final classification is made. If you want an up-scaled image, just hoover with the mouse pointer over the neuron, and you will see the decision surface as a color map in the panel to the right. 

### Overfit/Underfit

1. Since VAEs also optimise for regularisation, and not only for performance, are these models likely to perform less well than regular autoencoders? Is there a trade-off here, or is there merely a more complex/intensive training process?
   > There is always a tradeoff between capturing variance or bias, see our lecture on SVMs. Capturing the data too well leads to an overfitted model, relying on regularization leads to underfitting. However, here are a couple of additional considerations, 1) VAEs *are* actually optimized on performance, however, their optimization fuction also contain a regularization term to assure gaussian latent variables. 2) Note as well that both VAEs and AEs are optimized on their training sets and not their test sets. So optimizing for "performance" might not lead to good performance on the testset.

1. In the video (around 6 min), a variation autoencoder is described as: "...an autoencoder whose training is regularized to avoid overfitting...". What is the risk associated with overfitting?
   > It has to do with that the autoencoder would then be too specific and it would not be applicable to other datasets except the one used for training
   > > Data overfitting will lead to a lack of interpretable and exploitable structures in the latent space, so you can not achieve a functional dimensionality reduction in this case.

### Lossless/Lossy
1. In the blog post, it is written that the encoding can be lossless (no information is lost when reducing the number of dimensions) or lossy (some information is lost when reducing the number of dimensions). Is there a way of knowing if we have a lossless encoding or a lossy encoding? If we don't know if we have a lossless encoding or a lossy encoding, what consequences will that have? 
   > This is a general property of encoders/decoders. If you can perfect recreate an example from its compressed data it is lossless, otherwise its lossy. A zip-file is an example of a lossless encoding scheme, a gif-file is an example of lossy encoding.


### Regularization

1. What is meant by a local vs a global regularization of the latent space?
   > The VAEs regularizaion scheme ensure that each datapoint is encoded with a distribution, which makes it a local regularization scheme (local to each data point). It also ensures that you still on average predict the right thing, which makes it a global regularization scheme.

1. For variatonal autoencoders, they mention that auto encoders tend to overfit the training data. Do they mean that the encoder-decoder duo is very inflexible and not appropriate to use on other data than the training data? 
   > Yes I think that is basically what they mean with this. The main reason for this is that the autoencoder, in comparison to the variational autoencoder, have a clumsier regularization scheme. 
   
1. In the blog the author pointed out several times how important it is to have the regularity of the latent space. The definition of "lack of regularity" is given in the blog as "lack of interpretable and exploitable structures in the latent space", however I'm still confused about what it actually means, and how the organization of the latent space affects the encoder-decoder architecture. 
   > From my understanding, the point of having regularity of the latent space is to be able to generate new content (i.e. pick a random point in the latent space and decode it into a new content). If the latent space is irregular (overfitting the original input data), it will be difficult to carry out this process because the points in the latent space are not well organized so we cannot interpret a relationship between them, and there will be some points in the latent space that do not give meaningful content after decoding. 
   > For instance, in terms of the Notebook, you see that there seem to be a direct correspondence between the latent variables and which datapoint that a datapoint comes from. 

1. In the blog post it is mentioned that the regularity can be expressed through two main properties, one being continuity. Which is explained as "two close points in the latent space should not give two completely different contents once decoded". How can two different points not have two completely different contents? What similarities between the points are we expecting? 
   > Take the notebook as an example. It seems like the examples of one cancer forms are close in latent space to other examples of the same cancer form, but still distant to the examples of the other type of cancer. That is what is meant by the comment.


### Why distributions?
1. Variational autoencoders are just like autoencoders but encode the input as a distribution instead than a single point. This the blog argues that should avoid overfitting (regulates the training process) and makes the latent space for the generative process. However I do not understand this relationship. I do not understand how changing the encoding to a distribution avoids overfitting and enables the generative process. 
   > Overfitting is avoided and the generative process is enabled by regularizing means and covariance matrix and means of distributions. So, by making the latent space "smooth" (forcing its regularity) we make sure that generated structures make sense ( enable generative process).   
   ![](https://miro.medium.com/max/720/1*9ouOKh2w-b3NNOVx4Mw9bg@2x.webp)   
   Overfitting arises due to an extreme degree of freedom of the encoder and a small latent space (a bit similar to a biological bottleneck). By putting constraints onto the distributions returned by an encoder, we limit its degree of freedom and make the "bottleneck" less obvious -> reduce overfitting.
   > > I think it requires both: representing the data points as distribution and regularizing those distributions.

### Notebook

1. Why are we getting such a different answer between the PCA and the VAE  to same question:
in the PCA notebook we say that KRT17 is important to both eigengorups, but with the VAE we say that KRT17 is quite different between the groups.  Yes in both cases KRT17 is a solution but with VAE we get two other genes first GNA14(min) and S1PR5(max) and with PCA we also have SFTB  and RGL3.
   > Too me it is reassuring that we see that we can re-find the same genes in at least top-500. Its rare to find a perfect correspondence between PCA and VAE.

### VAE vs. PCA
1. We have now talked about both PCA and autoencoders for dimensionality reduction. When should we choose PCA and when should we choose autoencoders? What are the pros and cons of the two methods?
   > I think PCA is much quicker and easier to apply than VAEs. However, VAEs do not assume orthogonality and can handle non-linear relationships well. But it is unclear to me if there are drawbacks of doing a PCA with kernel transformed data compared to a VAE. 
   > > I dont know when kernel PCA is better/worse than a VAE, but it might be a fun test to try out. In PCA of Carcinoma notebook, try replacing the PCA call with a [KernelPCA](https://scikit-learn.org/stable/modules/generated/sklearn.decomposition.KernelPCA.html) call and see what happens. 




### Applications of VAE
1. In the notebook you look at the gene expression of two different lung cancers, can VAE be used to look at more than two different cancer types simultaneously?
   > From my understanding, yes, VAE is exactly capable of differentiating more than 2 types (and apparently very good at it). As shown in the example in the blog, it is capable of sorting birds, dogs, cars, and planes.
   > > VAEs are for instance used for describing multiple states of multiple celltypes in [single cell sequencing](https://scvi-tools.org/) and [generating mugshots](https://github.com/wojciechmo/vae). Throwing in a couple of more cancer types would not be extreme.



### Supervised training of VAEs
1. More of a general question, but it thighs in with ML concepts. Wikipedia says: "Although VAE model was initially designed for unsupervised learning its effectiveness has been proven for [semi-supervised learning](https://openaccess.thecvf.com/content_cvpr_2017/html/Abbasnejad_Infinite_Variational_Autoencoder_CVPR_2017_paper.html) and [supervised learning](https://direct.mit.edu/neco/article/31/9/1891/8494/Supervised-Determined-Source-Separation-with)." My question is: was that not to be expected? Isn't supervised learning, unsupervised learning "with help"? So I'd expect that if a method works with the more complicated scenario (unsupervised L), it would also work in the more straightforward one (supervised, semi-supervised L), and use the additional information to correct itself. 
   > Many unsupervised methods dont have a natural way to introduce labels. E.g. k-means don't have a way to make two labeled datapoints to belong to the same cluster.  


1. Are autoencoders mainly/only used for dimensionality reduction but not for supervised machine learning tasks? Is there any advantage of using an autoencoder over a VAE?
   > That are mostly used for generating data. You can extend VAEs so they can be supervised or semi-supervised.

2. Would variational auto encoders work with supervised learning as well, or does it only work for unsupervised learning?
   > There are so called [semi-supervised variational autoencoders](https://bjlkeng.github.io/posts/semi-supervised-learning-with-variational-autoencoders/) where some of the data is labeled but not all. For how far as I know is variational autoencoders not used for fully labeled data (supervised learning).



### Generative models

1. From the blog post, it seems like autoencoders function in a similar way as PCA by being able to reduce the dimensions. The introduction of variational autoencoders is then to allow for content generation. What does content generation practically mean and what would be an example?
   > By content generation, I think they mean the final step in the process. Data taken from the latent space can be decoded to generate the content, it is essentially the reconstructed data. I agree that using the word "generation" can make it confusing, since the objective is to reconstruct the same data as was in the input. An example could be the final image that is given as output. 
   > > One can use generative models for generating mor explicit data. An example that frequently is reported in main stream media is [DALL-E 2](https://openai.com/dall-e-2/), that uses a generative model (a diffusion model) to generate images.

1. We sometimes speak about generating new data, i.e. generative models. In what context is generating new data helpful? In my opinion, we can't use the newly generated data to improve the algorithm, meaning it can't help us learning more about the data we already have, or can it?
   > An example where one actually generate data is [scVI](https://scvi-tools.org/).

### Distribution of latent variables
1. In the blog post, I didn't understand the mathematical derivation of (g*, h*) for N(g(x), h(x)), the distribution for q_x(z).  
   > They write that they will "approximate p(z|x) by a Gaussian distribution q_x(z)". Then they describe that they do so using a neural network to estimate two functions g(X) and h(x), that will be the mean and standard deviation of z. They then just state that this as a formula: q_x(z) = N(g(x),h(x)) 


### Loss function
1. In the slide, from the figure we could know that the VAE is a probabilistic encoder and a decorder also generates a probabilistic distribution. My question is that whether the two distributions will interfere with each other under different settings? 
   >  If they do, the reconstruction error likely increase, so it is something that you avoid by using a loss function that includes reconstruction errors (e.g. MSE or cross_entropy).

2. Why are Kulback-Leibler divergence used in the loss function?
    > KL-divergence is used to measure differences between two distributions. In this case we include KL-divergence in the loss function to detect difference between the z-variables distributions and normal distributions. 



