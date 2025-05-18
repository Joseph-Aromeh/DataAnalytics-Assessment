# DataAnalytics-Assessment
An assessment to measure my ability to work with relational databases with SQL queries for solving business problems.


**Overview**

This repository contains a collection of SQL queries designed to provide critical business insights for financial product management, customer segmentation, and revenue optimization. The analytics suite addresses key business scenarios including cross-selling opportunities, transaction pattern analysis, account management, and customer lifetime value estimation.


### Business Scenarios
#### 1. High-Value Customers with Multiple Products 
Business Need: Identify customers who have both savings and investment plans to target cross-selling opportunities.

***Query Capabilities:***

Identifies customers with funded savings and investment plans
Calculates total deposits across all account types
Ranks customers by total deposit value

## Data Insights
*Chima Ataman has the highest total deposits (₦89B) despite having only 2 savings accounts
Opeoluwa Popoola has the most savings accounts (181)
Obi David has the most investment accounts (45)
All these users have both savings and investment accounts*

*They're sorted by total deposits in descending order*

*This suggests that Chima Ataman has fewer but higher-value accounts, while Opeoluwa Popoola has many smaller-value accounts.*


## Business Insights

**The Highest-value customers**: 

***Customer Value Segmentation:*** *Chima Ataman represents high-value customers (few accounts but largest deposits), while Opeoluwa Popoola represents high-engagement customers (many accounts but lower total value).*

***Investment vs. Savings Behavior:*** *There's variation in how customers allocate funds. Obi David and Opeoluwa Popoola heavily favor savings accounts, while Chima Ataman focuses on investments despite having larger deposits.*

***Revenue Potential:*** *If the business earns fees based on deposits, Chima Ataman and Obi David represent the most profitable customers despite having fewer total accounts than Opeoluwa.*

***Strategic Opportunities***

***Targeted Marketing: Different strategies could be developed for each segment:***

***High-value clients (Chima):*** *Focus on wealth management services*
***High-account clients (Opeoluwa):*** *Offer account consolidation or premium service tiers*
***Balanced clients (David dashme):*** *Cross-sell additional services*


***Product Development:***

*The ratio of savings to investments might suggest which products need enhancement to attract more deposits.*

***Risk Assessment***

*Concentration risk exists with a few customers controlling large portions of deposits
Customer retention strategies should prioritize high-deposit customers*

 

#### 2. Transaction Frequency Analysis 
Business Need: Segment customers based on transaction frequency to tailor marketing strategies and service offerings.


***Query Breakdown***

*First creates a CTE (monthly_transactions) that counts transactions per user per month
Then creates another CTE (user_frequency) that:
Calculates average monthly transactions for each user
Categorizes users into frequency segments*

*Then aggregates data by frequency category*

## Business Insights

***Customer Activity Distribution:****

![image](https://github.com/user-attachments/assets/45fb5a07-1073-4e67-93e8-d3c8609caf2f)


*This follows a classic Pareto-like distribution pattern*


***Engagement Analysis:***

*High-frequency users are extremely active with 44.7 transactions per month which means they make and average of 1.5 transactions daily
There's a substantial drop-off between tiers 44.7 for the most frequent customers, 4.7 for mid frequent customers, 1.3 for low frequent customers

***Opportunities:***

*Target medium-frequency users for conversion to high-frequency*
*Investigate why low-frequency users aren't more engaged*
*Design retention strategies for the valuable high-frequency segment*

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


Target cross-selling based on existing product relationships

Detect churn risks through inactivity identification

Segment customers for personalized marketing campaigns

Measure customer lifetime value for acquisition ROI calculations


## Maintenance
These queries should be reviewed quarterly to ensure:

Compatibility with any schema changes

Alignment with current business metrics and KPIs

Optimization for performance as database size grows
