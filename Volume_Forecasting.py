# TRANSACTION VOLUME FORECASTING (LINEAR REGRESSION)

import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression

# 1. Loading the aggregated SQL data (Mock data: 1 to 12 months)
data = {
    'Month_Index': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    'Total_Volume_INR': [50000, 52000, 54500, 58000, 61000, 63000, 67000, 71000, 75000, 78000, 82000, 85000]
}
df = pd.DataFrame(data)

# 2. Preparing the Statistical Regression Model
X = df[['Month_Index']] # Independent Variable (Time)
y = df['Total_Volume_INR'] # Dependent Variable (Money)

model = LinearRegression()
model.fit(X, y)

# 3. Forecasting the upcoming month (Month 13)
next_month = pd.DataFrame({'Month_Index': [13]})
forecasted_volume = model.predict(next_month)

# 4. Output the Business Insight
print("--- PhonePe Merchant Volume Forecast ---")
print(f"Historical Average Monthly Growth: ₹{model.coef_[0]:.2f} per month")
print(f"Projected Processing Volume for Month 13: ₹{forecasted_volume[0]:.2f}")
