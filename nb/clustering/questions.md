1. **Data Exploration**:
   - The initial step involves cleaning the data by removing genes with no transcripts detected. Change the criteria for this cleaning step (e.g., remove genes with low variance across samples). How does this affect the number of genes included and the subsequent clustering results?

2. **Log Transformation Justification**:
   - The log transformation is applied assuming a log-normal distribution of expression values. Explore this assumption by plotting the distribution of expression values before and after log transformation. Does the transformed data appear to follow a normal distribution?

3. **Cluster Initialization**:
   - The k-means algorithm is sensitive to the initialization of centroids. Experiment with different `random_state` values or initialization methods (`init` parameter). Does this significantly alter the clustering outcome?

4. **Cluster Number Justification**:
   - Try other choices of k than two clusters (k=2) for the k-means algorithm. Do you find any calue of k that seems to make more sense than k=2?

5. **Comparative Analysis**:
   - The clusters are compared to Progesterone receptor (PR) and Estrogen receptor (ER) status. Extend this analysis to compare clusters with another clinical feature, such as patient age or tumor stage. What insights can you gather from this new comparison?

6. **Cluster Interpretation**:
   - Given that cluster 0 contains most patients who are ER- and PR-, can you identify any other gene expressions patterns that are characteristic of this cluster? Provide a code snippet to extract the top 5 overexpressed and underexpressed genes in cluster 0.

7. **Consensus Clustering**:
   - To assess the stability of clusters, implement consensus clustering for k=2. Does the consensus matrix indicate a clear separation between the two clusters?

8. **Understanding GMMs**:
   - Explain how GMMs differ from k-means in their approach to clustering. What are the advantages of using a GMM over k-means for clustering gene expression data?

9. **Covariance Type**:
   - In the code, the `covariance_type` is set to 'diag'. Explain what this means in the context of GMM and how it affects the shape of the clusters. What might be the implications of changing it to 'full' or 'tied'?

10. **Bayesian GMM**:
   - Describe the concept of a Bayesian GMM. How does the inclusion of a Dirichlet process prior affect the clustering process and results?

11. **Interpreting BGMM Clusters**:
   - The Bayesian GMM results in 11 clusters for the selected genes. What statistical or biological significance might these clusters correspond to? Are there any known associations between these genes and specific cancer subtypes?

12. **High Dimensionality**:
   - Clustering is performed on a subset of known cancer-associated genes. How might the results differ if all genes were used? Discuss the challenges and potential strategies for clustering high-dimensional data.
