
### Outline 
1. Pathway databases
2. Over representation
3. GSEA figures.

# Questions and Answers on Pathway Analysis.


### General

1. In the paper they say that it is better to analyse sets of genes compared to individual genes (as traditional studies do) for various reasons, why do we still use methods for looking at individual genes? Are there instances where it still is better to look at individual genes for genome wide studies? 
   > Pathways databases are still incomplete giving a lower coverage of the data. Also, pathway analysis methods tend to be sensitive to biases in gene expression.
   > > I think if you have a large microarray panel, you will most likely look at gene sets to avoid the statistical complications mentioned in the paper. However, I can imagine that if you only use a small gene panel in an array for whatever reason (e.g. probe design, benchmarking, ...) perhaps these statistical complications are very minor and you do not have sufficient genes to actually perform a set-based analysis. In such a situation I can imagine gene by gene analysis to be appropriate. 

1. In the video lecture, over-representation analysis and gene-set enrichment analysis were mentioned as two common methods for pathway analysis. Are there other methods that are commonly used? And how do you choose which method to use?
   > A good review is given by [Nguyen *et al*](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1790-4). As of 2019, more than 70 methods have been developed to perform pathway analysis. They divide them into two categories:   
      * Non-topology-based methods (or "gene set analysis methods"): consider pathways as simple un-ordered and unstructured collections of genes
         * Classical statistical tests:  Kolmogorov-Smirnov test, Wilcoxon rank sum test
         * First generation: ORA
         * Second generation: functional class scoring methods (FCS) - GSEA falls into this sub-category
      * Topology-based methods: consider the dependencies and interactions between genes.   
   > In the review, they compare the performances of 13 representative pathways analysis methods on 86 real data sets. It might be worth a read if you are interested.

