
## ---------------------------------------------------------------------------------------------------
## INTRODUCTION TO R AND DATA VISUALIZATION TRAINING
## ---------------------------------------------------------------------------------------------------

## ---------------------------------------------------------------------------------------------------
# Getting Started
## ---------------------------------------------------------------------------------------------------

## Step 1. Create a folder in the document location under the Name "Senegal_Training"

## Step 2: Set a working directory (Default location where R looks for files and saves outputs)

setwd("~/Senegal_Training")         # It tells R where to look for files and where to save files

getwd()                                     # stands for "get working directory"


### Step 3: Install and Load necessary packages

# Install the packages**
  
#install.packages( c("ggplot2", "tidyverse", "psych", "gganimate", "ggpubr", 
#"ggstatsplot","patchwork","plotly", "rio", "gifski", "easystats", "gtsummary", 
#"flextable", "dlookr", "esquisse", "kableExtra", "tm", "wordcloud", "RColorBrewer"))
  

#**Load the necessary packages**
  
#This package provides a set of useful functions for data manipulation and visualization. 


library(ggplot2)       ## for data visualization
library(rio)           ## For easy data import, export(saving) and conversion
library(tidyverse)     ## for data manipulation
library(psych)         ## for description of  data
library(ggstatsplot)   ## Integrates statistical tests directly into your visualizations
library(patchwork)     ## Easily combines multiple plots into cohesive layouts
library(gganimate)     ## Adds dynamic animations to your visualizations
library(ggtext)        ## Adds rich test formatting capabilities to your plots
library(plotly)        ## Convert to interactive plot
library(easystats)     ## For statistical modeling & reporting
library(summarytools)  ## for summarizing data
library(sjmisc)        ## for data manipulation
library(geomtextpath)  ## combines text & paths for creative labeling along lines
library(ggdist)        ## Enhance visual representation of distribution & uncertainty
library(gghighlight)   ## Highlights specific data points or groups in your plots
library(ggiraph)       ## Makes your plots interactive with hover & click features
library(ggpubr)        ## Simplifies ggplot2-based visualization and statistical comparisons
library(ggrepel)       ## Improves readability by preventing overlapping text labels
library(gifski)        ## Provides a high-quality GIF encoder
library(GWalkR)        ## For interactive exploratory data analysis
library(esquisse)      ## GUI for creating ggplot2 plots interactively


## Step 4: Load the datasets

SMdata = import("SMdata.csv")       # Mock dataset(SMdata)

#Mdata = import("Mdata.csv")        # Malaria dataset

head(SMdata)                        # for the 1st few rows in the dataset
tail(SMdata)                        # for the last few rows in the dataset


## Step 5: Create attractive tables in R Markdown

library(kableExtra)

#knitr::kable(SMdata) #Create attractive tables in R Markdown


## Step 6: Exploratory data analysis (EDA)

## Explore the dataset
  
dim(SMdata)           # for dimensions of dataset
str(SMdata)           # for structure of dataset
names(SMdata)         # for features/ variable names in the dataset
describe(SMdata)      # for descriptive statistics



## Explore individual columns/variables

# Explore individual columns/variables

unique(SMdata$Region)                          # unique values for single column
table(SMdata$Region)                           # frequency for a single column
table(SMdata$Region, SMdata$Intervention_Type) # frequencies for multiple columns



## Diagnose the dataset

# Create a publication-ready diagnostic summary table

library(flextable)    # Creates highly customizable tables suitable for reporting and publication
library(dlookr)       # Analyzes the structure and quality of the dataset

diagnose(SMdata) |> flextable() 




## Step 7: gtsummary: Great for descriptive statistics (simplifies reporting with clear & organized tables)

library(gtsummary)
tbl_summary(SMdata)



# Step 8: Data Manupulation

## Using select() : Choose specific columns from the dataset.

# load the library
library(dplyr)

# Example: select columns/Variables/features in the data set

SMdata |>
  dplyr::select(Region, Age, Positive)

# Example: Drop columns/Variables/features in the data set
SMdata |>
  dplyr::select(-Region, -Age, -Positive)


## Use filter() to subset rows that meet certain conditions.

# Example: filter rows by numerical variable in the data set
SMdata |>
  dplyr::filter(Positive>210)

