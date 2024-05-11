
# Preparing data in Prophet format
# loading required libraries
library(ggplot2)
library(prophet)
library(tidyverse)

#### Convert 'Date' column to a time series object

data_prophet <- data.frame(ds = airbnb_stock$Date, y = airbnb_stock$Close)

# Fitting Prophet model
prophet_model <- prophet(data_prophet)

# Making future dataframe for forecasting (i.e., next 365 days)
future <- make_future_dataframe(prophet_model, periods = 365)

# Forecast future values
prophet_forecast <- predict(prophet_model, future)

# Convert forecast data to a dataframe
prophet_forecast_df <- data.frame(ds = prophet_forecast$ds, yhat = prophet_forecast$yhat, yhat_lower = prophet_forecast$yhat_lower, yhat_upper = prophet_forecast$yhat_upper)
prophet_forecast_df$ds <- as.Date(prophet_forecast_df$ds)

# Plot historical data and forecast with prediction intervals using ggplot2
ggplot() +
  geom_line(data = airbnb_stock, aes(x = Date, y = Close), color = "blue") +
  geom_line(data = prophet_forecast_df, aes(x = ds, y = yhat), color = "red") +
  geom_ribbon(data = prophet_forecast_df, aes(x = ds, ymin = yhat_lower, ymax = yhat_upper), fill = "pink", alpha = 0.3) +
  labs(title = "Forecasted Airbnb Stock Prices",
       x = "Date", y = "Closing Price") +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold"),
        axis.title = element_text(size = 14))



## Evaluation of the forecasted model 
# Calculate evaluation metrics
prophet_mae <- mean(abs(prophet_forecast_df$yhat - airbnb_stock$Close))
prophet_mse <- mean((prophet_forecast_df$yhat - airbnb_stock$Close)^2)
prophet_rmse <- sqrt(mean((prophet_forecast_df$yhat - airbnb_stock$Close)^2))
prophet_mape <- mean(abs((prophet_forecast_df$yhat - airbnb_stock$Close) / airbnb_stock$Close)) * 100

