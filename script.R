Author: Ehtisham Khokhar
ehtishamshakeel@gmail.com
New Mexico State University


# PCA Analysis
install.packages("FactoMineR")
install.packages("factoextra")
install.packages("missMDA")

library(FactoMineR)
library(factoextra)
library(missMDA)

setwd("C:/Users/ehtis/OneDrive - New Mexico State University/SUNNY/Research Projects/Mechanical Harvest Paper/Phenotype manuscript/PCA")
#import data set, adjusted means
data <- read.csv("mydata.csv")
head(data)
str(data)
summary(data)
options(max.print = 99999)
print(data)
#A subset of the data (Across_data_PCA) is created, excluding the first column
Across_data_PCA <- data[, -1, drop = FALSE]
head(Across_data_PCA)
str(Across_data_PCA)
# Perform PCA
res.pca <- PCA(Across_data_PCA, scale.unit = TRUE)
summary(res.pca)
# check structure
str(res.pca)
# Extract eigenvalues
eigenvalues <- res.pca$eig
write.csv(eigenvalues, file = "eigenvalues.csv", row.names = FALSE)
# Extract contributions of traits to the variance of PC1 to PC5
contributions <- res.pca$var$contrib[, 1:5]
# Print the contributions
print(contributions)
write.csv(contributions, file = "contributions.csv", row.names = FALSE)
# Extract loadings
loadings <- res.pca$var$coord
# Extract correlation coefficients (R^2) for each principal component separately
R2_values <- res.pca$var$cor^2
write.csv(R2_values, file = "R2_values.csv", row.names = FALSE)
# Extract eigen vectors
eigen_vectors <- res.pca$svd$V
write.csv(eigen_vectors, file = "eigen_vectors.csv", row.names = FALSE)
#Scree plot
fviz_eig(res.pca)
ggsave("scree_plot.png", width = 8, height = 6, dpi = 600, bg = "white")
#Biplot cos
fviz_pca_var(res.pca,
             col.var = "contrib", gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE)
ggsave("biplot_cos.png", width = 8, height = 6, dpi = 600, bg = "white")
# Load necessary libraries
library(ggplot2)
# Extract the eigenvalue information from res.pca
eig <- res.pca$eig
# Create a data frame for plotting
variance_df <- data.frame(
  Component = 1:nrow(eig),
  Variance = eig[, 2],  # Percentage of variance explained
  CumulativeVariance = eig[, 3]  # Cumulative percentage of variance
)

# Plot the cumulative variance explained
variance_plot <- ggplot(variance_df, aes(x = Component)) +
  geom_line(aes(y = Variance, color = "Individual"), size = 1) +
  geom_point(aes(y = Variance, color = "Individual"), size = 2) +
  geom_line(aes(y = CumulativeVariance, color = "Cumulative"), size = 1) +
  geom_point(aes(y = CumulativeVariance, color = "Cumulative"), size = 2) +
  labs(
    title = "Variance Explained by Principal Components",
    x = "Principal Component",
    y = "Percentage of Variance Explained",
    color = "Legend"
  ) +
  scale_color_manual(values = c("Individual" = "green", "Cumulative" = "red")) +
  scale_y_continuous(
    breaks = seq(0, 100, by = 5),
    minor_breaks = seq(0, 100, by = 1)  # Adding minor ticks every 1%
  ) +
  scale_x_continuous(
    breaks = 1:nrow(eig),
    minor_breaks = 1:nrow(eig)  # Adding minor ticks for each component
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(hjust = 1),  # No rotation for x-axis labels
    panel.grid.major = element_blank(),     # Remove major grid lines
    panel.grid.minor = element_blank(),     # Remove minor grid lines
    axis.line = element_line(size = 1, colour = "black"),  # Add continuous lines for x and y axes
    axis.ticks.length = unit(0.15, "cm"),   # Length of the minor ticks
    axis.ticks = element_line(color = "black")  # Color of the minor ticks
  )
plot(variance_plot)
ggsave("scree_plot.png", plot = variance_plot, width = 10, height = 6, dpi = 600, bg = "white")

