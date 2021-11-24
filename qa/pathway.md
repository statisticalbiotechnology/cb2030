# Questions and Answers on Pathway Analysis.

## General questions on Pathway Analysis

1. The general limitations using a knowledge based-driven pathway analysis seems to be:
  - Low resolution knowledge bases, missing condition- and cell-specific information, and incomplete annotations restrict development of the next-generation pathway analysis methods.
  - The inability to integrate the dynamic nature of a biological system in analysis limits the utility of existing methods.  
Would you say these are also the main limitations with GSEA? Or are there other limitations as well?
  > I do not fully get the "dynamic nature" of pathways, but your first point resonates well with me. I would add the methods inability to detect covariation between the gene products as an additional weakness.

1. So the principle of pathway analysis is grouping gens together and test how they behave as a group? This is done by taking already existing knowledge. But then isnt expression analysis of unrelated gens, to find connections between them also an important method to find relations between gens?
  > Yes, that is important, but detecting novel pathways are not a goal of regular pathway analysis.


## Pathway databases
1. One of the main obstacles for pathway analysis is annotation. Does this also include standardization of data annotation, i.e. do all databases treat/annotate the data in similar ways, and if not, would this be a problem? I am also wondering if different databases used for the same purpose can yield different results because of differences in annotation standard.
> No, there is differences between the databases. Even the number of pathways in the database will effect your results, if you do your multiple hypothesis correction in an accurate way.


## Integration of results
1. Is it possible and better to combine the different pathway databases (including metabolic pathways, interactions, and gene ontology) for one analysis?
  > This is an open research topic within multiomics analysis. It should be entirely possible to do so, however, I have seen very few successful implementations. One problem is lack of pathway definitions. However, some pathway definition databases like KEGG and Rectome actually do contain information on both metabolites and proteins.

## Over-representation analysis

1. Is there any way to correct for the fact that ORA assigns a higher significance to a pathway with more genes? I am specially concerned by the fact that we could be interested in analyzing pathways with different sizes, which may be both (or even just the smaller one) relevant in a given biological condition.
  > It is not so much that the larger pathways get higher significance by chance, as that they have a larger chance to pick up weak signals.

1. In Kathri et al regarding FCS they write that in the second step the gene-level statistics for all genes in a pathway are aggregated into a single pathway-level statistic.  I have a hard time understanding what this means, could you give a small example on this?
  > It is their way of saying that you are giving a common measurement of gene expression for the genes in the pathway instead of measuring the activity of individual genes. As explained in the video lecture, you count the genes intersection between the differentially expressed genes and the pathway. That number is the single pathway-level statistics.

1. And in this method, different thresholds may get different results, how should this threshold be chosen, according to the purpose of the experiment or the experience of the experimenter?
   > Are these two alternative mutually exclusive? Preferably according to both criteria.

## Null in Overrepresentation analysis

1. I don't understand why the null hypothesis in ORA is proteins in pathway / all measured proteins = overlap / differentially expressed proteins. And how do you choose the "all measured protein"? since I think the ratio of overlap is correlated to it
  > The first statement just comes from combinatorics. And you do not get to "choose" which proteins that were measured, it is a given from the data.

1. In ORA methods for pathway analysis, which genes should be included in an appropriate background?  I see several options of background list of genes that could be used: all the genes measured in the dataset, all the genes present in the analyzed pathways or all the genes that could be expressed in the samples (e.g. All known brain expressed genes if the samples are from brain tissue). Which background gene set should be used, or would be more correct to use, and why? In the notebook, you use the genes in the dataset, but I don't understand why you would not use the genes in the database used for the analysis.
  Does the choice of background depend on the test used (hypergeometric enrichment, chi-square, etc.)?
  > All the genes that you were taking in consideration in the first place, i.e. all genes you have measured. The two other choices you list will lead to biases.

