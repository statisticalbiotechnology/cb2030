# Questions on notebook

## Conceptual Understanding:

* What is the primary goal of this notebook?
* Where is the breast cancer RNAseq data being retrieved from?
* What is the significance of the "Binder" badge mentioned at the beginning of the notebook?
* Why is it essential to explore the brca and brca_clin DataFrames?
* What is the goal of the differential expression analysis in this section?
* Define a triple-negative breast cancer. Why is it important to distinguish it from other types of breast cancers?
* Why are the hormonal therapies ineffective for triple-negative cancers?

## Libraries and Modules:

* What is the purpose of the pandas library in this notebook?
* What does the seaborn library provide?
* Why do you think the sys.path.append("..") code is used?

## Data Manipulation and Analysis:

* What type of data does brca contain, and how is it different from brca_clin?
* Why is it important to clean the data before analysis?
* What criteria are used to remove genes from the brca DataFrame?
* What is the significance of the log transformation applied to the expression data? Why is it assumed that expression values follow a log-normal distribution?
* Describe the method used to determine which cancers in the dataset are triple negative.
* How does the get_significance_two_groups function determine the differential expression of a gene between triple-negative cancers and others?
* What is the significance of the log_fold_change calculation? How is it interpreted?
* Why is the t-test chosen for calculating the significance of differences? What is the importance of setting equal_var=False in the t-test?

## Code Execution:

* If you wanted to check for genes that are differentially expressed in cancers that express only "Estrogen receptors", how would you modify the code to do so?
* How would you extract the top 10 genes with the highest absolute log fold change values from the pvalues dataframe?
* How would you visualize the distribution of p-values from the pvalues dataframe?

## Interpretation and Further Analysis:

* Why are the p-values transformed using -np.log10(p)?
* What would be the next steps after obtaining the list of genes with their associated p-values and fold changes? How can the results guide further research or treatment strategies?
* How would you approach multiple testing corrections given the number of genes tested for differential expression?

## Exploratory Questions:

* Suppose you have another dataset containing gene expression data for a different type of cancer. How would you modify the code to perform differential expression analysis on that data?
* If you were to visualize the genes with the most significant differences in expression (either highest or lowest p-values), how would you proceed?
* How could machine learning methods be incorporated into this analysis to predict the type of cancer based on gene expression patterns?
