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

![image](https://github.com/user-attachments/assets/03c59faa-02b3-4978-84c8-8256cc0b4b1d)

*Chima Ataman has the highest total deposits, ***89031221548.43355*** (₦89B) despite having only 2 savings accounts
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

**Business Need:** Segment customers based on transaction frequency to tailor marketing strategies and service offerings.

***Query Breakdown***

*First creates a CTE (monthly_transactions) that counts transactions per user per month
Then creates another CTE (user_frequency) that:
Calculates average monthly transactions for each user
Categorizes users into frequency segments*

*Then aggregates data by frequency category*

## Business Insights

***Customer Activity Distribution:***

![image](https://github.com/user-attachments/assets/45fb5a07-1073-4e67-93e8-d3c8609caf2f)

*This follows a classic Pareto-like distribution pattern*

***Engagement Analysis:***

*High-frequency users are extremely active with 44.7 transactions per month which means they make and average of 1.5 transactions daily
There's a substantial drop-off between tiers 44.7 for the most frequent customers, 4.7 for mid frequent customers, 1.3 for low frequent customers*

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

*First, it identifies the last transaction date for each plan using a CTE
Then it selects plans that:*

*Have a positive balance (confirmed_amount > deduction_amount)
Have either no transaction date OR haven't had a transaction in 365+ days*

*It orders results by the longest period of inactivity*

***Data Insights***

![image](https://github.com/user-attachments/assets/5ca296cd-6d5e-4b73-a0f2-e79b7adf48c7)

***Business Implications:***

***Dormant Funds:*** *You have savings accounts with positive balances that haven't been touched in over 8 years (3136 days)!*
***Account Type Pattern:*** *The oldest inactive accounts are all Savings accounts, while more recent inactive accounts are classified as "Other" (not Savings or Investment)*
***Potential Lost Customers:*** *The top 5 accounts haven't had activity in over 4 years, suggesting these customers may have abandoned their accounts*
***Risk Assessment:*** *These dormant accounts represent potential financial liabilities and regulatory concerns depending on your jurisdiction's laws about unclaimed funds*

***Revenue Opportunity: A re-engagement campaign targeting these customers could either:***

*Convert dormant funds into active accounts
Lead to account closure and fee collection
Free up these funds for more productive use*

#### 4. Customer Lifetime Value (CLV) Estimation 
Business Need: Estimate long-term value of customer relationships to prioritize retention efforts and acquisition spending.

***Query Capabilities:***

Calculates account tenure in months
Counts total transactions per customer
Estimates CLV based on transaction frequency and average profit
Ranks customers by estimated lifetime value

***Data Insights***

![image](https://github.com/user-attachments/assets/2693c057-4d4d-47e7-8a52-e1b33a4055d8)

**High-Value Champions:** *Chima Ataman generates the highest CLV (₦32.3M) despite a moderate tenure of 33 months. This indicates extremely high-value transactions.*
**Transaction Volume vs. Value:** *Obi David has the most transactions (10,548) and longest tenure (72 months), but ranks third in CLV. This suggests frequent but lower-value transactions.*
**Efficiency Anomaly:** *"First name" has only 5 transactions in 10 months but ranks fourth in CLV (₦6M). This indicates extremely high-value but infrequent transactions.*

**Engagement Patterns: The formula reveals that CLV is driven by:**

*Transaction frequency (monthly rate * 12)
Average transaction value (sum/count)
Revenue percentage (0.1% assumed)*


***Business Implications:***

*Chima Ataman represents over 3x the value of your second-highest customer
The top 5 customers likely represent a significant portion of total revenue
Like a pyramid, your business has a few extremely valuable customers at the top*



*This analysis suggests focusing retention efforts on high-CLV customers while developing strategies to increase transaction values or frequency for others.*

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


## Maintenance
These queries should be reviewed quarterly to ensure:

Compatibility with any schema changes

Alignment with current business metrics and KPIs

Optimization for performance as database size grows