# Example: filter rows by categorical variable in the data set
SMdata |>
  dplyr::filter(Region == "Lake Basin")

## Using mutate() : Create new variables or modify existing ones.

# Example: Add a new column 'Rate' based on Total & Positive cases
SMdata |>
  dplyr::mutate(Rate = Positive/Total)



## Using arrange(): Sort rows based on one or more variables.

# Example: Arrange data by descending positive cases

SMdata |>
  dplyr::arrange(desc(Positive))

# Example: Arrange data by ascending positive cases
SMdata |>
  dplyr::arrange((Positive))



## summarize(): Collapse values to summary statistics

SMdata |>
  aggregate(Positive~ Region + Age + Intervention_Type, mean)



## Challenge 1: Explore the structure and summary of the Mdata dataset

# 1. What are the dimensions of the dataset?
  
# 2. What are the column names?
  
#  3. What are the column types?
  
#  4. What are some key variables or relationships that we can explore?
  
#  5. Select 3 columns (Gender, Age, Endemic_Zone)

# 6. Filter the rows by Endemic_Zone(lake Basin)


## ---------------------------------------------------------------------------------------------------  
## Section 3: Data Visualization
## ---------------------------------------------------------------------------------------------------

#Data visualization helps in understanding patterns, trends, and relationships in data.

#It is a crucial element in scientific research, enabling researchers to interpret and communicate their results effectively

## ---------------------------------------------------------------------------------------------------
## step 9: Introduction to Data Visualization with ggplot2
## ---------------------------------------------------------------------------------------------------

# What is ggplot2?
  
# A powerful plotting system for R, based on the Grammar of Graphics .

# Developed by Hadley Wickham .

# Allows building complex, publication-quality graphics in layers.

# ggplot2 is the gold standard when it comes to data visualization. Here's why:

 #     ✔️ Consistent, intuitive syntax that makes it easy to learn and use across various plot types.

  #    ✔️ Seamless integration with other tidyverse packages, enabling smooth data workflows.
      
   #   ✔️ Supports faceting, grouping, and mapping aesthetic.
      
    #  ✔️ Produces professional-quality visuals.

     # ✔️ Efficient handling of large data sets, ensuring smooth and responsive plotting even with complex data.

      #✔️ Over 100 extensions that enhance its core capabilities, providing endless options for creative visualizations.

      #✔️ Trusted by more than 1,000 packages, ensuring reliability and broad support.
 
## Essential layers used to create a plot:

 #1️ **Data:** The foundation, where you start by defining the data set.

 #2️ **Aesthetics:** Map variables to visual aspects like color, size, and position.

 #3️⃣ **Geometries:** Specify the type of plot you want, such as bar, line, or scatter.

 #4️⃣ **Facets:** Create subplots for different subsets of your data.

 #5️⃣ **Statistics:** Add statistical transformations, like mean lines or trend lines.

 #6️⃣ **Coordinates:** Control the plot’s coordinate system, such as flipping axes.

 #7️⃣ **Theme:** Adjust the overall appearance, like grid lines, font styles, and background.
 
  
### The data

# All ggplot2 plots require a data frame as input. 


 
# Initialize a ggplot object with data

SMdata |> ggplot()            # data: This will show an empty plot as no geom is added yet

  

### The aesthetics

#Next, we need to specify the visual properties of the plot that are determined by the data. 

#The aesthetics are specified using the aes() function. 

#The output should now produce a blank plot but with determined visual properties (e.g., axes labels).

 
SMdata |>                                      # data
  ggplot(aes(x = Total, y = Positive))         # aesthetics
  

### The geometries

#Finally, we need to specify the visual representation of the data. The geometries are specified using the geom_*() function. 

#There are many different types of geometries that can be used in ggplot2. 

#We will use geom_point() in this example and we will append it to the previous plot using the + operator. 

#The output should now produce a plot with the specified visual representation of the data.

#***use geom_point()***
 
SMdata |>                                       # data
       ggplot(aes(x = Total, y = Positive)) +   # aesthetics
  geom_point()                                  # geometry

  
# change the color of point to my choice

