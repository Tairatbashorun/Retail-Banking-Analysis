# Retail-Banking-Customer-churn and Retention pattrrn
Analyzing Customer Churn and Retention Patterns in a UK-Based Multinational Retail Bank
This project analyses customer and financial data from a retail banking institution to identify customer behavior,financial performance product usage, performance trends and key banking KPIs. The analysis uses SQL and Power BI to identify trends and generate insights that could support data-driven decision-making.

Business problem
The bank is experiencing increased customer churn due to:
Intensifying competition from fintech and neobanks
Reduced customer engagement in Germany and France
Limited behavioral-based customer segmentation
Absence of real-time churn monitoring and proactive retention models

Project Objectives
Identifying common characteristics among churned customers

Comparing churn behavior across the UK, Germany, and France

Segmentation of  customers based on churn risk and engagement levels

Visualizing key churn metrics for executive decision-making

Supporting targeted retention and customer engagement strategies

Technology stack:
Microsoft SQL Server
Microsoft PowerBI

SQL Analysis

SQL Server was used to clean, transform and analyse the data.

The analysis covered:

- Data exploration
Select * from CustomerInfo

Select * from AccountInfo

Select CustomerId,LastName from CustomerInfo

- Data quality checks
- 
- checking for duplicates- Customer info
- 
select CustomerId, Count(CustomerId)
From CustomerInfo
Group BY CustomerId
Having Count(CustomerId) > 1

Checking for duplicates- Account info

select CustomerId, count(CustomerId)
from AccountInfo
group by CustomerId
Having count(CustomerId) > 1

checking for missing values - Customer info
check for null values in customer info
select
SUM(case when CustomerId is null then 1 else 0 end) as cust_null,
SUM(case when LastName is null then 1 else 0 end) as LN_null,
SUM(case when Country is null then 1 else 0 end) as ctry_null,
SUM(case when Gender is null then 1 else 0 end) as gender_null,
SUM(case when Age is null then 1 else 0 end) as age_null
From CustomerInfo

Checking for missing values - Account info
Select * from AccountInfo

select 
SUM (case when CustomerId is null then 1 else 0 end) as cust_nulL,
SUM(case when CreditScore is null then 1 else 0 end) as CS_null,
SUM(case when Tenure is null then 1 else 0 end) as ten_null,
SUM(case when Balance is null then 1 else 0 end) as bal_null,
SUM(case when Products is null then 1 else 0 end) as prod_null,
SUM(case when CreditCard is null then 1 else 0 end) as cc_null,
SUM(case when ActiveMember is null then 1 else 0 end) as am_null,
SUM(case when Exited is null then 1 else 0 end) as Exit_null
from AccountInfo

Range checks
Check for outliers
MIN & MAX Age

select MIN(Age) as min_age, MAX(Age) as max_age, AVG(Age) as avg_age

from CustomerInfo

MIN & MAX CreditScore

Select
MIN(CreditScore) as min_cs, MAX(CreditScore) as max_cs, AVG(CreditScore) as avg_cs

from AccountInfo 

select
Min(Balance) as min_bal, Max(Balance) as max_bal, Avg(Balance) as avg_bal
from AccountInfo

Check for Negative Balance

select CustomerId, Balance
from AccountInfo
Where Balance < 0

Exploratory Data Analysis

Record counts

Select count(*) from CustomerInfo

Select count(*) from AccountInfo


Number of customers in each country

select country, count(CustomerId) as no_of_customers
from CustomerInfo
group by Country
order by count(CustomerId) 


Distribution of Gender

Select Gender, count (CustomerId) as no_of_customers
from CustomerInfo
group by Gender


Churn Distribution

Select Exited, count(CustomerId) as no_0f_customers
from AccountInfo
group by Exited


Active Distribution

Select ActiveMember, count(CustomerId) as no_of_customers 
from AccountInfo
group by ActiveMember