### Pathway databases
1. I was wondering about how complete the pathway databases are. There are still proteins and genes we don't know the function of or how they participate in processes in the cell. Does this have an impact on the accuracy and efficiency of the GSEA method because of 'incomplete' datasets?
   > Yes it does! The latest version of [reactome](https://reactome.org/about/statistics) includes proteins from 11097 human genes, about half of all known genes. 

### Overlapping pathway definitions

1. GSEA takes genesets as input. I was wondering what would happen if one gene falls into multiple genesets. Would the gene be included in the tests of all such sets?
   > Yes, if a gene is in multiple gene sets it will be counted as a hit for all those gene sets. This can result in some gene sets being significant even though they may only have genes that are overlapping with other gene sets and has no other significant genes. There are also other types of overlap: is might be so that this gene set is part of a gene set network (a gene set in a gene set) or that another gene set has additional significant genes and thereby more significance. There are now different algorithms and methods that can look at the overlaps and discard gene sets whose significance is only due to its overlap with other gene sets. See e.g. this [method](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-017-1571-6).


### ORA vs. GSEA
GSA uses quantitative values as input, ORA don't. That is the main difference between the strategies.

1. I still don't understand how the input/output of both the ORA and GSEA differ and what their individual applicatory advantage is?
   > The ORA takes a gene list as input. Those gene lists are derived from differential expression analysis by selecting the most differentially expressed genes (based on a logFC cutoff). As an output, it gives a list of pathways enriched in a given gene list.  
   > On the contrary, GSEA takes the full expression matrix as an input. It first calculates correlations between gene expression and the conditions (e.g. disease) and ranks them based on correlation. After ranking, it checks whether a given pathway gene set is overrepresented at the top (or bottom) of the ranked gene list. As an output, it gives us the same as ORA.
   > The biggest advantage of using GSEA is that we do not threshold genes based on expression as it is biologically irrelevant in many cases.

1. In the paper, GSEA weighs the steps according to each gene's correlation with a phenotype to represent a biologically relevant correlation between gene sets and the phenotype. How does ORA represent a biologically relevant correlation between gene sets and phenotype? 
   > It doesn't. ORA doesn't account for phenotype correlation. It only infers a gene set belonging to a pathway gene-set by determining the significance (randomness probability) of the overlap. That's all it does. That is why GSEA provides a more relevant inference. However, ORA is less computationally expensive (I believe), and it is a good tool to give you a fast overview of the possible pathways that you can further examine. 

### Sample size
1. In the article they mention that we can use GSEA even for the data sets consisting of small amount of samples, although the approach used in that case does not give an accurate result. I was wondering what number of samples we would have to use to be able to use the standard approach and get a relevant outcome. Is there any specific threshold?
   > I'm guessing that we can't put an exact number on what constitutes a "large enough" dataset. From the article when they are analyzing adenocarcinomas, they look at 3 different data sets and conclude that one of them is likely too small to have been able to provide useful information. This one had 24 samples, while the others had 62 and 86 respectively, which gives us some idea of how big the sample size might have to be for GSEA to work for it, although the number of genes analyzed for each sample likely also plays a role. 


### Weighting schemes in GSEA

1. In the paper, they write that when the enrichment score is calculated, the magnitude of the increments depends on the correlation (or other ranking metrics) of the gene with the phenotype. What ranking metrics can be used? And how are the correlations/ranking metrics determined? 
   > The [GSEA user guide](https://www.gsea-msigdb.org/gsea/doc/GSEAUserGuideFrame.html) section "Metrics for Ranking Genes" states that for categorical phenotypes, GSEA determines the gene's mean expression value for each phenotype and then calculate the differential expression between the two given phenotypes. The default metrics for calculating the differential expression is signal-to-noise: (μA-μB)/(σA+σB), which in their interpretation is the difference of mean divided by the sum of standard deviations. The larger this value is, the more distinct/correlated the expression of this gene is to the phenotype. The page suggests other weight metrics as well.

1. "We addressed this issue by weighting the steps according to each gene’s
correlation with a phenotype. We noticed that the use of weighted
steps could cause the distribution of observed ES scores to be
asymmetric in cases where many more genes are correlated with
one of the two phenotypes."    
Could anyone explain to me what is meant here with the asymmetric ES scores, and how that could be the result of using weighted steps? 
   > By asymmetric they mean that they have more or less positive ES scores that negative ones.



### Over representation analysis (ORA)

### GSEA
1. In the paper, I didn't really follow the section about normalizing ES to size of the gene set. As I understood it, this was done by dividing both simulated and actually calculated ES by the mean ES over 1000 permutations of phenotype labels. I can imagine that the mean ES when phenotype labels are randomly permuted can be expected to correlate with the size of the gene set. But if so, wouldn't it be more straightforward to just divide by the size of the gene set itself or does the method used in the paper incorporate other characteristics of the gene set that I'm not taking into account?
   > The section "Adjusting for Variation in Gene Set Size" in the supplementary text mentions that NES is calculated by "separately rescaling the positive and negative scores by dividing by their mean value".

1. In the paper they described how to calculate the ES score and it was shown graphically in fig 1A. They wrote that "the enrichment score is the maximum deviation from zero encountered in the random walk. I have come in contact with random walks mainly through financial time series but what is meant by that here?
   > Likely the same thing as in your econometrics book. I.e. you simulate a path given an equal probability of taking a step in all directions, in this case up or down.  

### Correlation with phenotype

1. I don't know how did they relate phenotype to the expression profiles. For example, if they use (-1, 1) to indicate positively and nagetively related, what kind of function will they use within this range to represent relations?
   > I think the relationship with the phenotype is represented by the differential expression of the gene. E.g. we have the expression of gene X in healthy tissue (sample 1) and in disease tissue (sample 2). Then we calculate the differential expression between samples 1 and 2 (e.g. to what extend does expression of gene X change between healthy and disease state). This is done for every gene and it is then what we use as a measure for the correlation of the genes to the phenotype.
      > Typically one use a t-statistics to measure this 
### Validation

### Significance



### Notebook


### Other 
