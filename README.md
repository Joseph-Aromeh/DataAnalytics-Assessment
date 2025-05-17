# DataAnalytics-Assessment
An assessment to measure my ability to work with relational databases with SQL queries for solving business problems.

## Financial Analytics SQL Repository
**Overview**

This repository contains a collection of SQL queries designed to provide critical business insights for financial product management, customer segmentation, and revenue optimization. The analytics suite addresses key business scenarios including cross-selling opportunities, transaction pattern analysis, account management, and customer lifetime value estimation.

### Business Scenarios
#### 1. High-Value Customers with Multiple Products 
Business Need: Identify customers who have both savings and investment plans to target cross-selling opportunities.

***Query Capabilities:***
Identifies customers with funded savings and investment plans
Calculates total deposits across all account types
Ranks customers by total deposit value
Enables targeted marketing for existing high-value customers

#### 2. Transaction Frequency Analysis 
Business Need: Segment customers based on transaction frequency to tailor marketing strategies and service offerings.

***Query Capabilities:***
Calculates average transactions per customer per month

*Segments customers into:*
High Frequency (≥10 transactions/month)
Medium Frequency (3-9 transactions/month)
Low Frequency (≤2 transactions/month)

Provides count of customers in each segment
Reveals typical transaction frequency within segments

#### 3. Account Inactivity Alert
Business Need: Proactively identify and re-engage customers with dormant accounts before potential churn.

***Query Capabilities:***
Identifies active accounts with no transaction activity in the past year
Works across both savings and investment accounts
Calculates days since last transaction
Enables targeted re-engagement campaigns

#### 4. Customer Lifetime Value (CLV) Estimation 
Business Need: Estimate long-term value of customer relationships to prioritize retention efforts and acquisition spending.

***Query Capabilities:***
Calculates account tenure in months
Counts total transactions per customer
Estimates CLV based on transaction frequency and average profit
Ranks customers by estimated lifetime value

### Technical Implementation
Database Schema
***The queries utilize the following tables:***

**users_customuser:** Customer profile information
**savings_savingsaccount:** Transaction details and account balances
**plans_plan:** Product enrollment and account type information

#### Key Metrics Definitions

**Savings Plan:** Identified by is_regular_savings = 1
**Investment Plan:** Identified by is_a_fund = 1
**Transaction Amount:** Stored in kobo (divide by 100 for currency value)
**Profit per Transaction:** Calculated as 0.1% of transaction value
**Customer Tenure:** Months between signup date and current date
**Account Inactivity:** No transactions for 365+ days

## Usage Guidance
#### Prerequisites

**SQL database access (MySQL/MariaDB)** 
Appropriate permissions to query the tables

***Running the Queries***

**Connected to the database using MySQL client**
**Copy the query for my the expected analysis**
**Execute the query against the database**
**Export results as needed (CSV, Excel, etc.)**


## Data Insights
**The SQL queries in this repository enable stakeholders to:**

Identify highest-value customers for retention prioritization
Target cross-selling based on existing product relationships
Detect churn risks through inactivity identification
Segment customers for personalized marketing campaigns
Measure customer lifetime value for acquisition ROI calculations

## Maintenance
These queries should be reviewed quarterly to ensure:

Compatibility with any schema changes
Alignment with current business metrics and KPIs
Optimization for performance as database size grows
