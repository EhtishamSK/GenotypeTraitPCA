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
   - Eigenvectors  
   These are saved as **CSV files** for further analysis.

### Visualizations
- **Scree plot**: Displays the variance explained by each principal component. See an example of how cumulative variance and individual component contributions are depicted in this **variance plot**: [see example](https://journals.ashs.org/view/journals/hortsci/57/12/article-p1507.xml)  
- **Biplot**: Illustrates the relationship between genotypes and traits. Traits’ contributions and genotypic relationships are visualized in a **PCA biplot**: [see example](https://www.nature.com/articles/s41598-025-94819-z/figures/5)  
- **Cumulative variance plot**: Also included to provide insight into the proportion of variance explained by the principal components (often shown alongside or integrated into the scree plot).

All plots (scree plot, biplot, cumulative variance plot) are saved as **PNG files**.

This workflow enhances understanding of the dataset’s structure and the contribution of traits to the observed variation.