# Create Biplot Genotype by Descriptor
fviz_pca_biplot(res.pca,
                geom.ind = "point",
                col.ind = "blue",
                pointshape = 19, pointsize = 2,
                palette = c("red", "deepskyblue", "darkorange", "darkorchid"),
                addEllipses = FALSE,
                alpha.var = "contrib",
                col.var = "contrib",
                gradient.cols = c("black", "forestgreen", "firebrick"),
                repel = TRUE, # Add repel function
                legend.title = list(fill = "Genotype"),
                title = "Genotype by Trait Biplot")
ggsave("biplot_GxT.png", width = 8, height = 6, dpi = 600, bg = "white")


# Create Biplot Genotype by Descriptor with destemming ratings and wihtout ellipse 
fviz_pca_biplot(res.pca,
                geom.ind = "point",
                fill.ind = as.factor(data$Destemming),  # Factor for Destemming Quality
                palette = c("black", "blue", "firebrick"),  # Colors for groups
                pointshape = 21, pointsize = 2,  # Shape 21 allows fill color
                addEllipses = FALSE,  # Add ellipses around groups
                ellipse.type = "confidence",  # Confidence ellipses
                col.var = "contrib",  # Color gradient for variable contributions
                gradient.cols = c("black", "forestgreen", "firebrick"),  # Gradient colors
                repel = TRUE,  # Repel overlapping labels
                legend.title = list(fill = "Genotype", color = "Contrib"),  # Separate titles for fill and contrib gradients
                title = "Genotype by Trait Biplot with Destemming Categories")

# Save the biplot
ggsave("biplot_GxT_without_ellipses.png", width = 8, height = 6, dpi = 600, bg = "white")


# Create Biplot Genotype by Descriptor with destemming ratings with ellipse 
fviz_pca_biplot(res.pca,
                geom.ind = "point",
                fill.ind = as.factor(data$Destemming),  # Factor for Destemming Quality
                palette = c("black", "blue", "firebrick"),  # Colors for groups
                pointshape = 21, pointsize = 2,  # Shape 21 allows fill color
                addEllipses = TRUE,  # Add ellipses around groups
                #ellipse.type = "confidence",  # Confidence ellipses
                col.var = "contrib",  # Color gradient for variable contributions
                gradient.cols = c("black", "forestgreen", "firebrick"),  # Gradient colors
                repel = TRUE,  # Repel overlapping labels
                legend.title = list(fill = "Genotype", color = "Contrib"),  # Separate titles for fill and contrib gradients
                title = "Genotype by Trait Biplot with Destemming Categories")

# Save the biplot
ggsave("biplot_GxT_with_ellipses.png", width = 8, height = 6, dpi = 600, bg = "white")


# Biplot with convex hull ellipses for each group
fviz_pca_biplot(res.pca,
                geom.ind = "point",
                fill.ind = data$Destemming,  # Ensure Destemming is a factor
                palette = c("black", "blue", "firebrick"),  # Colors for categories
                pointshape = 21, pointsize = 2,  # Shape 21 allows fill color
                addEllipses = TRUE,  # Add ellipses around groups (convex hulls)
                col.var = "contrib",  # Color variables by contribution
                gradient.cols = c("black", "forestgreen", "firebrick"),  # Gradient for variable contribution
                repel = TRUE,  # Repel overlapping labels
                legend.title = list(fill = "Genotype", color = "Contrib"),  # Legend title adjustments
                title = "Genotype by Trait Biplot with Destemming Categories")

ggsave("biplot_GxT_with_each_group_ellipses.png", width = 8, height = 6, dpi = 600, bg = "white")

# Biplot with convex hull ellipses for each group using t-distribution-based ellipses
fviz_pca_biplot(res.pca,
                geom.ind = "point",
                fill.ind = data$Destemming,
                palette = c("black", "blue", "firebrick"),
                pointshape = 21, pointsize = 2,
                addEllipses = TRUE,
                ellipse.type = "t",  # Use t-distribution-based ellipses
                col.var = "contrib",
                gradient.cols = c("black", "forestgreen", "firebrick"),
                repel = TRUE,
                legend.title = list(fill = "Genotype", color = "Contrib"),
                title = "Genotype by Trait Biplot with Fruit Destemming Categories")

ggsave("biplot_GxT_t-distribution-based_ellipses.png", width = 8, height = 6, dpi = 600, bg = "white")

