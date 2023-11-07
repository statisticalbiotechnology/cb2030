Some questions relating to the KNAP2 notebook.

1. **Understanding the Biological Context**:
   - Summarize the importance of the KPNA2 gene in the context of cancer biology as presented in the notebook. What role does it play, and why is it significant to study its expression levels?

2. **Data Loading and Inspection**:
   - After loading the data as shown, extract and display the last five observations. Compare these with the first five. What can you infer about the data from this comparison?

3. **Data Preprocessing and Exploration**:
   - The notebook conducts some data preprocessing. How does the inclusion of this step potentially affect the subsequent analysis?

4. **Linear Models Implementation**:
   - One or more linear models using OLS are constructed in the notebook. Build an additional OLS model that includes interaction terms between predictors. How does this model's performance compare to the ones without interaction terms?

5. **Visualization of Results**:
   - Recreate the plot illustrating the relationship between KPNA2 expression and another variable of your choice. How does this visualization help in understanding the linear model's fit?

6. **Model Diagnostics**:
   - Perform a diagnostic analysis of the residuals from one of the OLS models. What do the diagnostics tell you about the model's assumptions?

7. **Model Comparison**:
   - The notebook may compare different models. Replicate this comparison and extend it by including a new model that uses a different combination of variables. Discuss the criteria for model selection and the trade-offs involved.

8. **Variable Selection**:
   - The notebook uses specific independent variables for the OLS model. Change the independent variables to include 'Age'. How does this change the fit of the model?

9. **Feature Engineering**:
   - Create a new independent variable by combining two of the variables already in use (for example, a ratio or product of the two). Include this in the model and discuss any changes in model performance or coefficient significance.

10. **Model Adjustment**:
   - Remove the independent variable with the smallest coefficient and re-run the OLS model. Discuss how the model's performance metrics (e.g., R-squared, AIC, BIC) are affected by this change.

11. **Interaction Terms**:
   - Add an interaction term between two independent variables in the OLS model. Evaluate whether the interaction term significantly improves the model by looking at the p-value and the change in R-squared.

12. **Non-linear Transformations**:
   - Apply a non-linear transformation (such as log, square root, or square) to one of the independent variables and fit the OLS model again. How does this transformation affect the model's assumptions and fit?

13. **Residual Analysis**:
   - For a model with a new combination of independent variables, analyze the residuals. Are there patterns or is there evidence of heteroscedasticity? If so, attempt to mitigate this through transformations or adding/removing variables.

14. **Exploring Model Limitations**:
    - Introduce a deliberately “bad” combination of independent variables (variables that you would not expect to predict KPNA2 expression). Fit the model and then discuss the results. How does the model’s performance highlight the importance of variable selection in OLS regression?
