# Questions for understanding notebook

Here are a set of questions based on the provided Jupyter notebook section:

## Code Interpretation:

1. What is the implication of setting any value less than or equal to 0.0 to NaN?
2. In the function `get_significance_two_groups`, what is being returned? Describe each value.
3. Describe the purpose of the bootstrap method and how it relates to the calculation of \(\pi_0\). How does this differ from the procedure described in Storey and Tibshirani?
4. How is \(\pi_0\) different from the q-value and why might it be a significant measure?

## Data Interpretation:

1. Explain the significance of the observed enrichment of low p-values in the plotted histogram.
2. What does the distribution of p-values in the higher end of the distribution suggest about the genes?
3. Based on the results, how can one interpret the estimated value of \(\pi_0\)? Why might it be significant that the value is around 0.1938?

## Further Analysis:

1. How can the q-values calculated here be used to filter out genes for further investigation?
2. Explain the potential causes for the high percentage of genes being differentially expressed in triple-negative cancers.
3. If you wanted to further validate the results, what additional analyses might you perform?

### Visualization Questions:

1. How does the number of differentially expressed genes change with varying q-values? What does this indicate about the significance of the data?
2. Describe the rationale and significance of using a Volcano plot in this analysis.
3. What does the hue "Significant" represent in the Volcano plot?
4. In the Spline estimation of \(\pi_0\), what's the significance of the blue line versus the red line in the plots?
5. What does the two subplots showcasing different intervals for \(\lambda\) tell you about the behavior of \(\pi_0(\lambda)\)?

### Technical/Methodological Questions:

1. What is the significance of \( \pi_0 \) in the context of this analysis?
2. How does the bootstrap method differ from the spline estimation method for calculating \( \pi_0 \)?
3. The bootstrap method and the spline estimation method give slightly different estimates for \( \pi_0 \). What might account for these differences?
4. Storey and Tibshirani's procedure for estimating \( \pi_0 \) was adapted in this analysis. What were the modifications made, and why might they have been made?

### Interpretation Questions:

11. Given the mention of possible differences in sample handling or normalization of data, how might these factors confound the interpretation of results?
12. A very low \( \pi_0 \) was noted, suggesting about 80% of all genes are differentially expressed in the triple-negative cancers. How might this have implications for treatment and understanding of the biology of triple-negative cancers?
13. The Volcano plot complements FDR thresholds. Why might it be important to highlight transcripts that are significantly differentially abundant at a given FDR-threshold?
14. In the context of this research, how does a triple-negative breast cancer differ in its gene expression compared to other types of breast cancers?

### Further Research/Experiments:

15. How might the results change if different data normalization techniques were employed?