SMdata |>                                           # data
       ggplot(aes(x = Total, y = Positive)) +       # aesthetics
  geom_point(color = "Tomato")                      # geometry (change the color of point to my choice)

  
# color point in the plot by Region
 
SMdata |>                                                            # data
       ggplot(aes(x = Total, y = Positive, colour = Region)) +       # aesthetics(color point in the plot by Region)
  geom_point()                                                       # geometry 

# change the point size in the plot
 
SMdata |>                                                       # data
       ggplot(aes(x = Total, y = Positive, color = Region)) +   # aesthetics(color point in the plot by Region)
  geom_point(size = 4)                                          # geometry (change the point size in the plot )


# ✔️  Histogram: Used for understanding the distribution of a single variable.

# We will use geom_histogram() to the plot using the + operator. 

 
SMdata |>                                 # data
       ggplot(aes(x = Total)) +           # aesthetics
  geom_histogram()                        # geometries
  
# change the color
SMdata |>                               # data
       ggplot(aes(x = Total)) +         # aesthetics
  geom_histogram(fill = "red")          # Change the color

  
SMdata |>                                    # data
       ggplot(aes(x = Total)) +              # aesthetics
  geom_histogram(fill = "red", bins = 5)     # Change the color & specifies the number of bars 

 
SMdata |>                                                     # data
       ggplot(aes(x = Total)) +                               # aesthetics
  geom_histogram(fill = "red", bins = 5, color = "black")     # Change the color & specifies the number of bars 
 
## ✔️  Bar Chart: Used for comparing categorical data.

#We will use geom_bar() to the plot using the + operator. 

 
# Create a bar plot
SMdata |>                             # data
       ggplot(aes(x= Age)) +          # aesthetics
  geom_bar()                          # geometrics

SMdata |>                          # data
       ggplot(aes(x= Age)) +       # aesthetics
  geom_bar(fill = "blue")          # geometrics (the "fill" argument specifies the color of the bars)

 
# Create a bar plot
SMdata |>                                     # data
       ggplot(aes(x= Age, fill = Age)) +      # aesthetics
  geom_bar()                                  # geometrics 

  


## ✔️  Boxplot: Used for Detecting outliers and understanding the spread of data.
# We will use geom_boxplot() using the + operator. 

 
# create boxplot chart

SMdata |> 
       ggplot(aes(x= Intervention_Type, y = Positive)) +
  geom_boxplot()

  


 
# geometrics (the "fill" argument specifies the color of the boxplot)

SMdata |> 
       ggplot(aes(x= Intervention_Type, y = Positive)) +
  geom_boxplot(fill = "red")                             

  


 
# the "fill" argument specifies the color of boxplot by Region)

SMdata |> 
       ggplot(aes(x= Intervention_Type, y = Total, fill = Region)) +       
  geom_boxplot()

  


 
# adds random noise (jitter) to points in a scatter plot to reduce overplotting when many points overlap

SMdata |>
       ggplot(aes(x= Intervention_Type, y = Total, fill = Region)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.2) # Controls transparency (opacity) of points[from 0 (completely transparent) to 1 (fully opaque)]

  

## Challenge 2: Create ggplot2 visualizations of the ‘Mdata’ dataset
   
#  1. How do rainfall, temperature, and humidity correlate with mosquito density? (Scatter plot)
  
#  2. What is the distribution of different mosquito species in the dataset? (Bar chart or pie chart)
  
#  3. Which mosquito species are prevalent in different endemic zones? (Bar chart)
  
#  4. How do mosquito densities vary by species across endemic zones? (grouped boxplot)
  
#  5. What is the relationship between test results and mosquito density? (stacked bar chart)
  
#  6. Is there a combined effect of temperature and humidity on mosquito density? (Heatmap)



## Step 10: Customizing ggplot Graphics for Presentation and Communication

### Labels: Adding Titles and Labels

# Clear titles and labels are essential for making your plots understandable.

# Labels can be added to various components of a plot using the labs() function.

 
ggplot(data = SMdata, aes(x = Total, y = Positive)) +
  geom_point(color = "tomato") +
  labs(x = "Total",
       y = "Positive cases",
       title =  "Number of positive cases by Total",
       caption = "Source: CDAM Experts, 2025") +
       theme_classic()
  

 
# Align the title to the center

