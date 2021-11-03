# Issues to fix before start of the course.

## Lectures

### PCA

Add geographic PCA example to prep material.


## Notebooks

Update the notebooks so that the following questions are answered:

### Pathway Analysis

1. In the notebook the number of permutations for significance estimation is set to 100 to speed up the calculations but it was still very slow when I tried to execute it (in the binder server thing). Is the method typically slow or was it just the server?
 >  No, the calculations should be quick. However, the `gseapy` package does not execute its code locally, but instead submits each geneset as a job at the gsea or enrichr servers. This slows down the execution.

1. In notebook, the final FDRs seem high, being around 0.6~0.7, does this mean the pathways are most likely not enriched?
> Yes! Or at least that this implementation of pathway analysis does not pick up much signal.

1. Are there any cases, regarding differential gene expression, where it's better to not perform a pathway analysis, where individual measurements are preferred?
  > It all depends on what you are interested in reporting as a result.  

1. Could you explain more about GSEA part in Jupyter notebook? I am confused about the input data. It seems like you select five top scoring data sets. Is it enrichment score? Which ranked list L do you use?
  > No I list the top 5 pathways that stem from the gsea analysis.

1. In the jupyter notebook for the gsea analysis the number of processes is set to 4, why is this and why is the default 1?
  > This controls the speed the pathways are calculate, by allowing a different number of parallel processes.

### PCA

  1. What do the sentences “the genes pointing in a positive/negative direction for the two components” at the end of the jupyter notebook mean?
    > The genes with the higest resp lowest Eigen patients 1 and 2.

  1. In the final steps of the exercise presented in the notebook, the aim is to identify the genes that are more likely to be responsible for the observed difference among of lung cancer data points. The eigenpatients associated with the genes are investigated, and the KRT17 gene is identified as the minimal eigengene for eigenpatient 1 (i.e. the gene that least explains the variance in the dataset) and as the maximal eigengene for eigenpatient 2 (i.e. the gene that most explains the variability). Is this correct?  If so, does this mean the KRT17 gene explains the variation in the dataset better than the other 2 identified genes? Could you please elaborate a bit further the interpretation of these results?
    > Your interpretation that KRT17 drives both eigen patient 1 and 2 and hense is a better explanation of the data than the other genes could be right. [KRT17](https://www.proteinatlas.org/ENSG00000128422-KRT17/pathology) is a known cancer related gene. At this point of the analysis, it is not fully clear what the biological interpretation of PC2 is.  From the eigen gene plot, it is however clear that PC1 seem to capture the difference beween LUAD and LUSC.