1. Is there any situation where a hypergeometric test is prefered over Fisher or viceversa?
> No, as they are the [same test](https://en.wikipedia.org/wiki/Fisher%27s_exact_test).


## Geneset Enrichment Analysis
1. In the video lecture, it is stated for the Gene-set enrichment analysis part that one "looks at the full distribution of all the gene products and put them in one list. Compare that list to the distribution of samples that are sitting in the pathway itself. Compare and see if the two distributions look different." I'm having a hard time connecting this explanation with the one presented in the paper by Subramanian et al. They discuss how the predetermined set of genes S (genes in a pathway) and differentially expressed list of genes L, and finding which genes of S are found at the top and bottom of L. How do S and L relate to your distribution (is one the red distribution and one the blue distribution)? Is the blue distribution representing the genes found "at the top and bottom" and if so, will this always follow a bimodal distribution?
  > I plotted the distribution of L and S for a fictive pathway in my slide. If the distributions are significantly different we call that a  regulation of the pathway. That is also what Subramanian et al. are measuring.

1. In the video you mention that GSEA can only look at either up- or downregulation at one time, not simultaneously. I guess this is because the Enrichment Score is decided by the maximum deviation from 0 and then doesn't care about the genes in the other end of the gene set. Is this a problem or are there ways or variations of the method to overcome this?
  > There are some efforts to handle this. For instance, at least one study uses the absolute value of the differences between case and control rather than the difference itself. However, I do not think that method is frequently used. GSEA it self solves the problem by having two different tests, one for up and one for down regulation. The problem, however, is that we are not making use of the most striking feature of this analysis, the co-variation between the gene-products we are studying. We are currently developing methodology for this in my lab.

1. I am a bit confused about the plots obtained from the Gene Set Enrichment Analysis in the jupyter notebook. What does it mean to have a negative enrichment score (as in the plot)? Is it correlated to down-regulation of the genes in the pathway?
    > Yes, it means that the downwards trend is stronger than the upwards trend at that part of the plot. However, gsea cares about the "leading edge", i.e. the left most part of the plot.


2. In GSEA, my understanding to the Gene set S is that it is a set of all genes that involved in a biochemical pathway and L is a set of genes that are differentially expressed. As it is mentioned in the GSEA paper, "The goal of GSEA is to determine whether members of a gene set S tend to occur toward the top (or bottom) of the list L." When calculating the ES, the score is increased when the gene in L is in S and degreased when the gene in L is not in S. If so,  how could  this method be able to measure whether the gene in set S tends to occur at the two extremes of L?
  > Could you help me by explaining how their proposed method would not "determine whether members of a gene set S tend to occur toward the top (or bottom) of the list L"?



## Notebook
1. In the notebook the number of permutations for significance estimation is set to 100 to speed up the calculations but it was still very slow when I tried to execute it (in the binder server thing). Is the method typically slow or was it just the server?
 >  No, the calculations should be quick. However, the `gseapy` package does not execute its code locally, but instead submits each geneset as a job at the gsea or enrichr servers. This slows down the execution.

1. In notebook, the final FDRs seem high, being around 0.6~0.7, does this mean the pathways are most likely not enriched?
> Yes! Or at least that this implementation of pathway analysis does not pick up much signal.

1. Are there any cases, regarding differential gene expression, where it's better to not perform a pathway analysis, where individual measurements are preferred?
  > It all depends on what you are interested in reporting as a result.  


## Permutation tests
1. When it is said that they "permute the phenotype labels" in step 2, does this mean that for each sample, we keep all gene expression data and just assign it a label (e.g. healthy/diseased, or whatever groups we are comparing), irrespective of its actual label? Wouldn't this require a rather large number of samples to yield a good background distribution? Or is something else meant by permuting the labels?
  > Yes, your question is an accurate description of how a permutation tests work.

1. In the gene enrichment analysis I didn´t really grasp how the null distribution is being calculated and it was a bit unclear to me why permutation of class labels gives better results than permutation of genes, and a better biological assessment?
  > I think that they mean that if they would exchange individual gene+sample pairs with each other, they would get an expression matrix that would be too easy to distinguish from a real matrix. It should be noted, that [permutation tests}(https://en.wikipedia.org/wiki/Resampling_(statistics))  is seen as a gold standard for non parametric testing.

1. Could you give an example of a suitable metric that could be used in ranking the genes in the gene enrichment analysis? How is the suitable metric being chosen?
  > *p* value for differential expression is a suitable sorting score. In practice, the input to the *p* value calculation procedure, the [*t* statistic](https://en.wikipedia.org/wiki/Student%27s_t-test#Equal_sample_sizes,_equal_variance) is frequently used. However, this might not be what you ask for (despite your wording of your question). The GSEA method includes a score for different rankings (which is shown in the lower subplots in the notebook). That score is part of the secret sauce of how they score leading edge genes. If you want the arithmetical details, they are given in Equation \[1\] of the Subramanian *et al.* paper.

1. In the Methods section of the article by Subramanian et al, it says under step 1 that "The enrichment score is the maximum deviation from zero encountered in the random walk". However, I don't understand how the process they describe constitutes a random walk. Have I understood it correctly if the idea is that we walk down the list L and for each gene on the list add (for genes found in the pathway under study) or subtract (for genes not in the pathway) a value that is in some way a function of the correlation between that gene and the phenotype we are studying. In what way is this a random walk? Or have I misunderstood the process? Could you perhaps clarify the process of calculating the ES?
  > Under the null hypothesis, the pathway's genes should be randomly ranked. Under such a condition the up or down regulation, i.e. the ES should follow a [random walk process](https://en.wikipedia.org/wiki/Random_walk). Hence, if the path seems extreme, it is a sign of enrichment.

1. In Subramanian et. al the 2nd step of estimation of significance level of ES, states that the phenotype label is permuted to generate a null distribution. What do the mean by phenotype abel or class label. Further, they say that the permutation is done in a way that the gene-gene correlation is maintained. I do not understand how the gene-gene correlation can be maintained if the data is permuted? As there can be only one way to represent the correlation pattern between all the genes when ranked.
  > "phenotype label is permuted" => permute the relation of case and control.

1. How does the phenotype-based permutation test maintain the correlation information about the gene expression data in GSEA? Is it because the labels are assigned to entire samples, and not to individual genes?
  > Yes.

## ORA vs. FCS
1. The over-representation analysis seems to have many limitations that are being addressed by other pathway analysis methods, but seems that is the most commonly used? Why is it preferred over the other methods?
  > It is mostly used as it is easy to calculate. It also do not require quantative measurements.

1. GSEO addresses some of the limitations of ORA and seems to be different methods to achieve same goals. Additionally GSEO doesn't require any threshold.
Is there any reason not to use GSEO over ORA?
  > You might not have any quantitative data. E.g. you have used an antibody array to detect the presence of a set of proteins.

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

1.  In the notebook the function gseapy.gsea() is used with the method used to calculate a correlation or ranking set to 'signal_to_noise'. There seems to be other methods to choose from, how do you make this choice?
>  The documentation lists a couple of [methods](https://gseapy.readthedocs.io/en/latest/run.html#run) some of them need samples group of at least 3, which might not be available. There might be cases where you rather sort by FC than significance. See above.

1. In Subramanian's article, one of the advantages of GSEA is that it does not concentrate on the high scoring genes that are poorly annotated or could not be reproducible. However, the author mentions that GSEA is different from other tools because it considers all of the genes in the experiment. Although the leading-edge analysis can help conclude the subtle results, how do these 'bad' high scoring genes processed? Will the high ratio of these genes influence the final consequences?
> The advantage is that unlike ORA, GSEA studies the full distribution of expression values.

1.  In order to determine the correlation between gene expression and phenotype - in the slides/video, the correlation to the phenotype seems to be a continuous axis in the graph instead of 'classes' of phenotypes such as disease/healthy. Is the correlation typically categorical or are there examples when it would be a continuous variable?
> This is a nice observation. It is more common to use categorical variables, but it nothing that hinders the same analysis to be done for continuous variables. Gseapy does not seem to support this though.

1.  In the notebook the function gseapy.gsea() is used with the method used to calculate a correlation or ranking set to 'signal_to_noise'. There seems to be other methods to choose from, how do you make this choice?
>  The documentation lists a couple of [methods](https://gseapy.readthedocs.io/en/latest/run.html#run) some of them need samples group of at least 3, which might not be available. There might be cases where you rather sort by FC than significance. See above.


## Significance calculation in gsea

1. **(4 votes)** I still have problems understanding what we do when we use permutation. In GSEA when we calculate the significance level of enrichment score (ES), it is mentioned (Subramanian et al., 2005)  that we can permute the phenotype labels in order to generate a null distribution, which is used in order to calculate the p-value of the ES. I wonder if you could try to clarify how permutation is used in this case?
> I had hoped that this would be a slam dunk for you that have read Downey, and been diving further into the word of permutation test than most. It is easy: you permute the labels and get new differential expresion values, for which you can calculate a new enrichment score. If you do this enough times you can asses how unlikely random your unpermuted outcome was.

1. What is the Random Walk called “the random walk”? In Subramanian et al., they explain that it is done to calculate the enrichment score. I don’t think I understand the process completely, but it doesn’t seem to be random to me?
> Under the null the distribution of genes in the pathway are random in respect to the other measured genes. Processes involving random dicrete calls are frequently called [random walk](https://en.wikipedia.org/wiki/Random_walk).

1. From the GSEA paper: "Genes may be ranked based on the differences seen in a small data set, with too few samples to allow rigorous evaluation of significance levels by permuting the class labels. In these cases, a P value can be estimated by permuting the genes, with the result that genes are randomly assigned to the sets while maintaining their size. This approach is not strictly accurate: because it ignores gene-gene correlations, it will overestimate the significance levels and may lead to false positives."  
Does this mean that even though the method calculates FDRs, they will in this case be incorrect/unreliable or just that the FDRs will be higher than they would be when permuting class labels?
> The first, i.e. that the reported statistics is inflated as it does not take gene-gene correlations in account.


## Types of analytes

1. The examples given in the article Ten Years of Pathway Analysis map genes to pathways by annotated databases to compare and analyse pathways between samples. I assume that gene expression is the most common way to analyse pathways but is proteomics (protein levels) ever used to analyse pathways?
> Protein concentrations can be seen as gene expression. But, Yes you quite freuently see pathway analysis based on protein abundances. Maybe even more frequently, pathways are used within metabolomics, i.e. with the abundances of various small molecules.

## Notebook

1. - In the jupyter notebook we plot the ranked list metric as a function of the rank in ordered dataset. I can't really interpret this plot, could you explain it briefly?
   - **(2 votes)** I have some trouble understanding the two graphs that are plotted in the Jupyter notebook, could you explain what they show/what information they give you?
> Yes the interpretation of this score will be challenging unless you read the GSEA paper. See e.g. Figure 1 ![](https://www.pnas.org/content/pnas/102/43/15545/F1.large.jpg)

##  Reduction of number of hypothesis tests

1. Pathway analysis focuses on the fact that it is better to look at 1000 pathways than 20000 genes and that fewer the hypothesis better the signal to noise ratio. But scientific research is also focusing on single cell and spatial level information and looing at more and more deeper details. Can you comment on when looking at bulk data as a whole could be an advantage/disadvantage?
> In single cell data and bulk data you are measuring an similar amount of mRNAs or pathways. So, the data is not very different in this respect. However, in single cell, we are often less prone to look at e.g. differential expression. Instead one are more prone to use e.g. clustering to find various cell types or similar.   