Data Transformation
UPDATE AccountInfo
SET
    ChurnStatus =
        CASE
            WHEN Exited = 1 THEN 'Churned'
            WHEN Exited = 0 THEN 'Not Churned'
            ELSE 'Unknown'
        END,

    ActiveStatus =
        CASE
            WHEN ActiveMember = 1 THEN 'Active'
            WHEN ActiveMember = 0 THEN 'Inactive'
            ELSE 'Unknown'
        END,

    BalanceCat =
        CASE
            WHEN Balance <= 30000 THEN 'Very Low'
            WHEN Balance BETWEEN 30001 AND 50000 THEN 'Low'
            WHEN Balance BETWEEN 50001 AND 80000 THEN 'Mid'
            ELSE 'High'
        END,

    CreditScoreCat =
        CASE
            WHEN CreditScore <= 580 THEN 'Poor'
            WHEN CreditScore BETWEEN 581 AND 669 THEN 'Fair'
            WHEN CreditScore BETWEEN 670 AND 739 THEN 'Good'
            WHEN CreditScore BETWEEN 740 AND 799 THEN 'Very Good'
            WHEN CreditScore BETWEEN 800 AND 850 THEN 'Excellent'
            ELSE 'Out of Range'
        END,

    TenureCat =
        CASE
            WHEN Tenure <= 2 THEN 'New'
            WHEN Tenure BETWEEN 3 AND 5 THEN 'Established'
            ELSE 'Loyal'
        END,

    ProductsCat =
        CASE
            WHEN Products <= 1 THEN 'Low Engagement'
            WHEN Products <= 2 THEN 'Moderate'
            ELSE 'High Engagement'
        END;


        CREATE CUSTOMER DETAIL VIEW

        CREATE VIEW CustomerDetails AS

SELECT
    a.ChurnStatus,
    a.BalanceCat,
    a.ActiveStatus,
    a.CreditScoreCat,
    a.TenureCat,
    a.ProductsCat,
    c.CustomerId,
    c.LastName,
    c.Country,
    c.Gender,
    c.Age,
    c.AgeGroup

FROM AccountInfo AS a

LEFT JOIN CustomerInfo AS c
    ON a.CustomerId = c.CustomerId;



    CHURN-RISL LEVEL

    CREATE VIEW ChurnRiskLevel AS
elect CustomerId, Country, AgeGroup, CreditScoreCat, BalanceCat, ActiveStatus, ChurnStatus,
TenureCat,  ProductsCat,

    CASE when CreditScoreCat IN ('Poor', 'Fair')
             AND BalanceCat = 'Very Low'
             AND ProductsCat = 'Low Engagement'
             AND TenureCat = 'New'
        THEN 'High Risk'

        
When(CreditScoreCat IN ('Poor', 'Fair') AND BalanceCat IN ('VeryLow', 'Low'))
OR (CreditScoreCat IN ('Poor','Fair') AND ProductsCat = 'Low Engagement')
OR (BalanceCat IN ('Very Low', 'Low') AND ProductsCat = 'Low Enagement')
then 'Elevated Risk'

        WHEN ProductsCat = 'Moderate'
             OR TenureCat = 'Established'
        THEN 'Moderate Risk'
        ELSE 'Low Risk'
       END AS ChurnRisk
      FROM CustomerDetails;

DEEP DIVE ANALYSIS
CHURN ANALYSIS
NUMBER OF CHURN IN EACH COUNTRY

select Country, count(CustomerId) as no_of_churned_customers
from CustomerDetails
where ChurnStatus = 'churned'
Group by Country
Order by count(CustomerId) DESC

Number of Churn in each Country and Gender
select Country, Gender, count(CustomerId) as no_of_churned_customers
from CustomerDetails
where ChurnStatus = 'Churned'
Group by Country, Gender 
Order by Country, Gender, count(CustomerId) DESC


Overall Churn Rate
ercent of churned customers
select count(CustomerId) as Total_customers,
sum(case when ChurnStatus = 'churned' then 1 else 0 end) as No_of_churned,
100.0* sum(case when ChurnStatus = 'Churned' then 1 else 0 end)/count(CustomerId) as percent_of_churned_customers
from CustomerDetails

ChurnRate by AgeGroup

select AgeGroup, count(CustomerId) as Totalcustomers,
sum(case when ChurnStatus = 'Churned' then 1 else 0 end) as no_of_churned,
100 * sum(case when ChurnStatus = 'Churned' then 1 else 0 end)/count(CustomerId) as percent_of_churned_customers
from CustomerDetails
Group by AgeGroup


- 

