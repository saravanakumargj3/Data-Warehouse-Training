import pandas as pd
import numpy as np

#1: Load expense data from CSV
df = pd.read_csv('D:\\HEXAWARE PGET TRAINING\\DATA ENGINEERING\\Data-Warehouse-Training\\CAPSTONE\\Personal Expense Monitoring System\\Week 1\\expenses.csv')

#2: Clean and standardize formats
# Ensure amount is string for cleaning, then convert to float
if df['amount'].dtype != 'object':
    df['amount'] = df['amount'].astype(str)
# Remove currency symbols (₹, $) and commas, then convert to float
df['amount'] = df['amount'].replace(r'[\₹\$,]', '', regex=True).str.replace(',', '').astype(float)

# Handle invalid amounts (≤ 0)
invalid_amounts = df[df['amount'] <= 0]
if not invalid_amounts.empty:
    print("Warning: Found invalid amounts (≤ 0):")
    print(invalid_amounts[['user_id', 'category', 'amount', 'date', 'description']])
    df = df[df['amount'] > 0]  # Keep only positive amounts

# Standardize category names: trim whitespace and convert to title case
df['category'] = df['category'].str.strip().str.title()

# Convert date to datetime, handle invalid dates
df['date'] = pd.to_datetime(df['date'], errors='coerce')
invalid_dates = df[df['date'].isna()]
if not invalid_dates.empty:
    print("Warning: Found invalid dates:")
    print(invalid_dates[['user_id', 'category', 'amount', 'date', 'description']])
    #df = df.dropna(subset=['date']) # Drop rows with invalid dates

# Extract month-year period
df['month'] = df['date'].dt.to_period('M')

#₹ for output, better readability
df['amount_display'] = df['amount'].apply(lambda x: f'₹{x:,.2f}')

#3: Calculate monthly totals and averages
# Monthly totals by category
monthly_totals = df.groupby(['month', 'category'])['amount'].sum().unstack().fillna(0)
# Monthly averages by category
monthly_averages = df.groupby(['month', 'category'])['amount'].mean().unstack().fillna(0)

#4: Save deliverables
# Save cleaned dataset with amount_display
df.to_csv('cleaned_expenses.csv', index=False, columns=['user_id', 'category', 'amount_display', 'date', 'description', 'month'])
# Save monthly summaries
monthly_totals.to_csv('monthly_totals.csv')
monthly_averages.to_csv('monthly_averages.csv')

#5: Print category-wise breakdown
print("Monthly Totals by Category:")
print(monthly_totals)
print("\nMonthly Averages by Category:")
print(monthly_averages)