ggplot(data = SMdata, aes(x = Total, y = Positive)) +
  geom_point(color = "tomato") +
  labs(x = "Total",
       y = "Positive cases",
       title =  "Number of positive cases by Total",
       caption = "Source: CDAM Experts, 2025") +
       theme_classic() +
  theme(plot.title = element_text(hjust = 0.5)) # Align the title to the center

  

### Themes

# The “theme” function is used to specify the theme of the plot. 

#There are many preset theme functions, and further custom themes can be created using the generic theme() function.

# There are many different themes that can be used in ggplot2. 

## Typically you will want to set the theme at the end of your plot.

 
SMdata |> ggplot(aes(x = Total, y = Positive)) +
  geom_point(color = "tomato") +
  theme_classic()

  


 
SMdata |> ggplot(aes(x = Incidence_Rate, fill = Region)) +
  geom_histogram(color = "red") +
  theme_classic()

  


 
# change the position of the legend to Top/Bottom
SMdata |> ggplot(aes(x = Incidence_Rate, fill = Region)) +
  geom_histogram(color = "red") +
  theme_classic() +
   theme(legend.position = "top")

  

### Custom color palettes

ggplot(data = SMdata, aes(x= Region, y = Incidence_Rate, fill = Age)) +
  geom_boxplot() +
  scale_fill_brewer(palette = "Set1") +
  theme_bw()

  

# **Remarks:** The examples above show how to use colors for categorical variables, but we can also use custom color palettes for continuous variables.

 
SMdata |> ggplot(aes(x = Total, y = Positive, color= Incidence_Rate)) +
  geom_point(color = "tomato") +
  labs(x = "Total",
       y = "Positive cases",
       title =  "Number of positive cases by Total",
       caption = "Source: CDAM 2025") +
       theme_classic() +
  theme(plot.title = element_text(hjust = 0.5)) # Align the title to the center

  


 
ggplot(data = SMdata, aes(x = Total, y = Positive, color= Incidence_Rate)) +
  geom_point(color = "tomato") +
  geom_smooth(method = "lm") +
  labs(x = "Total",
       y = "Positive cases",
       title =  "Number of positive cases by Total",
       caption = "Source: CDAM 2025") +
       theme_classic() +
  scale_color_gradient(low ="blue", high ="red") +
  theme(plot.title = element_text(hjust = 0.5)) # Align the title to the center
  

### Faceting: Creating Small Multiples

# Facets are a powerful feature of ggplot2 that allow us to create multiple plots based on a single variable. 

# This “small multiple” approach making it easy to compare distributions or relationships across groups.

# Facets also make use of the ~ operator.

 
SMdata |> ggplot(aes(x = Total, y = Positive, color= Incidence_Rate)) +
  geom_point() +
  facet_wrap(~ Intervention_Type)+ 
  scale_color_gradient(low ="blue", high ="red") +
  labs(x = "Total",
       y = "Positive cases",
       title =  "Number of Malaria case by Total cases") +
  theme_classic()
  

 
# Create multiple bar plots using facet_wrap()
SMdata |> ggplot(aes(x = Age, y = Positive, fill = Age)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ Year) +
  labs(title="Multiple Bar Plot by year",
       x="Age Group",
       y="Malaria Positive Cases Reported",
       caption = "Source: Malaria data") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5)) # Align the title to the center
  

 
SMdata |> ggplot(aes(x = Region, y = Incidence_Rate, fill = Region)) +
  geom_boxplot() +
  facet_wrap(~ Intervention_Type) +
  coord_flip() +  # flips the x and y axes
  scale_fill_manual(values = c("#C6E0FF", "#136F63", "#E0CA3C", "#F34213", "#3E2F5B")) +
  labs(title = "Malaria incidence rate by Region and Intervention type",
       x = "Region",
       y = "Incidence rate",
       fill = "Intervention type") +
theme_classic() +
 theme(plot.title = element_text(hjust = 0.5)) # Align the title to the center
  


 
SMdata |> ggplot(aes(x= Intervention_Type, y = Total, fill = Region)) +
  geom_boxplot() +
  labs(x = "Intervention type",
       y = "Total cases",
       title =  "Number of Malaria case by Intervention type") +
   theme_light() +
  theme(legend.position = "bottom") +
  theme(plot.title = element_text(hjust = 0.5)) # Align the title to the center
  

