# Questions and Answers on Pathway Analysis.

## ORA vs GSEA
1. Both ORA and GSEA have their pros and cons. Can you give an example of how to choose between the two methods in actual analysis?
1. Could you provide situational examples of when we would use ORA and when we would use FCS?
1. **(5 votes)**  I don’t really understand when it is better to use ORA and when FCS? In which “situations” are they used? FCS seems better than ORA and “solves” some limitations that ORA have but when is it still better to use ORA over FCS?
1. ORA seem to have quite serious drawbacks, including discarding information and treating each significant gene as equally important which was mentioned by Khatri et al. Is the method still used today and has it any advantages over the other methods?
1. How do the different generations of pathway analysis in one of the two papers compare to each other? Is it always the case that you employ the latest generation or not?
> One major advantage of ORA is  that the method do not need expression value. I.e. if you have identified a set of proteins using antibodies, you just now that they were present in the sample or not, and you would not know the proteins' concentration. Then you can apply ORA but not GSEA.
> One usualy prefer GSEA when one have expression values, ORA when you for some reason do not.

1. In Kathri et al. Ten Years of Pathway Analysis: Current Approaches and Outstanding Challenges we see that Functional Class Scoring (FCS) approaches have several improvements compared to Over-Representation Analysis (ORA). In practice, are they equally used within the research community or is FCS preferred over ORA?
> Both analysis are frequently used.

## Pathway annotations

1. **(6 votes)**  Pathway analysis methods rely on databases to establish which genes are working together. However, such gene sets may differ depending on the organism or even cell type studied (the Wnt example in Kathri et al.). How should we tackle this issue?
Should we avoid using pathway analysis if there is not a reliable database for our organism and cell type?
> The analysis is completely dependent on the curration of pathway databases. However, for unannotated speices assignments to pathways can often be done by searching for orthologs in organisms included in pathway databases.

1. **(3 votes)** In one of the articles, they state that there is a challenge in annotation. How would you practically overcome this challenge? Would you have to proceed by manual annotation or are there statistical analyses that can detect pathway-like relationships?
> It is challenging to annotate data. In generla this is done as community efforts by various underfunded angels across the world.

1. In Subramanians article about Gene Set Enrichment Analysis (GSEA) it is described as flexible due to its abillity to be applied to any given gene set for analysis. In what cases is it more useful to apply a more focused gene set compared to a wide allencompassing one?
> You should mine for pathways that you are interested in. Other than that I do not have any recomendations in this matter.

1. Is it possible for multiple active pathways to "mask" one another?
> Not the way we traditionally do pathway analysis. There is for instance no mechanism that subtracts the effects of significant subpathways from an over arching pathway (if you for some reason would like to do so).

