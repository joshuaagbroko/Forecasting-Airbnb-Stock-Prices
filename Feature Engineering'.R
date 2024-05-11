### Date features
#### Converting 'Date' column to Date format

airbnb_stock$Date <- as.Date(airbnb_stock$Date)

#### Extracting year, month, quarter, and day of the week
airbnb_stock$Year <- year(airbnb_stock$Date)
airbnb_stock$Month <- month(airbnb_stock$Date)
airbnb_stock$Quarter <- quarter(airbnb_stock$Date)
airbnb_stock$DayOfWeek <- weekdays(airbnb_stock$Date)

### Lag features
#### Create lagged features for closing prices and volume
airbnb_stock$Lag1_Close <- lag(airbnb_stock$Close)
airbnb_stock$Lag2_Close <- lag(airbnb_stock$Close, 2)
airbnb_stock$Lag1_Volume <- lag(airbnb_stock$Volume)
airbnb_stock$Lag2_Volume <- lag(airbnb_stock$Volume, 2)

### Rolling Statistics
#### Calculate rolling mean of closing prices over a 7-day window
airbnb_stock$Rolling_Mean_Close <- rollmean(airbnb_stock$Close, k = 7, fill = NA)
#### Calculate rolling standard deviation of closing prices over a 7-day window
airbnb_stock$Rolling_SD_Close <- rollapply(airbnb_stock$Close, width = 7, FUN = sd, fill = NA)


### Price Differences
#### Calculate price difference between today's closing price and yesterday's closing price
airbnb_stock$Price_Diff <- c(NA, diff(airbnb_stock$Close))

### Percentage Changes 
# Calculating percentage change in closing price from the previous day
airbnb_stock <- airbnb_stock %>%
  mutate(Percent_Change = c(NA, diff(Close) / lag(Close))[-1])

### moving Averages
#### Calculate simple moving average of closing prices over a 7-day window
airbnb_stock$SMA_7 <- SMA(airbnb_stock$Close, n = 7)

#### Calculate exponential moving average of closing prices over a 7-day window
airbnb_stock$EMA_7 <- EMA(airbnb_stock$Close, n = 7)

### seasonal dummy variables 
#### Creating dummy variables for quarters (example)
airbnb_stock$Q1 <- ifelse(airbnb_stock$Quarter == 1, 1, 0)
airbnb_stock$Q2 <- ifelse(airbnb_stock$Quarter == 2, 1, 0)
airbnb_stock$Q3 <- ifelse(airbnb_stock$Quarter == 3, 1, 0)
airbnb_stock$Q4 <- ifelse(airbnb_stock$Quarter == 4, 1, 0)