## Step 11: Need a quick and easy way to create attractive charts in R? 

# Install and load ggcharts package
library(ggcharts)
library(ggplot2)

 SMdata |> ggplot(aes(Region, Positive, fill = Region)) +
  geom_col() +
  coord_flip() +
  facet_wrap(vars(Year), scales = "free_y") +
  theme_bw()
 
  

## Step 12. Easily combines multiple plots into cohesive layouts
# Load the library
# library(ggplot2)
library(patchwork)

p1 = SMdata |> ggplot(aes(x = Total, y = Positive, color= Incidence_Rate)) +
  geom_point() +
  facet_wrap(~ Intervention_Type)+ 
  scale_color_gradient(low ="blue", high ="red") +
  labs(x = "Total",
       y = "Positive cases",
       title =  "Number of Malaria case by Total cases") +
  theme_classic() +
  theme(legend.position = "bottom")

p2 = ggplot(data = SMdata, aes(x = Total, y = Positive, color= Incidence_Rate)) +
  geom_point() +
  theme_classic() +
  scale_color_gradient(low ="blue", high ="red") 
  
p3 = ggplot(data = SMdata, aes(x = Age, y = Positive, fill = Age)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ Year) +
  labs(title="Multiple Bar Plot by year",
       x="Age Group",
       y="Malaria Positive Cases Reported",
       caption = "Source: Malaria data") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5)) # Align the title to the center


# Arrange in a grid layout
nested_plot <- (p1| p2 | p3) +
                plot_annotation(title = "Combined Plots Example")

# Display the nested plot
print(nested_plot)

ggsave("Plot_2.png")

  


## Step 13: Exporting plots

# We can export plots to a variety of formats using the ggsave() function. 

# We can specify which plot to export by saving in an object and then calling the object in the ggsave() function, otherwise ggsave() will save the current/last plot. 


 
# Create multiple bar plots using facet_wrap()
SMdata |> ggplot(aes(x = Age, y = Positive, fill = Age)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ Year) +
  labs(title="Multiple Bar Plot by year",
       x="Age Group",
       y="Malaria Positive Cases Reported",
       caption = "Source: Malaria data") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5)) # Align the title to the center

plot_1 <-ggsave("Plot_1.png", width = 10, height = 6, dpi = 300)

  


## Section IV: Advanced Topics and Best Practices

### Advanced Topics

 #✅ Interactive Visualizations: Use tools like Plotly and Dash to enable user interaction.
 
 #✅ High-Dimensional Data Visualization: Use PCA, t-SNE, and UMAP for dimensionality reduction.
 
 #✅ Time Series Visualization: Apply line plots, heatmaps, and rolling averages for trends.
 
 #✅ Network Graph Visualization: Use NetworkX and Gephi for social and supply chain analysis.
 
 #✅ Big Data Visualization: Handle large datasets with Dask, Vaex, and Apache Superset.

## Step 14: Interactive Visualizations: Use tools like Plotly and Dash to enable user interaction.

 
library(plotly)

# Create a ggplot

p = SMdata |> ggplot(aes(x = Total, y = Positive, color= Incidence_Rate)) +
  geom_point() +
  facet_wrap(~ Intervention_Type)+ 
  scale_color_gradient(low ="blue", high ="red") +
  labs(x = "Total",
       y = "Positive cases",
       title =  "Number of Malaria case by Total cases") +
  theme_classic() + theme(plot.title = element_text(hjust = 0.5)) # Align the title to the center

# Convert to interactive plot
ggplotly(p)

  


# adds dynamic animations to your visualizations
 
library(plotly)  # create interactive visualizations 

# color point in the plot by Region
plot_3 = SMdata |> ggplot( aes(x = Total, y = Positive, color = Region)) +
  geom_point(size=4) +
  labs(title="Malaria Positive Cases vs Total by Region",
       subtitle="Time: {frame_time}",   # Display time as subtitle
       x= "Total Cases",
       y= "Number of Positive Cases",
       caption = " Source: CDAM Experts, 2025") +
  theme_bw() +
   theme(plot.title = element_text(hjust = 0.5)) # Align the title to the center

