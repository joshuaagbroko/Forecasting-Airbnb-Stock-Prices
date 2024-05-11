# Summary Statistics
summary(airbnb_stock)
#Data Structure: Examine the structure of the dataset to understand variable types and ensure they're interpreted correctly.
str(airbnb_stock)

#Time Series Visualization: Create time series plots to visualize the trends, seasonality, and outliers in the data.
# Time series plot of closing prices
ggplot(airbnb_stock, aes(x = Date, y = Close)) +
  geom_line() +
  labs(title = "Airbnb Stock Closing Prices Over Time",
       x = "Date", y = "Closing Price")

# Histograms and Density Plots: Explore the distributions of numerical variables such as opening price, closing price, and volume traded.
# Histogram of closing prices
ggplot(airbnb_stock, aes(x = Close)) +
  geom_histogram(binwidth = 10, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Airbnb Stock Closing Prices",
       x = "Closing Price", y = "Frequency")

#Boxplots: Identify outliers and compare the distribution of numerical variables across different categories (if applicable).
# Boxplot of closing prices by year
ggplot(airbnb_stock, aes(x = factor(year(Date)), y = Close)) +
  geom_boxplot(fill = "skyblue", color = "black") +
  labs(title = "Boxplot of Airbnb Stock Closing Prices by Year",
       x = "Year", y = "Closing Price")

# Correlation Analysis: Compute correlations between numerical variables to identify relationships.
cor_matrix <- cor(select(airbnb_stock, -Date))
cor_matrix

# Heatmap of correlations
ggplot(data = melt(cor_matrix), aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient(low = "skyblue", high = "red") +
  labs(title = "Correlation Heatmap", x = "", y = "")
