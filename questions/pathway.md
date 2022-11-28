# Questions and Answers on Pathway Analysis.


### Pathway databases



### ORA vs. GSEA
GSA uses quantitative values as input, ORA don't. That is the main difference between the strategies.

1. I still don't understand how the input/output of both the ORA and GSEA differ and what their individual applicatory advantage is?
   > The ORA takes a gene list as input. Those gene lists are derived from differential expression analysis by selecting the most differentially expressed genes (based on a logFC cutoff). As an output, it gives a list of pathways enriched in a given gene list.  
   > On the contrary, GSEA takes the full expression matrix as an input. It first calculates correlations between gene expression and the conditions (e.g. disease) and ranks them based on correlation. After ranking, it checks whether a given pathway gene set is overrepresented at the top (or bottom) of the ranked gene list. As an output, it gives us the same as ORA.
   > The biggest advantage of using GSEA is that we do not threshold genes based on expression as it is biologically irrelevant in many cases.

### Sample size
1. In the article they mention that we can use GSEA even for the data sets consisting of small amount of samples, although the approach used in that case does not give an accurate result. I was wondering what number of samples we would have to use to be able to use the standard approach and get a relevant outcome. Is there any specific threshold?
   > I'm guessing that we can't put an exact number on what constitutes a "large enough" dataset. From the article when they are analyzing adenocarcinomas, they look at 3 different data sets and conclude that one of them is likely too small to have been able to provide useful information. This one had 24 samples, while the others had 62 and 86 respectively, which gives us some idea of how big the sample size might have to be for GSEA to work for it, although the number of genes analyzed for each sample likely also plays a role. 


### Over representation analysis (ORA)

### GSEA

### Correlation with phenotype

1. I don't know how did they relate phenotype to the expression profiles. For example, if they use (-1, 1) to indicate positively and nagetively related, what kind of function will they use within this range to represent relations?
   > I think the relationship with the phenotype is represented by the differential expression of the gene. E.g. we have the expression of gene X in healthy tissue (sample 1) and in disease tissue (sample 2). Then we calculate the differential expression between samples 1 and 2 (e.g. to what extend does expression of gene X change between healthy and disease state). This is done for every gene and it is then what we use as a measure for the correlation of the genes to the phenotype.
      > Typically one use a t-statistics to measure this 
### Validation

### Significance



### Notebook


### Other 
