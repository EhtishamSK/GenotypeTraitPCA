## Principal Component Analysis (PCA) of Phenotypic Data  

This R script performs **Principal Component Analysis (PCA)** on phenotypic data to explore the underlying structure of traits across a set of genotypes.  

### Workflow
1. **Load libraries** and import a dataset containing adjusted means.  
2. **Preprocessing**: Exclude the first column of the dataset to focus on trait variables.  
3. **PCA computation**: Conducted using the `PCA` function from the **FactoMineR** package, with variables standardized.  
4. **Extract outputs**:  
   - Eigenvalues  
   - Trait contributions to the principal components  
   - Loadings  
   - Correlation coefficients  
   - Eigen vectors  
   These are saved as **CSV files** for further analysis.  

### Visualizations
- **Scree plot**: Displays the variance explained by each principal component.  
- **Biplot**: Illustrates the relationship between genotypes and traits.  
- **Cumulative variance plot**: Shows the proportion of variance explained by principal components.  

All plots are saved as **PNG files**.  

This workflow enhances understanding of the dataset’s structure and the contribution of traits to the observed variation.
