# Questions and Answers on Pathway Analysis.


## Pathway databases

1. Pathway analysis seems to be very dependent on annotation, so I’m guessing that the availability of annotated data is a limitation. Would it be possible to combine different pathway databases in the same analysis in order to get access to more data (for example if two different metabolic pathway databases contain different data that’s both relevant for our analysis)?

1. To know the pathway of related genes, for example, I guess we should have the data of expression or something. And to get these data, we have to know the set of genes that are likely to be related each other since we have to do Knockout or Knockdown experiment. How do we get to know which genes are likely to be related? And how many genes are needed to make pathway which is reliable?
   > This is what kept biochemists buzzy the last century.


## ORA vs. GSEA

GSA uses quantative values as input, ORA dont. That is the main difference between the strategies.

1. The GSEA method seem to pick out relevant genes more precisely because of the ranking, so I wonder when we would rather use Over-representation analysis?
   

1. Is there any advantage og using Over-representation analysis over Gene-set enrichment analysis or vice versa?  
    > A1: Hey, as far as I understood, there is not advantage as such of ORA over GSEA, it's just two different analysis. Where in an overrepresentation analysis, the input is the significant genes after differential expression analysis, i.e. identifying the sets of gene in which the differentially expressed genes are over-represented or under-represented. The idea behind this is the pathway that contains significantly more than expected differentially expressed genes will more likely be related to the given condition.   
    > GSEA is a second generation of analysis method, designed to eliminate the dependency of the gene selection criteria on differential expression and takes into consideration all gene sets. The hypothesis behind this was that other small genes may also coordinate and affect the pathway even if not highly expressed.   
    > A2: According to an article called "Gene set enrichment analysis made simple" (Statistical Methods in Medical Research 2009); When comparing Over-representation analysis and Gene-set enrichment analysis. ORA works by forming a list of candidate genes using the marginal approach. Then, for each gene set, a two-by-two table comparing the number of candidate genes that are members of the category to those that are not members. A limitation of ORA is that it ignores all the genes that did not make the list of candidate genes. There are a couple of occasions where few or even none of the genes in functional groups known to behave differently in the two conditions survive the typical filters, and therefore the groups are not detected as interesting. Gene-set enrichment analysis does not have this limitation.

1. I understand that Over-representation Analysis and Gen-set enrichment analysis are two methods to do Pathway Analysis. But will the results obtained from these methods be equal/similar or can they differ a lot? I.e. are the methods equally sensitive?
  > Yes they are very different methods. Why don't you try them out?


## Over representation analysis
2. What is the main difference between the David tool and the enrich tool?
   > I think you are talking about [DAVID Functional Annotation Bioinformatics Microarray Analysis](ncifcrf.gov) and [Enrichr](maayanlab.cloud) Yes in principle there are no differences between DAVID and Enrichr on its functional level: both of them can perform gene enrichment analysis (including Gene Ontology, Pathway...). But when you focus on the database between these two tools, you will notice that the DAVID contains human, mice, Xenopus....lots of organisms, while Enrichr focuses on human. You can do a test: select a list of genes and put them into DAVID and Enrichr, you will noticed the adjust p-value are very different between them. I think this is because the size of the database is different.

1. In over-representation analysis part, i didn't get the point what's the point of overlap is significantly larger than expected. What can we conlude if its by chance, and not by chance?  I mean the overlap size can summarize or conclude something? I am confused.
   > A1: I was also thinking about this, and my interpretation was that if the overlap between all differentially expressed proteins and the proteins in the pathway we are interested in is larger than what we expect by chance, it should indicate that the pathway is for example up-regulated. This means that we can compare different condition groups and see if the pathway is more/less active in one group compared to another.   

1. I did not fully understand what Overrepresentation Analyses achieves. "A method of summarizing the activity of analytes into pathway activity", what exactly does this mean and how can we gain information about this by looking at the overlap between lists of differentially expressed genes and members of a pathway? 

