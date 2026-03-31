# Bank Customer Churn Analysis

## Project Overview
This project analyzes customer churn behavior in a banking dataset to identify high-risk customer segments and key factors influencing customer attrition. The analysis helps stakeholders design targeted retention strategies.

## Business Problem
Customer churn directly impacts revenue. The objective was to identify why customers leave and detect patterns across demographics, engagement, and product usage.

## Tools & Technologies
- Excel – Data Cleaning & Exploratory Analysis
- SQL Server – Data Analysis & KPI Calculation
- Power BI – Dashboard & Visualization
- DAX – Measures & KPI creation

## Key KPIs
- Total Customers: 10,000
- Total Churned Customers: 2,037
- Churn Rate: 20.37%
- Active Customers: 5,151
- Average Balance: 76.47K

## Dashboard
[Dashboard](images/dashboard.png)

## Key Insights
- Germany has the highest churn rate (~32%) compared to other regions
- Senior customers show significantly higher churn (~44%)
- Customers with 3–4 products demonstrate higher churn risk
- Mid and Old tenure customers churn around 20%
- Inactive customers churn more than active customers
- Overall churn rate is 20.37%

## Business Recommendations
- Focus retention campaigns on high-risk regions like Germany
- Improve engagement for inactive customers
- Promote multi-product usage to increase stickiness
- Introduce loyalty programs for senior customers

## Project Workflow
1. Data Cleaning and preprocessing using Excel
2. Data analysis and KPI calculation using SQL Server
3. Dashboard development and visualization in Power BI
4. Business insights generation and interpretation

## Project Structure
bank-customer-churn-analysis/
│
├── data/
│   └── BankChurn.csv
│
├── excel/
│   └── BankChurn_EDA.xlsx
│
├── sql/
│   └── churn_analysis.sql
│
├── powerbi/
│   └── Bank_Churn_Dashboard.pbix
│
├── images/
│   └── dashboard.png
│
└── README.md

## Business Impact
This analysis helps identify high-risk customers and enables data-driven retention strategies to reduce churn and improve customer engagement.

## Author
Data Analyst Project – Bank Customer Churn Analysis
