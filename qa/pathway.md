# Questions and Answers on Pathway Analysis.

1. Is it possible and better to combine the different pathway databases (including metabolic pathways, interactions, and gene ontology) for one analysis?
  > This is an open research topic within multiomics analysis. It should be entirely possible to do so, however, I have seen very few successful implementations. One problem is lack of pathway definitions. However, some pathway definition databases like KEGG and Rectome actually do contain information on both metabolites and proteins.

1. In the video you mention that GSEA can only look at either up- or downregulation at one time, not simultaneously. I guess this is because the Enrichment Score is decided by the maximum deviation from 0 and then doesn't care about the genes in the other end of the gene set. Is this a problem or are there ways or variations of the method to overcome this?
  > There are some efforts to handle this. For instance, at least one study uses the absolute value of the differences between case and control rather than the difference itself. However, I do not think that method is frequently used. GSEA it self solves the problem by having two different tests, one for up and one for down regulation. The problem, however, is that we are not making use of the most striking feature of this analysis, the co-variation between the gene-products we are studying. We are currently developing methodology for this in my lab.

1. In the notebook the number of permutations for significance estimation is set to 100 to speed up the calculations but it was still very slow when I tried to execute it (in the binder server thing). Is the method typically slow or was it just the server?
 >  No, the calculations should be quick. However, the `gseapy` package does not execute its code locally, but instead submits each geneset as a job at the gsea or enrichr servers. This slows down the execution.


1. In notebook, the final FDRs seem high, being around 0.6~0.7, does this mean the pathways are most likely not enriched?
> Yes! Or at least that this implementation of pathway analysis does not pick up much signal.

1. Are there any cases, regarding differential gene expression, where it's better to not perform a pathway analysis, where individual measurements are preferred?
  > It all depends on what you are interested in reporting as a result.  

1. In the article by Kathri et al, section First Generation: Over-Representation Analysis (ORA) Approaches, we can read that solving one of its limitations (that only the most significant genes are used) by using an "iterative approach that adds one gene at a time to find a set of genes for which a pathway is most significant". I do not quite get how this solves the problem? How are the genes chosen if not by a threshold? Do we analyze all genes that we have analyzed by using this method?
  > Sure you use a FDR treshold, but you keep on increasing it until you see the result you want to get. Did I ever tell you that much systems biology stands on methods that should not be investigated too closely?

1. In the gene enrichment analysis I didn´t really grasp how the null distribution is being calculated and it was a bit unclear to me why permutation of class labels gives better results than permutation of genes, and a better biological assessment?
  > I think that they mean that if they would exchange individual gene+sample pairs with each other, they would get an expression matrix that would be too easy to distinguish from a real matrix. It should be noted, that [permutation tests}(https://en.wikipedia.org/wiki/Resampling_(statistics))  is seen as a gold standard for non parametric testing.

1. Could you give an example of a suitable metric that could be used in ranking the genes in the gene enrichment analysis? How is the suitable metric being chosen?
  > *p* value for differential expression is a suitable sorting score. In practice, the input to the *p* value calculation procedure, the [*t* statistic](https://en.wikipedia.org/wiki/Student%27s_t-test#Equal_sample_sizes,_equal_variance) is frequently used. However, this might not be what you ask for. The GSEA method includes a score for different rankings (which is shown in the lower subplots in the notebook). That score is part of the secret sauce of how they score leading edge genes. If you want the arethmetical details, they are given in Equation \[1\] of the Subramanian *et al.* paper.

1. The overrepresentation analysis seems to have many limitations that are being addressed by other pathway analysis methods, but seems that is the most commonly used? Why is it preferred over the other methods?
  > It is mostly used as it is easy to calculate.

1. I am a bit confused about the plots obtained from the Gene Set Enrichment Analysis in the jupyter notebook. What does it mean to have a negative enrichment score (as in the plot)? Is it correlated to down-regulation of the genes in the pathway?
  > Yes, it means that the downwards trend is stronger than the upwards trend at that part of the plot. However, gsea cares about the "leading edge", i.e. the left most part of the plot.

1. What does the plot below the enrichment score tell us? Can you explain the difference between the axes and why it is a vertical line in the middle of the plot?
  > It is pretty well described by te Subramanian *et al.* in my mind. The line gives you marks the median of all investigated genes.

1. The general limitations using a knowledge based-driven pathway analysis seems to be:
  - Low resolution knowledge bases, missing condition- and cell-specific information, and incomplete annotations restrict development of the next-generation pathway analysis methods.
  - The inability to integrate the dynamic nature of a biological system in analysis limits the utility of existing methods.  
Would you say these are also the main limitations with GSEA? Or are there other limitations as well?
  > I do not fully get the "dynamic nature" of pathways, but your first point resonates well with me. I would add the methods inability to detect covariation between the gene products as an aditional weakness.

1. Regarding ORA, the article by Kathri et al mentions that one of the limitations is that it assumes that each gene is independent of the other genes (more generally, analytes, I assume), which might yield biased or incorrect estimates of pathway significance. This sounds like a very bad assumption to make when studying pathways, and it sounds as though it would produce very severe errors, and thus extremely unreliable results. Since the method is still used: how severe and common do these errors tend to be?
  > I am not really sure myself. Overall, the method seems to be reliable enough. I so not like the fact that the method is not taking quantative differences as input, but rather lists of genes, and that its test statistics does not relate to quantitative differences between case and control, but instead tests the sizes of genesets. That makes the test statistic hard for most biologists to [interpret](https://academic.oup.com/bioinformatics/article/23/8/980/198511) (and the general problems of the interpretation of *p* values makes this worse).
11:51