# Add animation with gganimate
animated_plot <- plot_3 +
  transition_time (Year) +  # Animate over 'time' variable
  ease_aes('linear')       # Smooth linear transitions

animated_plot

 
# Load required libraries
library(ggplot2)   # for creating static data visualizations
library(gganimate) # for creating animated visualizations
library(gifski)    # provides a high-quality GIF encoder

plot3 = SMdata |> ggplot(aes(x = Incidence_Rate, fill = Region)) +
  geom_histogram(color = "red") +
  labs(title ="Distribution of Malaria Cases per Incidence Rate by Region",
       subtitle="Time: {frame_time}",  # Display time as subtitle
       y = "Number of Malaria cases",
       x = " Incidence Rate",
       caption = "Source: CDAM Experts, 2025") +
  theme_classic() +
   theme(legend.position = "bottom") +
    theme(plot.title = element_text(hjust = 0.5)) # Align the title to the center

# Add animation with gganimate
animated_plot <- plot3 +
  transition_time (Year) +  # Animate over 'time' variable
  ease_aes('linear')       # Smooth linear transitions

# Save or display animation
#anim_save("Plot_3.gif", animation = animated_plot) # Save as GIF

animated_plot

  

## correlation plot
 
# Load the library
library(ggstatsplot)

# Create correlation matrix plot 
ggstatsplot::ggcorrmat(
  data = SMdata,
  type = "parametric",                 # Correlation method: "pearson", "spearman", "kendall"
  sig.level = 0.05,                    # Significance level for p-values
  colors = c("blue", "white", "red"),  # Color gradient
  title = "Correlation Matrix SMdata Dataset")


## pie chart or Donut chart
 
library(plotly)

df <- as.data.frame(table(SMdata$Region))
colnames(df) <- c("Region", "freq")


plot_ly(df,
        labels = ~df$Region,
        values = ~df$freq,
        type = 'pie',
        hole = 0.3,                  # Makes a doughnut chart; set to 0 for a full pie chart
        textinfo = 'label+percent',  # Shows both labels and percentages
        marker = list(colors = colorRampPalette(c('blue', 'green', 'tomato', 'skyblue'))(nrow(df))))

  

## Violin plots

# Violin plots are similar to box plots, except that they also show the kernel probability density of the data at different values. 

SMdata |> ggplot(aes(x = Age, y = Positive)) +
  geom_violin(fill = "tomato") +
  geom_jitter(alpha = 0.2) +
  theme_classic()
  

## Statistical Reporting using {ggstatsplot} package


#Using ggstatsplot to create a violin plot with statistical annotations

library(ggstatsplot)

ggstatsplot::ggbetweenstats(
  data = SMdata,
  x = Age,
  y = Positive,
  type = "parametric",      # Choose the type of statistical test (parametric or non-parametric)
  title = "Comparison of Malaria incidence rate by Age group",
  xlab = "Age group",
  ylab = "Incidence Rate",
  pairwise.display = "significant",  # Show only significant pairwise comparisons
  ggtheme = ggplot2::theme_classic())

  

## Create basic violin plots with summary statistics:
 
library(ggstatsplot)

ggbetweenstats(
  data  = SMdata,
  x     = Intervention_Type,
  y     = Positive,
  title = "Distribution of Positive cases across Intervention type")
  

## Create the plot with boxplot, jitter, and statistical comparisons
 
library(ggplot2)
library(ggpubr)

# Create the plot with boxplot, jitter, and statistical comparisons

ggplot(SMdata, aes(x = Age, y = Total, fill = Age)) + 
  geom_boxplot(outlier.shape = NA, alpha = 0.6) +          # Remove outliers to prevent overplotting
  geom_jitter(width = 0.2, alpha = 0.6, aes(color = Age)) +
  stat_compare_means(method = "kruskal.test", label.y = 700) +  # Overall Kruskal-Wallis test
  stat_compare_means(comparisons = list(c("5 to 14", "Above >14"),
                                        c("5 to 14", "Below <5"),
                                        c("Above >14", "Below <5")),
                       method = "wilcox.test", label.y = 550) +  # Overall Kruskal-Wallis test
  labs(title = "Incidence Rate by Age group",
       x = "Age group",
       y = "Incidence  Rate") +
  theme_classic()
  

