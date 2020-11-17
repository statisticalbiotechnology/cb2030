# Questions and Answers on Pathway Analysis.

1. I don’t really understand when it is better to use ORA and when FCS? In which “situations” are they used? FCS seems better than ORA and “solves” some limitations that ORA have but when is it still better to use ORA over FCS?
> There is no rule for this.

1. Pathway analysis methods rely on databases to establish which genes are working together. However, such gene sets may differ depending on the organism or even cell type studied (the Wnt example in Kathri et al.). How should we tackle this issue?
Should we avoid using pathway analysis if there is not a reliable database for our organism and cell type?
> The analysis is completely dependent on the curration of pathway databases. However, for unannotated speices assignments to pathways can often be done by searching for orthologs in organisms included in pathway databases.


1. In one of the articles, they state that there is a challenge in annotation. How would you practically overcome this challenge? Would you have to proceed by manual annotation or are there statistical analyses that can detect pathway-like relationships?
> It is challenging to annotate data. In generla this is done as community efforts by various underfunded angels across the world.

1. From the youtube video, I don't understand the biological meaning of the H0. I understand that we first extract those genes that are differentially expressed into a separate list (according to a conventionally set threshold) which is later compared to the list of the proteins of the pathway in order to look for overlaps. The null H is set as: (proteins in the pathway/ all measured proteins) = (overlap/differentially expressed genes), and it is this expression which biological interpretation is difficult to understand (at least for me). This is also why the p-values obtained from the notebook after performing ORA are not quite clear for me.
| # | p	| Overlap	| Term | q |
|---|---|---------|------|---|
| 0	| 6.142575e-11	| 24/124 | Cell cycle |	1.554448e-08 |
| 1	| 1.631457e-04 | 17/160	| Cellular senescence	| 2.064293e-02 |
| 2	| 3.322946e-04 | 7/35 | Alanine, aspartate and glutamate metabolism | 2.803030e-02 |  

does it mean that since the cell cycles's p-value<threshold then those 24 genes that overlap that are differentially expressed are just relevant for the pathway per se? or does it have another meaning? could you please explain more thoroughly this part?
> 24/124 means that there were 124 genes in the "cell cycle"'s pathway, whereof 24 genes were differentially expressed at a q<0.01.


1. The article "Ten Years of Pathway Analysis" is over 8 years old. What would you say are the application(s) described in the article that has progressed the furthest in these years? And what usage has driven this develpoment?
> Quite a lot of effort has been put into different types of network inferences for pathways. However, this is arguably a slowly moving field.

1. In the functional class scoring (FCS), you start by scoring/ranking the genes, do you then just take the genes with the highest score or do you need some prior knowledge of these genes functions in order to understand the pathway. I feel like you only identify genes that could be relevant to the pathway but not necessarily relevant. Is this assumption correct?
> E.g. GSEA uses expression values from all measured genes. That seems like a step forward from e.g. ORA.


1. Both ORA and GSEA have their pros and cons. Can you give an example of how to choose between the two methods in actual analysis?
> One usualy prefer GSEA when you have expression values, ORA when you for some reason do not.

1. How do the different generations of pathway analysis in one of the two papers compare to each other? Is it always the case that you employ the latest generation or not?
> I will not be able to cover this in a lecture.

1. In Subramanian's article, one of the advantages of GSEA is that it does not concentrate on the high scoring genes that are poorly annotated or could not be reproducible. However, the author mentions that GSEA is different from other tools because it considers all of the genes in the experiment. Although the leading-edge analysis can help conclude the subtle results, how do these 'bad' high scoring genes processed? Will the high ratio of these genes influence the final consequences?
> I do not understand what you mean with "'bad' high scoring genes".
