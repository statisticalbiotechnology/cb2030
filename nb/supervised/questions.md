
1. **Data Preprocessing Effects**:
   - Modify the data preprocessing steps (such as normalization or feature scaling) and observe how these changes affect the outcomes of the models. Which preprocessing step had the most significant impact?

2. **Feature Weights**:
    - Fot the overoptimistic predictor, investigate which features that are given the highest weight, by studying the `clf.coef_` vector. Do these genes have any particular relevance for the disaease?

3. **Cross-validation**:
   - Vary the number of folds in the cross validation of the low dimensional classifier. Does this effecet the outcome.

4. **Type of classifier**
    - Replace the LinearSVM classifier by any non-linear classifier from the sk-learn library, e.g. [HistGradientBoostingClassifier](https://scikit-learn.org/stable/modules/ensemble.html#histogram-based-gradient-boosting). How does this effect the behaviour of the classifier?
  
5.  **Model Robustness**:
    - Introduce noise to the data (e.g., randomly flip labels or add outliers) and re-evaluate the model's performance. Which model handles noise better, and why do you think that is?

