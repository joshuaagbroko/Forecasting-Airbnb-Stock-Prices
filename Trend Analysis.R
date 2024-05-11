# loading required libraries
library(ggplot2)
library(tidyverse)


### Plotting closing prices over time 
## Time series plot of closing prices
ggplot(airbnb_stock, aes(x = Date, y = Close)) +
  geom_line() +
  labs(title = "Airbnb Stock Closing Prices Over Time",
       x = "Date", y = "Closing Price")


### Plotting Moving averages
# Calculate 30-day simple moving average (SMA)
airbnb_stock$SMA_30 <- SMA(airbnb_stock$Close, n = 30)

# Calculate 30-day exponential moving average (EMA)
airbnb_stock$EMA_30 <- EMA(airbnb_stock$Close, n = 30)

# Plot closing prices and moving averages
ggplot(airbnb_stock, aes(x = Date)) +
  geom_line(aes(y = Close), color = "blue", alpha = 0.5) +
  geom_line(aes(y = SMA_30), color = "red") +
  geom_line(aes(y = EMA_30), color = "green") +
  labs(title = "Airbnb Stock Closing Prices and Moving Averages",
       x = "Date", y = "Price") +
  scale_color_manual(values = c("blue", "red", "green"),
                     labels = c("Close", "SMA(30)", "EMA(30)")) +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold"),
        axis.title = element_text(size = 14),
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 10)) +
  annotate("text", x = as.Date("2023-01-01"), y = max(airbnb_stock$Close), 
           label = "Original Closing Prices (Blue)", color = "blue", size = 4) +
  annotate("text", x = as.Date("2023-01-01"), y = max(airbnb_stock$Close) - 5, 
           label = "30-day Simple Moving Average (Red)", color = "red", size = 4) +
  annotate("text", x = as.Date("2023-01-01"), y = max(airbnb_stock$Close) - 10, 
           label = "30-day Exponential Moving Average (Green)", color = "green", size = 4)