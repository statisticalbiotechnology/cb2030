# Issues to fix before start of the course.

## Lectures

### Supervised learning

Consider to use "Hyperparameters and Model Validation" section, and remove the details of SVMs.
### Clustering

Consider to remove the ref to EM in k-Means



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