1. In this lecture we learnt about over-representation analysis which is a statistical model that determines whether some biological processes or functions are over-represented in a gene list which is experimentally derived. I was wondering is over-enrichment analysis is the same as over-representation analysis and it has just two names or these are two different analysis methods? If yes, what is the difference between them?

## GSEA

1. From the article by Subramanian et al., The magnitude of the addition to the running sum when encountering a gene in the list belonging to the gene set S is weighted according to the gene's correlation with the phenotype. In the article they write that this can "cause the distribution of observed ES scores to be asymmetric in cases where many more genes are correlated with one of the two phenotypes". What does this mean, and why is this a reason for estimating significance levels for positively and negatively scoring genes separately?
   > As far as I understood it means that if we detected many genes (lets call them group A) which are correlated strongly with phenotype A, their addition to the ES calculation will be "boosted" because of the weighting. This means that these genes contribution will dominate the ES score calculation and the distribution of these ES scores won't be a normal mid centered normal distribution but it will be asymmetric (shifted in the way group A genes determined).

1. The genes in a gene-set enrichment analysis (GSEA) are ranked based on the correlation between a biological state (e.g. phenotype) and the gene expression level, but is it possible to perform this type of analysis and look at multiple states at once?
   > As long as you can find a way to score the comparison at gene-level you can use a GSEA-like method

3. Youtube video, 7:45, Gene-set enrichment anaylsis. I did not get how similar distribution patterns can indicate that components are in the same pathway. Why would coming from the same population indicate that two analyses are co-regulated?
   > I do not think that is what GSEA analyses. It does not try to define whether genes come from one pathway, but whether this pathway is differentially regulated in certain condition, If it is not, it should follow the same distribution as all analysed genes, presumably normal distribution with μ=0. If correlations of the genes for a specific gene set deviate from 0 more often then random (or from the middle ran for correlations rather - check out the GSEA paper for details), it is a sign the gene set may be related to the phenotypic trait.


4. From the article, Table 1 and Figure 2. I don´t really understand how the nominal p-value of the S3: nkt pathway is decreased in significant so much from the original method to the new method. How do you calculate this?
   > The article describes the development: "We addressed this issue by weighting the steps according to each gene's correlation with a phenotype."

5. For the GSEA paper:Step 1: Calculation of an Enrichment Score. First, i have checked the GSEA result and find that each gene in the expression file (list L) will have a individual score.can we conclude that it is just like Pearson, the higher the score, the closer the correlation between the gene and the biological state(e.g. phenotype?) 

6. When we calculate the NES，does it have a threshold like the p value to help us make a conclusion? is so, how big should it be?

7. In the paper: Step 2: Estimation of Significance Level of ES: “Specifically, we permute the phenotype labels and recompute the ES of the gene set for the permuted data, which generates a null distribution for the ES. The empirical, nominal P value of the observed ES is then calculated relative to this null distribution. Importantly, the permutation of class labels preserves gene-gene correlations and, thus, provides a more biologically reasonable assessment of significance than would be obtained by permuting genes.”  
   Does “by permuting genes” mean permuting the expression count of the genes, so that each gene is assigned to an expression count of another gene? If this is the case, I don’t understand how this would make sense at all? Or is it that I don’t understand what permuting genes means in the first place?
   > Yes it does mean changing the relation between genename and row in your expression column. This makes a null model that would be usefull for finding out how frequently you have genesets with an enrichment score at least as extreame as the current score.

8. From the article: "The GSEA-P software package includes tools for examining and clustering leading-edge subsets". I wonder how exactly leading-edge subsets would cluster? Since each gene set S that we choose to match with our L-list is essentially genes in a certain pathway of interest, isn't each leading-edge subset a different pathway as well? how would they cluster? Or what does a leading-edge cluster tell us? That those different pathways are related? 

9.  I don’t understand how the genes are ordered in a ranked list L. It is stated in the article by Subramanian et al that the genes are ranked based on their differential expression between the classes. Then when picking out genes from L, one picks from the top and the bottom “i.e., those showing the largest difference”. What does “largest difference” refer to?
    > After differential expression analysis between two classes (ex experiment and control), you obtain quantitative data on how large the difference in expression of each gene is between these two classes. Then you can sort these analyzed genes in descending order according to how large this differential expression quantitative data was -> which makes the ranked list L. This means the genes at the top and bottom (the genes with the most extreme differential expression/largest difference in gene expression between the two classes) are the genes "showing the largest difference".

