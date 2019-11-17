# Questions and Answers on Pathway Analysis.

## General questions on Pathway Analysis
1. In the article Khatri et. al, it is said that the FCS method considers molecular measurements to select the differentially expressed genes thus solving the problem caused by the ORA method. What exactly are these gene measurements that the authors refer to?
  > They write in the introduction that: "Virtually all of the approaches and tools discussed here are independent of the data generated from most high-throughput technologies, including next-generation sequencing data and the knowledge bases used for pathway annotations. In this review, we use gene expression measurements as example data for discussing and explaining various approaches."


## Integration of results
1. Is it possible and better to combine the different pathway databases (including metabolic pathways, interactions, and gene ontology) for one analysis?
  > This is an open research topic within multiomics analysis. It should be entirely possible to do so, however, I have seen very few successful implementations. One problem is lack of pathway definitions. However, some pathway definition databases like KEGG and Rectome actually do contain information on both metabolites and proteins.

## Enrichment scores
1. In the video you mention that GSEA can only look at either up- or downregulation at one time, not simultaneously. I guess this is because the Enrichment Score is decided by the maximum deviation from 0 and then doesn't care about the genes in the other end of the gene set. Is this a problem or are there ways or variations of the method to overcome this?
  > There are some efforts to handle this. For instance, at least one study uses the absolute value of the differences between case and control rather than the difference itself. However, I do not think that method is frequently used. GSEA it self solves the problem by having two different tests, one for up and one for down regulation. The problem, however, is that we are not making use of the most striking feature of this analysis, the co-variation between the gene-products we are studying. We are currently developing methodology for this in my lab.

1. I am a bit confused about the plots obtained from the Gene Set Enrichment Analysis in the jupyter notebook. What does it mean to have a negative enrichment score (as in the plot)? Is it correlated to down-regulation of the genes in the pathway?
    > Yes, it means that the downwards trend is stronger than the upwards trend at that part of the plot. However, gsea cares about the "leading edge", i.e. the left most part of the plot.

1. What does the plot below the enrichment score tell us? Can you explain the difference between the axes and why it is a vertical line in the middle of the plot?
    > It is pretty well described by te Subramanian *et al.* in my mind. The line gives you marks the median of all investigated genes.

1. In the paper Subramnaian et al,  the author talks about the three key elements of GSEA. In the first method of the calculation of enrichment score, what does the author mean by running-sum statistic?  Is it the score assigned to a gene according to the relevance of occurrence in a particular phenotype?  
  What is meant by  a gene set being over represented? Is it that a gene is falsely or ranked by chance in the top or bottom of L?  
  Also, he states that the ER is maximum deviation from zero during the random walk . What is meant by random walk?



## Notebook
1. In the notebook the number of permutations for significance estimation is set to 100 to speed up the calculations but it was still very slow when I tried to execute it (in the binder server thing). Is the method typically slow or was it just the server?
 >  No, the calculations should be quick. However, the `gseapy` package does not execute its code locally, but instead submits each geneset as a job at the gsea or enrichr servers. This slows down the execution.

1. In notebook, the final FDRs seem high, being around 0.6~0.7, does this mean the pathways are most likely not enriched?
> Yes! Or at least that this implementation of pathway analysis does not pick up much signal.

1. Are there any cases, regarding differential gene expression, where it's better to not perform a pathway analysis, where individual measurements are preferred?
  > It all depends on what you are interested in reporting as a result.  


## Over-representation analysis
1. In the article by Kathri et al, section First Generation: Over-Representation Analysis (ORA) Approaches, we can read that solving one of its limitations (that only the most significant genes are used) by using an "iterative approach that adds one gene at a time to find a set of genes for which a pathway is most significant". I do not quite get how this solves the problem? How are the genes chosen if not by a threshold? Do we analyze all genes that we have analyzed by using this method?
  > Sure you use a FDR treshold, but you keep on increasing it until you see the result you want to get. Did I ever tell you that much systems biology stands on methods that should not be investigated too closely?

