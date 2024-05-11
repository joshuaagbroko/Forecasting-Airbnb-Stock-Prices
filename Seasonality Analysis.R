
# loading required libraries
library(tidyverse)
library(ggplot2)

#Seasonality analysis involves identifying and analyzing recurring patterns or fluctuations in a dataset that occur at regular intervals, such as daily, weekly, monthly, or yearly cycles. In the context of Airbnb stock data, seasonality analysis can help us understand if there are any consistent seasonal trends in stock prices.

### Visualizing Seasonal Patterns:
#We'll Start by visualizing the average closing prices for each day of each month and each quarter to identify any recurring patterns.

#### Extracting the month from Date

airbnb_stock$Month <- month(airbnb_stock$Date, label = TRUE)

# Calculating the average closing prices for each month
avg_price_by_month <- airbnb_stock %>% 
  group_by(Month) %>% 
  summarize(Avg_Close = mean(Close, na.rm = TRUE))

# Plotting the average closing prices by month
ggplot(avg_price_by_month, aes(x = Month, y = Avg_Close, fill = Month)) +
  geom_bar(stat = "identity", width = 0.7) +
  labs(title = "Average Airbnb Stock Closing Prices by Month",
       x = "Month", y = "Average Closing Price") +
  scale_fill_manual(values = rep(c("#FF9900", "#FF9900", "#FF9900", "#FF9900", "#FF9900", "#FF9900", "#FF9900", "#FF9900", "#FF9900", "#FF9900", "#FF9900", "#FF9900"), 2),
                    guide = FALSE) +  # Custom color palette for months
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold"),
        axis.title = element_text(size = 14),
        axis.text.x = element_text(angle = 45, hjust = 1))


# Extract quarter from Date
airbnb_stock$Quarter <- quarter(airbnb_stock$Date)

# Calculate average closing prices for each quarter

avg_price_by_quarter <- airbnb_stock %>% 
  group_by(Quarter) %>% 
  summarize(Avg_Close = mean(Close, na.rm = TRUE))

# Plot average closing prices by quarter
ggplot(avg_price_by_quarter, aes(x = factor(Quarter), y = Avg_Close, fill = factor(Quarter))) +
  geom_bar(stat = "identity", width = 0.7) +
  labs(title = "Average Airbnb Stock Closing Prices by Quarter",
       x = "Quarter", y = "Average Closing Price") +
  scale_fill_manual(values = rep(c("#3366CC", "#DC3912", "#FF9900", "#109618"), 2),
                    guide = FALSE) +  # Custom color palette for quarters
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold"),
        axis.title = element_text(size = 14),
        axis.text.x = element_text(angle = 0, hjust = 0.5))
