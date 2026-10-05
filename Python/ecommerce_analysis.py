
import os
import pandas as pd
import mysql.connector
from dotenv import load_dotenv

load_dotenv()

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password=os.getenv("MYSQL_PASSWORD"),
    database="Amazon"
)
df_monthly=pd.read_sql("select * from vw_monthly_revenue",conn)
print(df_monthly)
print(df_monthly.head())
print(df_monthly.shape)
print(df_monthly.info())
print(df_monthly.describe())

#data quality check
print("Missing data")
print(df_monthly.isnull().sum())

print("\nDuplicate values")
print(df_monthly.duplicated().sum())
print(df_monthly[df_monthly["revenue"]<=0])

print(df_monthly.sort_values(by="revenue",ascending=False)[["year","month","revenue"]].head(1))

print(df_monthly["revenue"].sum())
print(df_monthly["revenue"].mean())

highest=df_monthly["revenue"].idxmax()
print(df_monthly.loc[highest])

#category performance view
df_category=pd.read_sql("select * from vw_category_performance",conn)
print(df_category.head())
print(df_category.info())

#which category generate highest revenue
print(df_category.sort_values(by='revenue',ascending=False)[["category_name","revenue"]])

#which category has highest profit
print(df_category.sort_values(by="profit",ascending=False)[["category_name","profit"]])
#new column
df_category["profit_margin"]=df_category["profit"]/df_category["revenue"]*100
print(df_category)
print(df_category.sort_values(by="profit_margin",ascending=False)[["category_name","profit_margin"]])

top_5=df_category.nlargest(5,"profit")
print(top_5[["category_name","profit"]])

import matplotlib.pyplot as plt

#Which categories generate the most revenue?
df_plot=df_category.sort_values(by="revenue",ascending=False)
plt.figure(figsize=(10,5))

plt.bar(df_category["category_name"],df_category["profit_margin"])

plt.xticks(rotation=45,ha='right')
plt.xlabel("Category")
plt.ylabel("revenue")
plt.title("Revenue by category")

plt.tight_layout()
plt.show()