1. Regarding ORA, the article by Kathri et al mentions that one of the limitations is that it assumes that each gene is independent of the other genes (more generally, analytes, I assume), which might yield biased or incorrect estimates of pathway significance. This sounds like a very bad assumption to make when studying pathways, and it sounds as though it would produce very severe errors, and thus extremely unreliable results. Since the method is still used: how severe and common do these errors tend to be?
  > Nice catch! This is an error of the review in my mind. What they should have written is that the genes have to be independent under the null, which is an more reasonable assumption. Overall, the method seems to be reliable enough. I also not like the fact that the method is not taking quantative differences as input, but rather lists of genes, and that its test statistics does not relate to quantitative differences between case and control, but instead tests the sizes of genesets. That makes the test statistic hard for most biologists to [interpret](https://academic.oup.com/bioinformatics/article/23/8/980/198511) (and the general problems of the interpretation of *p* values makes this worse).


## Permutation tests
1. Also, when it is said that they "permute the phenotype labels" in step 2, does this mean that for each sample, we keep all gene expression data and just assign it a label (e.g. healthy/diseased, or whatever groups we are comparing), irrespective of its actual label? Wouldn't this require a rather large number of samples to yield a good background distribution? Or is something else meant by permuting the labels?
  > Yes, your question is an accurate description of how a permutation tests work.

1. In the gene enrichment analysis I didn´t really grasp how the null distribution is being calculated and it was a bit unclear to me why permutation of class labels gives better results than permutation of genes, and a better biological assessment?
  > I think that they mean that if they would exchange individual gene+sample pairs with each other, they would get an expression matrix that would be too easy to distinguish from a real matrix. It should be noted, that [permutation tests}(https://en.wikipedia.org/wiki/Resampling_(statistics))  is seen as a gold standard for non parametric testing.

1. Could you give an example of a suitable metric that could be used in ranking the genes in the gene enrichment analysis? How is the suitable metric being chosen?
  > *p* value for differential expression is a suitable sorting score. In practice, the input to the *p* value calculation procedure, the [*t* statistic](https://en.wikipedia.org/wiki/Student%27s_t-test#Equal_sample_sizes,_equal_variance) is frequently used. However, this might not be what you ask for (despite your wording of your question). The GSEA method includes a score for different rankings (which is shown in the lower subplots in the notebook). That score is part of the secret sauce of how they score leading edge genes. If you want the arithmetical details, they are given in Equation \[1\] of the Subramanian *et al.* paper.

## ORA vs. FCS
1. The over-representation analysis seems to have many limitations that are being addressed by other pathway analysis methods, but seems that is the most commonly used? Why is it preferred over the other methods?
  > It is mostly used as it is easy to calculate. It also do not require quantative measurements.


1. The general limitations using a knowledge based-driven pathway analysis seems to be:
  - Low resolution knowledge bases, missing condition- and cell-specific information, and incomplete annotations restrict development of the next-generation pathway analysis methods.
  - The inability to integrate the dynamic nature of a biological system in analysis limits the utility of existing methods.  
Would you say these are also the main limitations with GSEA? Or are there other limitations as well?
  > I do not fully get the "dynamic nature" of pathways, but your first point resonates well with me. I would add the methods inability to detect covariation between the gene products as an additional weakness.



1. Is there any way to correct for the fact that ORA assigns a higher significance to a pathway with more genes? I am specially concerned by the fact that we could be interested in analyzing pathways with different sizes, which may be both (or even just the smaller one) relevant in a given biological condition.
  > It is not so much that the larger pathways get higher significance by chance, as that they have a larger chance to pick up weak signals.

1. In the article by Khatri et al. it is mentioned that due to the low resolution of databases it is required that the input for the analysis must first be mapped “non-redundant namespace”. What does this mean and how does this allow the analysis to be independent of technology use for data collection?
  > Most pathways were first described long before the advent of high-throughput molecular biology. Such studies often describe their analytes (proteins and metabolites) in familiar terms, not necessarily giving the exact proteoform or detectable metabolite adduct. Hence, pathway curators have to revise the literature to map the old literature to more formalized taxonomy, like ensembl, uniprot or entrez.

1. GSEO addresses some of the limitations of ORA and seems to be different methods to achieve same goals. Additionally GSEO doesn't require any threshold.
Is there any reason not to use GSEO over ORA?
  > You might not hold quantitative data. E.g. you have used an antibody array to detect the presence of a set of proteins.

1. In Subramanian et. al the 2nd step of estimation of significance level of ES, states that the phenotype label is permuted to generate a null distribution. What do the mean by phenotype abel or class label. Further, they say that the permutation is done in a way that the gene-gene correlation is maintained. I do not understand how the gene-gene correlation can be maintained if the data is permuted? As there can be only one way to represent the correlation pattern between all the genes when ranked.
  > "phenotype label is permuted" => permute the relation of case and control.

1. In Kathri et al regarding FCS they write that in the second step the gene-level statistics for all genes in a pathway are aggregated into a single pathway-level statistic.  I have a hard time understanding what this means, could you give a small example on this?
  > It is their way of saying that you are giving a common measurement of gene expression for the genes in the pathway instead of measuring the activity of individual genes. As explained in the video lecture, you count the genes intersection between the differentially expressed genes and the patway. That number is the single pathway-level statistics.

1. In the Methods section of the article by Subramanian et al, it says under step 1 that "The enrichment score is the maximum deviation from zero encountered in the random walk". However, I don't understand how the process they describe constitutes a random walk. Have I understood it correctly if the idea is that we walk down the list L and for each gene on the list add (for genes found in the pathway under study) or subtract (for genes not in the pathway) a value that is in some way a function of the correlation between that gene and the phenotype we are studying. In what way is this a random walk? Or have I misunderstood the process? Could you perhaps clarify the process of calculating the ES?
  > Under the null hypothesis, the under or over representation of genes in any region of the spectrum of differentially expressed genes in the pathway should be randomly ranked. Hence the ES should follow a [random walk process](https://en.wikipedia.org/wiki/Random_walk). Hence, if the path seems extreme, it is a sign of enrichment.

1. In the paper Subramnaian et al,  the author talks about the three key elements of GSEA. In the first method of the calculation of enrichment score, what does the author mean by running-sum statistic?  Is it the score assigned to a gene according to the relevance of occurrence in a particular phenotype?
  > They talk about the ES score, i.e. their cumulative sum statistic.

1. What is meant by  a gene set being over represented? Is it that a gene is falsely or ranked by chance in the top or bottom of L?
  > In the context of Subramnaian et al that is the right interpretation.

1. What is the reason for univariate analysis outperforming multivariate analysis for biological data, when the opposite is true for simulated data (as mentioned in the article by Khatri et al.)? Could this change with improved measurement techniques/technologies, gene annotation and/or knowledge of pathways and interactions in general?
  > It might be an erroneous finding. In our hands, multivariate statistics is always more sensitive.

1. For over-representation analysis, the null hypothesis is the ratio of protein in pathway to all measured protein equal to the ratio of overlap to differentially expressed protein. Can you explain why that is the selected null hypothesis?
  > It is just a combinatoric fact.

1. And in this method, different thresholds may get different results, how should this threshold be chosen, according to the purpose of the experiment or the experience of the experimenter?
   > Are these two alternative mutually exclusive? Preferably according to both criteria.

1. I don't understand why the null hypothesis in ORA is proteins in pathway / all measured proteins = overlap / differentially expressed proteins. And how do you choose the "all measured protein"? since I think the ratio of overlap is correlated to it
  > The first statement just comes from combinatorics. And you do not get to "choose" which proteins that were measured, it is a given from the data.

1. When we combine different database in the latest generation of pathway analysis. How can we equally wieght the data in different analysis or do we need to weight? I think we know that you can gain information from different role but each role might not be comparable to oen another.
  > That is totally up to the implementer to decide.

1. One of the main obstacles for pathway analysis is annotation. Does this also include standardization of data annotation, i.e. do all databases treat/annotate the data in similar ways, and if not, would this be a problem? I am also wondering if different databases used for the same purpose can yield different results because of differences in annotation standard.
> No, there is differences between the databases. Even the number of pathways in the database will effect your results, if you do your multiple hypothesis correction in an accurate way.

1. Could you explain more about GSEA part in Jupyter notebook? I am confused about the input data. It seems like you select five top scoring data sets. Is it enrichment score? Which ranked list L do you use?
  > The top 5 pathways that stem from the gsea analysis.

1. In ORA methods for pathway analysis, which genes should be included in an appropriate background?  I see several options of background list of genes that could be used: all the genes measured in the dataset, all the genes present in the analyzed pathways or all the genes that could be expressed in the samples (e.g. All known brain expressed genes if the samples are from brain tissue). Which background gene set should be used, or would be more correct to use, and why? In the notebook, you use the genes in the dataset, but I don't understand why you would not use the genes in the database used for the analysis.
  Does the choice of background depend on the test used (hypergeometric enrichment, chi-square, etc.)?
  > All the gens that you were taking in consideration in the first place, i.e. all genes you have measured. The two other choises you list will lead to biases.

1. So the principle of pathway analysis is grouping gens together and test how they behave as a group? This is done by taking already existing knowledge. But then isnt expression analysis of unrelated gens, to find connections between them also an important method to find relations between gens?
  > Yes, that is important, but detecting novel pathways are not a goal of regular pathway analysis.

1. I think we should meassure as many gens at the same time as we can, not just the ones that we can group into pathways. Off course by knowing which gens already interact its easier to establish a phenotype.
  > Here I am a bit confused about your statement. Why do you think so? If you already know that two genes are co-regulated, why measure them both?

1. How does the phenotype-based permutation test maintain the correlation information about the gene expression data in GSEA? Is it because the labels are assigned to entire samples, and not to individual genes?
  > Yes.

1. In the jupyter notebook for the gsea analysis the number of processes is set to 4, why is this and why is the default 1?
  > This controls the speed the pathways are calculate, by allowing a different number of parallel processes.

1. Pathway Topology (PT)-based methods rely on the integration of additional information (e.g. number and type of reactions, gene position). Major problems for PT-based methods are incomplete and inaccurate annotations and missing condition- and cell-specific information. Does it therefore at the moment (in general) make more sense to still prefer the Functional Class Scoring (FCS) over PT-based methods?
  > PT based methods are normally not taking quantitative information as input.

1. As far as I understand, some limitations in pathway analysis methods have been overcome as the methods have been developed (ORA -> FCS -> PT). Are the relevant pathways identified by PT or FCS more reliable/accurate than those identified by ORA?
  > Try them out for yourself, and tell me what you think.

1. It's stated that FCS methods assume that the underlying network does not change when experimental condition change, and that this assumption is inaccurate. How big of an affect does this assumption have on the result and is it possible to take this assumption into account when analysing the data from these tests?
  > That is hard to tell.

1. The database String is built up by predictions of interactions. How are these predictions derived and how accurate can they assume to be?
  > How long is a string? You can familiarize yourself with the string database [here](single pathway-level)

1. So with different methods available(ORA, FCS) , all having their benefits and drawbacks, at which point of compexity of data would you consider a neural feed forward, or any other kind of neuronal network, to explain microarray data?
  > What problem would the ANN solve in your mind?

1. Is there any situation where a hypergeometric test is prefered over Fisher or viceversa?
> No, as they are the [same test](https://en.wikipedia.org/wiki/Fisher%27s_exact_test).

1. Could you give a specific example that ORA would be preferred over FCS? Is there any reason (other than educational) that you preferred to do ORA instead of FCS in the example in the jupyter notebook?
  > I am confused as I in the notebook show one ORA and one FCS test.

1. In the video lecture, it is stated for the Gene-set enrichment analysis part that one "looks at the full distribution of all the gene products and put them in one list. Compare that list to the distribution of samples that are sitting in the pathway itself. Compare and see if the two distributions look different." I'm having a hard time connecting this explanation with the one presented in the paper by Subramanian et al. They discuss how the predetermined set of genes S (genes in a pathway) and differentially expressed list of genes L, and finding which genes of S are found at the top and bottom of L. How do S and L relate to your distribution (is one the red distribution and one the blue distribution)? Is the blue distribution representing the genes found "at the top and bottom" and if so, will this always follow a bimodal distribution?
  > I plotted the distribution of L and S for a fictive pathway in my slide. If the distributions are significantly different we call that a  regulation of the pathway. That is also what Subramanian et al. are measuring.

1. In GSEA, my understanding to the Gene set S is that it is a set of all genes that involved in a biochemical pathway and L is a set of genes that are differentially expressed. As it is mentioned in the GSEA paper, "The goal of GSEA is to determine whether members of a gene set S tend to occur toward the top (or bottom) of the list L." When calculating the ES, the score is increased when the gene in L is in S and degreased when the gene in L is not in S. If so,  how could  this method be able to measure whether the gene in set S tends to occur at the two extremes of L?
  > Could you help me by explaining how their proposed method would not "determine whether members of a gene set S tend to occur toward the top (or bottom) of the list L"?

1. It seems to me that GSEA still has the limitation of analyzing each pathway independently (ES is calculated across all genes, but there is no evaluation of the appearance of one gene in multiple pathways), without considering the cross-communication between biological pathways. How do they address this problem?
  > I am not sure this is a feature or a bug of the methodology. Some genes are [more central](https://en.wikipedia.org/wiki/Interactome#Hubs) than others.

1. The limitation of the third generation approaches in pathways analysis is the missing innovation about cell types and different conditions. How can I choose conditions that could cause appropriate effect in the specific pathways?
  > What is meant by "innovation" in your question?

2. How to perform de-novo pathway analysis?
  > What is meant by this?

3. Is there any difference in data analysis from the microarray compared to single cell RNA-sequencing? What are the consideration that need to be taken into account?
  > I am not sure that there are particular properties we should take into account.

4. Which software can be applicable if I want to obtain a flow diagram, which explain number of pathways originated from a specific single gene?
  > [Reactome](reactome.org) has a pretty nice browser.

1. Regarding ORA approaches, the process is repeated for an background list of genes. In details, how is this measurement applied to determine for over- or under-representation?
  > I am not sure I understand the question.

1. The idea behind PT-analys seems to be to take into account the connection between genes in a pathway, but it mostly discusses distance - i.e. "pathway steps between genes". The ScorePAGE method divides the gene level statistic with the amount of steps between two genes. Would this lead to a lower score for a pathway where the differentially expressed genes are clustered in the beginning and end of a pathway? Can a pathway with regulation at the end and beginning not be just as affected - if not more - by these differentially expressed genes than a pathway where most differentially expressed genes are adjacent? It feels like the added information from this approach is a bit vague and not so useful?
  > Note that I did not instruct you to read up on PT-analysis. However, to me the PT approaches seem to be there to compensate for the inaccuracies in the annotations of pathways. Most of the approaches, however, have a problematic approach to [statistics](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0206864).

1. As from the notebook, it is common that the pathways geneset can not be completely covered by the measured genes, so how does the measured gene size affect the result of GSEA?  What gene size is enough for GSEA?
  > What is a gene size?