## Create a histogram with statistical inference using the gghistostats() function
 
gghistostats(
  data       = SMdata,
  x          = Positive,
  title      = "Number of PositiVe malaria cases",
  test.value = 70,
  binwidth   = 10)

 
library(ggstatsplot)
ggscatterstats(
  data  = SMdata,
  x     = Total,
  y     = Positive,
  xlab  = "Total Population",
  ylab  = "Number of Positive cases",
  title = "Scatter Plot of Positives cases vs Total population")

  

## Running a linear regression model and plotting the coefficient estimates using 'ggcoefstats()'
 
library(ggstatsplot)

# model
model <- stats::lm(formula = Incidence_Rate ~ Positive + Total, data = SMdata)

ggcoefstats(model)

  

## Step 15. Word cloud visualization

# A word cloud (or tag cloud) is a visual representation of text data where the size of each word indicates its frequency or importance. 
# Commonly used for exploring text data that include survey responses, article content, or social media posts.

 
# Load the libraries
library(tm)
library(wordcloud)
library(ggplot2)
library(RColorBrewer)
library(plotly)

# Sample text data

docs <- Corpus(VectorSource(c("The article aims to develop interpretable Machine Learning models using R statistical programming language for malaria risk prediction in Kenya, emphasizing leveraging Explainable AI (XAI) techniques to support targeted interventions and improve early detection mechanisms. The methodology involved using synthetic data with 1000 observations, employing over-sampling to address class imbalance, utilizing two machine learning algorithms (Random Forest and Extreme Gradient Boosting), applying cross-validation techniques, Hyper-parameter tuning and implementing feature importance and SHAP (Shapley Additive Explanations) for model interpretability. The findings revealed that Random Forest outperformed Extreme Gradient Boosting with 98% accuracy. Critical prediction features included clinical symptoms such as nausea, muscle aches, and fever, plasmodium species identification, and environmental factors like rainfall and temperature. Both models demonstrated strong sensitivity in detecting malaria cases. This promotes trust in model predictions by clearly outlining the decision process for individual outcomes. The research concluded that integrating Explainable AI into malaria risk prediction represents a transformative approach to public health management. Through providing transparent, interpretable models, the research offers a robust, data-driven approach to predicting malaria risks, potentially empowering healthcare providers and policymakers to deploy resources more effectively and reduce the disease burden in endemic regions.")))

# Text preprocessing
docs <- tm_map(docs, content_transformer(tolower))  # Convert to lowercase
docs <- tm_map(docs, removePunctuation)             # Remove punctuation
docs <- tm_map(docs, removeNumbers)                 # Remove numbers
docs <- tm_map(docs, removeWords, stopwords("english"))  # Remove stopwords

dtm <- TermDocumentMatrix(docs)
matrix <- as.matrix(dtm)
word_freqs <- sort(rowSums(matrix), decreasing=TRUE)
df <- data.frame(word = names(word_freqs), freq = word_freqs)
  


 
# Word cloud visualization
wordcloud(words = df$word, 
          freq = df$freq, 
          min.freq = 1,
          max.words=100, 
          random.order=FALSE, 
          colors=brewer.pal(6, "Dark2"))
  


 
# Bar chart visualization
ggplot(df[1:6,], aes(x = reorder(word, freq), y = freq, fill = word)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Top Words in Text Data", x = "Words", y = "Frequency")


# Optional: Visualize word frequencies as a bar plot
barplot(word_freqs[1:6], 
        las = 2, 
        col = brewer.pal(8, "Set2"), 
        main = "Top 6 Most Frequent Words",
       ylab = "Frequency")

 
# References

# 1. https://ggplot2.tidyverse.org/ 
 
# 2. https://ggplot2-book.org/
 
# 3. https://r-spatial.github.io/sf/
 
# 4. https://thomas-neitmann.github.io/ggcharts/
 
# 5. https://github.com/IndrajeetPatil/ggstatsplot
 
# 6. https://github.com/CDAMChukaUniversity/Senegal_Training.git

 
# Prepared by: Dennis K. Muriithi,Ph.D.


  
 

       
       
