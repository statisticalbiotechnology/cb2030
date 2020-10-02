# Issues to fix before start f the course.

General issues:
* Replace statistica books with ["Thinking Stats"](http://greenteapress.com/thinkstats2/html/index.html)
* Create a polished Q&A from last years questions?


## Notebooks

Update the notebooks so that the following questions are answered:

### Linear models
1. In the Jupyter notebook, the KNAP2 expression is tested for significant dependence on grade, tumor size and the intercation between size and grade. This resulted in a very small p value for grade (1.8E-8) and a quite large p value for size (0.45). The interaction between size and grade gave a significant *p* value (0.016). It then says that "The test suggest that KNAP2 expression depends on an interaction between tumor size and grade". My question is if the significant result obtained for the interaction could be due to the very small p value for grade, thereby kind of "masking" the large p value for size? So I am wondering if we really can be sure that the interaction is significant in itself, and not solely significant in the tumor grade?
 > No, this should not, at least not theoretically, be the case. The model should regress away the larger effect of the tumor grade, rendering the further tests data where the linear effect of the tumor grade is absent.

 1. How can one see “KNAP2 expression depends on an interaction between tumor size and grade” in the Jupyter notebook “KNAP2 gene analysis”? Which value in the table is the criterion?  
 1. In the video lecture, approximately at 11:50, you say that there is an inverse relationship between the node and the grade. How do you see this in the boxplots? How can you determine that there is an inverse relationship between these?
   >  The difference in KNAP2 expression between node=1 and node=0 is positive for grade=1 tumors, but negative for grade=3 tumors. Hence there is a tempting interaction between these variables. We subsequently test if this interaction is significant.  

1. In the video it seems to me that the effect of node upon gene expression is dependent on the grade of the cancer. Can you use multiple linear regression to study the effect of multiple parameters (such as grade/node/size) on a single feature (gene expression) while including the fact that the parameters can affect and be dependent on one another? Can that be done by representing each parameter as a separate "line equation" and looking at the sum of them?
    > Yes, the notebook, for instance, look at KNAP2 expression's dependency on the interaction between tumor grade and if the patient's lymph nodes have been removed or not.

1. In the jupyter notebook "KNAP2 gene analysis", for the different model equations, "C" is not the same value within the same equation? C could be a different values for each term, correct?
  > Not correct! We use the notation C(.), when we want to emphasise that a variable is categorical and not continuous.

  ### Multiple hypotheis Testing
1. In the last figure on notebook, the treshold separate true and false data. Could you explain why the true has to have high p-value (-logp is low)?
    > In the notebook, the features significant on a *q* value treshold of 10<sup>-10</sup> are labeled as "True" in the plot. The *q* value is semi-monotonically increasing with *p* value, so whenever q is low, p is low. low p means high -p, and high -log p.

1. I did not really follow how π 0 and λ were calculated/determine and how they relate to the q-value and FDR. Could you go through an example, maybe even use the TCGA breast cancer set, and go through step by step how you calculate these 4 variables from the data and in which order you do the calculations (which variables depend on each other?)?
    > It would be great if you tell me why the notebook is not a good enough example in itsef? Try to play around a bit with the notebook before the seminar.

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