1. One limitation of the "typical ranking list" gene expression analysis that GSEA intends to solve is the signal-to-noise ratio. Does GSEA improve signal-to-noise because it eliminates the need for a significance threshold to determine which genes are differentially expressed, by using ES scores instead? Still, a significance level for ES is calculated and what does it imply?

1. Video :In GSEA, where is the "full distribution of gene expression products" found? Is it the average of gene expression in a "healthy" sample? Do we represent the expression levels of every gene? 
   > An example that comes handy is RNA-seq.

1. If you manage to find a significant correlation between a differential expression profile and an a priori defined gene set, but the most differentially expressed gene list contains one or more genes that have no known relation to the defined gene set or studied phenotype. Would you disregard those genes and claim a significant correlation with the defined gene set? Or would you need to further investigate these genes before drawing conclusions?  

1. from the paper page 2. I find the following paragraph confusing... "We note that the GSEA method differs in several important ways from the preliminary version (see Supporting Text). In the original implementation, the running-sum statistic used equal weights at every step, which yielded high scores for sets clustered near the middle of the ranked list (Fig. 2 and Table 1). These sets do not represent biologically relevant correlation with the phenotype. We addressed this issue by weighting the steps according to each gene’s correlation with a phenotype. We noticed that the use of weighted steps could cause the distribution of observed ES scores to be asymmetric in cases where many more genes are correlated with one of the two phenotypes. We therefore estimate the significance levels by considering separately the positively and negatively scoring gene sets" specifically the last two sentence. Why do we need to consider the (+) and (-) scoring separately? aren't we really just interested in any amount of change? 
> A great question. I am others are confused about this as well. Partticularly since you know some proteins are suprresing the expression of other proteins you would expect an active pathway to contain both up an down regulated genes. 


## Validation
1. How are the results from Over-representation Analysis and Gene-set enrichment analysis validated?
   > Subramanian et al. is a nice example of how these types of analysis are validated. You use a set where you know which pathways should be differential, and check that they really are.

## Significance

1. GSEA involve multiple hypothesis testing. Why do you say that it improves the signal to noise ratio? It still involves multiple hypotheses, right?
   > Yes, but uyou reduce the number of tested hypotheses.


2. In the article, they illustrate all the genes in Table 2 which have an FDR < 0.25, instead of our common threshold of 0.05 what is the reason behind this, and is this unique for their approach, or is it common to have a threshold of 0.25 when doing GSEA?
    > GSEA is performed to find candidate hypotheses, which you try to further validate with your research. So, many scientist choose a FDR of 0.25 (results will be valid 3/4 times) to avoid overlooking potentially significant results. Expression datasets are often quite sparse and incoherent (high biochemical noise due to cell cycle phases, bursting, ...) and many genesets just include a fairly small number of genes / in the statistical test just few genes are analyzed, resulting in high statistical errors. In summary, GSEA is a first step to find candidates which you try to verify later.

## Notebook

1. In the jupyter notebook a q-value threshold of 10<sup>-15</sup> is used for the ORA, why was this value chosen? Is there any general way of thinking to choose a suitable threshold, can the data be taken into account somehow or is the choice completely arbitrary?
   > This threshold was selected arbitrarly. A more common choice would be 10<sup>-2</sup>.  


## Other 
1. From the video on pathway analysis 8:34, Gene-set enrichment analysis seem to be a popular tool for pathway activity but so does the Kolmogorov Smirnov test. Some articles seem to refer to the Kolmogorov Smirnov test as an alternative to GSEA so I was wondering which tool is the most effective one and what are the main differences between the two of them?

2. Why do the calculations for the ES also look for p-values distributed in the top extreme of p-values, and not just the bottom extremes?


[Wed 15:43]
