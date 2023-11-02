
1. **Thresholds**:
   - Thresholds are set to determine which tests are deemed significant. We normally only report significant findings as outcome of an experiment.
  
2. **Multiple Testing Problem**:
   - When performing many hypothesis tests simultaneously, the chance of observing FPs increases. This necessitates adjustments to control the error rate.

3. **False Discovery Rate (FDR)**:
   - FDR is the expected proportion of false positives among the significant statistics.
   - FDRs correct for multiple tests.

4. **Storey's *q* value**:
   - For a given test, the *q* value represents the minimum FDR at which that test can be considered significant.
   - Estimates the number of false positives as F(t) = π₀*t*m, and compares it to number of *p* values below treshold.

5. **π₀ Estimation**:
   - Storey&Tibshirani estimates π₀ from spline fits to |{p>l}|/m(1-l)
   - Storey introduced a method using bootstrapping to estimate π₀, the proportion of true null hypotheses.


