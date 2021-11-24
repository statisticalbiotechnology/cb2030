# Questions and Answers on Pathway Analysis.


## ORA vs. GSEA
1. The GSEA method seem to pick out relevant genes more precisely because of the ranking, so I wonder when we would rather use Over-representation analysis?
   > You do not always have quantative data. Sometimes your analysis leaves you with a list of genes without expression values. Then ORA is your only option.



## Over representation analysis
2. What is the main difference between the David tool and the enrich tool?
   > None, as far as I know.

## GSEA

1. From the article by Subramanian et al., The magnitude of the addition to the running sum when encountering a gene in the list belonging to the gene set S is weighted according to the gene's correlation with the phenotype. In the article they write that this can "cause the distribution of observed ES scores to be asymmetric in cases where many more genes are correlated with one of the two phenotypes". What does this mean, and why is this a reason for estimating significance levels for positively and negatively scoring genes separately?
   > As far as I understood it means that if we detected many genes (lets call them group A) which are correlated strongly with phenotype A, their addition to the ES calculation will be "boosted" because of the weighting. This means that these genes contribution will dominate the ES score calculation and the distribution of these ES scores won't be a normal mid centered normal distribution but it will be asymmetric (shifted in the way group A genes determined).

1. The genes in a gene-set enrichment analysis (GSEA) are ranked based on the correlation between a biological state (e.g. phenotype) and the gene expression level, but is it possible to perform this type of analysis and look at multiple states at once?
   > As long as you can find a way to score the comparison at gene-level you can use a GSEA-like method

3. Youtube video, 7:45, Gene-set enrichment anaylsis. I did not get how similar distribution patterns can indicate that components are in the same pathway. Why would coming from the same population indicate that two analyses are co-regulated?
   > On the slide it says that differences in distributiutions between pathway genes and other genes is indicative of the pathway being differentially regulated. 

4. From the article, Table 1 and Figure 2. I don´t really understand how the nominal p-value of the S3: nkt pathway is decreased in significant so much from the original method to the new method. How do you calculate this?

5. For the GSEA paper:Step 1: Calculation of an Enrichment Score. First, i have checked the GSEA result and find that each gene in the expression file (list L) will have a individual score.can we conclude that it is just like Pearson, the higher the score, the closer the correlation between the gene and the biological state(e.g. phenotype?) 

6. When we calculate the NES，does it have a threshold like the p value to help us make a conclusion? is so, how big should it be?

7. In the paper: Step 2: Estimation of Significance Level of ES: “Specifically, we permute the phenotype labels and recompute the ES of the gene set for the permuted data, which generates a null distribution for the ES. The empirical, nominal P value of the observed ES is then calculated relative to this null distribution. Importantly, the permutation of class labels preserves gene-gene correlations and, thus, provides a more biologically reasonable assessment of significance than would be obtained by permuting genes.”  
   Does “by permuting genes” mean permuting the expression count of the genes, so that each gene is assigned to an expression count of another gene? If this is the case, I don’t understand how this would make sense at all? Or is it that I don’t understand what permuting genes means in the first place?
   > Yes it does mean changing the relation between genename and row in your expression column. This makes a null model that would be usefull for finding out how frequently you have genesets with an enrichment score at least as extreame as the current score.

1. From the article: "The GSEA-P software package includes tools for examining and clustering leading-edge subsets". I wonder how exactly leading-edge subsets would cluster? Since each gene set S that we choose to match with our L-list is essentially genes in a certain pathway of interest, isn't each leading-edge subset a different pathway as well? how would they cluster? Or what does a leading-edge cluster tell us? That those different pathways are related? 

1. I don’t understand how the genes are ordered in a ranked list L. It is stated in the article by Subramanian et al that the genes are ranked based on their differential expression between the classes. Then when picking out genes from L, one picks from the top and the bottom “i.e., those showing the largest difference”. What does “largest difference” refer to?
## Other 
1. From the video on pathway analysis 8:34, Gene-set enrichment analysis seem to be a popular tool for pathway activity but so does the Kolmogorov Smirnov test. Some articles seem to refer to the Kolmogorov Smirnov test as an alternative to GSEA so I was wondering which tool is the most effective one and what are the main differences between the two of them?


[Wed 15:43]