1.  How do we deal with the fact that pathways might always be incomplete (I'm talking in terms of compounds here, not annotations)? Is there a way to report for that in the results or do we just assume they are complete?  
I'm assuming we don't know all the metabolites and proteins, some of them might be degraded too quickly but still have crucial effects?
> This is a real problem. Several efforts are using network inferences by PPI, co-exression or other networks to add external information to pathway analysis. A close-by example is [this article](https://www.nature.com/articles/s41598-020-70239-z).   

1. The annotated pathways groups genes into sets of genes that are co-expressed, but proteins can also be present in multiple pathways, and pathways interact with eachother. Are there any methods that look at larger sets of genes encompassing several pathways (or genes spanning multiple pathways), or are they also just labeled “pathways” and the regular ORA/FCS methods used?
> Many pathway databasess, such as [reactome](https://reactome.org/), are hirarchical. In such definitions sub pathways are ecompassed by larger pathays.  E.g. a pathway ["Phosphorylation of STAT2"](https://reactome.org/PathwayBrowser/#/R-HSA-909733&SEL=R-HSA-909732&PATH=R-HSA-168256,R-HSA-1280215,R-HSA-913531) is a part of the larger pathway ["Immune System"](https://reactome.org/PathwayBrowser/#/R-HSA-168256).


## Automatic annotation

1. From the reading material it is clear that is key to have complete and annotated pathway databases. Given the experimental difficulties and the huge amount of time required, I am wondering if computational tools are being developed for this purpose. In that case, how are they performing?
1. Kathri et al. explain that a lot of pathways annotations are derived from algorithms these days. How do those algorithms work? Do they for instance scan scientific literature for key words?
> Automatic annotation does not  work well. The state of the atr is manual annotations from literature, possibly with aid of algorithms.


## ORA

1. **(3 votes)** From the youtube video, I don't understand the biological meaning of the H0. I understand that we first extract those genes that are differentially expressed into a separate list (according to a conventionally set threshold) which is later compared to the list of the proteins of the pathway in order to look for overlaps. The null H is set as: (proteins in the pathway/ all measured proteins) = (overlap/differentially expressed genes), and it is this expression which biological interpretation is difficult to understand (at least for me). This is also why the p-values obtained from the notebook after performing ORA are not quite clear for me.  

| # | p	| Overlap	| Term | q |
|---|---|---------|------|---|
| 0	| 6.142575e-11	| 24/124 | Cell cycle |	1.554448e-08 |
| 1	| 1.631457e-04 | 17/160	| Cellular senescence	| 2.064293e-02 |
| 2	| 3.322946e-04 | 7/35 | Alanine, aspartate and glutamate metabolism | 2.803030e-02 |  

does it mean that since the cell cycles's p-value<threshold then those 24 genes that overlap that are differentially expressed are just relevant for the pathway per se? or does it have another meaning? could you please explain more thoroughly this part?
> 24/124 means that there were 124 genes in the "cell cycle"'s pathway, whereof 24 genes were differentially expressed at a q<10<sup>-15</sup>.

1. When using ORA, we need to set an arbitrary threshold for dividing expression data into significant and non-significant pools for the analysis. I am wondering how to determine that threshold, i.e. what are the bases for choosing a specific threshold? Is it set by convention just as the significance level of 0.05 for p-values or does it have requirements that is specific from case to case?
> No there is no rule for this. However, you that have taken this course ofcourse recognize that it *never* should be set based on measures that have not been corrected for multiple hypothesis.


## GSEA

1. **(3 votes)** In Functional Class Scoring, the list of genes is ranked prior to analysis by some metric. What should we consider when choosing the ranking metric? Is it generally better to rank by statistical significance (e.g. p-value or q-value) or biological significance (e.g. log fold change)?
> Both could work, but GSEA uses statistical significance (there is no such thing as a separate biological significance, though).

1.  In the notebook the function gseapy.gsea() is used with the method used to calculate a correlation or ranking set to 'signal_to_noise'. There seems to be other methods to choose from, how do you make this choice?
>  The documentation lists a couple of [methods](https://gseapy.readthedocs.io/en/latest/run.html#run) some of them need samples group of at least 3, which might not be available. There might be cases where you rather sort by FC than significance. See above.

1. In the functional class scoring (FCS), you start by scoring/ranking the genes, do you then just take the genes with the highest score or do you need some prior knowledge of these genes functions in order to understand the pathway. I feel like you only identify genes that could be relevant to the pathway but not necessarily relevant. Is this assumption correct?
> No, e.g. GSEA uses expression values from all measured genes. You set the genes in a pathway in perspective to all other genes.

1. In Subramanian's article, one of the advantages of GSEA is that it does not concentrate on the high scoring genes that are poorly annotated or could not be reproducible. However, the author mentions that GSEA is different from other tools because it considers all of the genes in the experiment. Although the leading-edge analysis can help conclude the subtle results, how do these 'bad' high scoring genes processed? Will the high ratio of these genes influence the final consequences?
> I do not understand what you mean with "'bad' high scoring genes". The advantage is that unlike ORA, GSEA studies the full distribution of expression values.

1. The article for GSEA defines the "top" and "bottom" of a gene set S from a microarray, but could you elaborate in more detail?
> Not sure what you mean. The point of GSEA is the oposit. Here is an extract of the article: "A common approach involves focusing on a handful of genes at the top and bottom of L (i.e., those showing the largest difference) to discern telltale biological clues. This approach has a few major limitations."

2.  In order to determine the correlation between gene expression and phenotype - in the slides/video, the correlation to the phenotype seems to be a continuous axis in the graph instead of 'classes' of phenotypes such as disease/healthy. Is the correlation typically categorical or are there examples when it would be a continuous variable?
> This is a nice observation. It is more common to use categorical variables, but it nothing that hinders the same analysis to be done for continuous variables. Gseapy does not seem to support this though.


## Significance calculation in gsea

1. **(4 votes)** I still have problems understanding what we do when we use permutation. In GSEA when we calculate the significance level of enrichment score (ES), it is mentioned (Subramanian et al., 2005)  that we can permute the phenotype labels in order to generate a null distribution, which is used in order to calculate the p-value of the ES. I wonder if you could try to clarify how permutation is used in this case?
> I had hoped that this would be a slam dunk for you that have read Downey, and been diving further into the word of permutation test than most. It is easy: you permute the labels and get new differential expresion values, for which you can calculate a new enrichment score. If you do this enough times you can asses how unlikely random your unpermuted outcome was.

1. What is the Random Walk called “the random walk”? In Subramanian et al., they explain that it is done to calculate the enrichment score. I don’t think I understand the process completely, but it doesn’t seem to be random to me?
> Under the null the distribution of genes in the pathway are random in respect to the other measured genes. Processes involving random dicrete calls are frequently called [random walk](https://en.wikipedia.org/wiki/Random_walk).

1. From the GSEA paper: "Genes may be ranked based on the differences seen in a small data set, with too few samples to allow rigorous evaluation of significance levels by permuting the class labels. In these cases, a P value can be estimated by permuting the genes, with the result that genes are randomly assigned to the sets while maintaining their size. This approach is not strictly accurate: because it ignores gene-gene correlations, it will overestimate the significance levels and may lead to false positives."  
Does this mean that even though the method calculates FDRs, they will in this case be incorrect/unreliable or just that the FDRs will be higher than they would be when permuting class labels?
> The first, i.e. that the reported statistics is inflated as it does not take gene-gene correlations in account.

1. Another student already mentioned the permutation (GSEA paper) in a question further up. I have a related question about the permutation in order to determine the significance of the enrichment score. How is the gene-gene correlation preserved when the class labels are permutated compared to the permutation of genes?
> When you permute class labels, you are keeping the same gene-expresion values together. If they for some reason are exposed to the same biases that would mean that the gene expresion values will continue to correlate also after permutation.


# Types of analytes

1. The examples given in the article Ten Years of Pathway Analysis map genes to pathways by annotated databases to compare and analyse pathways between samples. I assume that gene expression is the most common way to analyse pathways but is proteomics (protein levels) ever used to analyse pathways?
> Protein concentrations can be seen as gene expression. But, Yes you quite freuently see pathway analysis based on protein abundances. Maybe even more frequently, pathways are used within metabolomics, i.e. with the abundances of various small molecules.

## Notebook

1. - In the jupyter notebook we plot the ranked list metric as a function of the rank in ordered dataset. I can't really interpret this plot, could you explain it briefly?
   - **(2 votes)** I have some trouble understanding the two graphs that are plotted in the Jupyter notebook, could you explain what they show/what information they give you?
> Yes the interpretation of this score will be challenging unless you read the GSEA paper. See e.g. Figure 1 ![](https://www.pnas.org/content/pnas/102/43/15545/F1.large.jpg)

##  Reduction of number of hypothesis tests

1. Pathway analysis focuses on the fact that it is better to look at 1000 pathways than 20000 genes and that fewer the hypothesis better the signal to noise ratio. But scientific research is also focusing on single cell and spatial level information and looing at more and more deeper details. Can you comment on when looking at bulk data as a whole could be an advantage/disadvantage?
> In single cell data and bulk data you are measuring an similar amount of mRNAs or pathways. So, the data is not very different in this respect. However, in single cell, we are often less prone to look at e.g. differential expression. Instead one are more prone to use e.g. clustering to find various cell types or similar.   


## Lofty ideas abou the future

1. The article "Ten Years of Pathway Analysis" is over 8 years old. What would you say are the application(s) described in the article that has progressed the furthest in these years? And what usage has driven this develpoment?
> Quite a lot of effort has been put into different types of network inferences for pathways. However, this is arguably a slowly moving field.

1. Is it possible to combine PT-based approaches, FCS and ORA for pathway analysis in order to circumvent the some of the limitations when these techniques are used independently?
> Not that I am aware of.

1. The paper " Ten years of pathway analysis" mentions some outstanding challenges in pathway analysis. Have these challenges been overcome yet or are they still issues, and if they are still issues, how do they affect the reliability of the analysis?
> As far as I can tell they still remain.
