# Retail-Banking-Customer-churn and Retention pattern

  
### Project Overview

- Analyzing Customer Churn and Retention Patterns in a UK-Based Multinational Retail Bank
- This project analyses customer and financial data from a retail banking institution to identify customer behavior,financial performance - - - product usage, performance trends and key banking KPIs. The analysis uses SQL and Power BI to identify trends and generate insights that could support data-driven decision-making.

<img width="1366" height="768" alt="Screenshot (8)" src="https://github.com/user-attachments/assets/d67a23fa-cc59-405b-9376-61afc6191fcc" />


### Data sources
The primary data used for this project


### Business problem
The bank is experiencing increased customer churn due to:
- Intensifying competition from fintech and neobanks
- Reduced customer engagement in Germany and France
- Limited behavioral-based customer segmentation
- Absence of real-time churn monitoring and proactive retention models

### Project Objectives

- Identifying common characteristics among churned customers

- Comparing churn behavior across the UK, Germany, and France

- Segmentation of  customers based on churn risk and engagement levels

- Visualizing key churn metrics for executive decision-making

- Supporting targeted retention and customer engagement strategies
- 

### Technology stack:

Microsoft SQL Server- Data importation and preparation 
[Download Here](https://microsoft.com)

Microsoft PowerBi - Creating reports


### Database setup and data importation

 = Veritas bank database was set up using SQL Server 
 
 
### Data quality checks

   - Checking for duplicates, missing values, null values and outliers
  
  
  ### Exploratory Data Analysis
  
  EDA involved exploring data to provide solutions key business problems such:

  The bank is experiencing increased customer churn due to:
    - Intensifying competition from fintech and neo banks
    - Reduced customer engagement in Germany and France
    - Limited behavioral-based customer segmentation
    - Absence of real-time churn monitoring and proactive retention models

### Feature engineering and churn-related column derivation

```sql


Create View ChurnRisklevel as
select CustomerId, Country, AgeGroup, CreditScoreCat, BalanceCat, ActiveStatus, ChurnStatus,
TenureCat,  ProductsCat,
Case when CreditScoreCat in ('Poor', 'Fair')
AND BalanceCat = 'Very Low'
AND ProductsCat = 'Low Engagement'
AND TenureCat = 'New'
then 'High Risk'

When(CreditScoreCat IN ('Poor', 'Fair') AND BalanceCat IN ('VeryLow', 'Low'))
OR (CreditScoreCat IN ('Poor','Fair') AND ProductsCat = 'Low Engagement')
OR (BalanceCat IN ('Very Low', 'Low') AND ProductsCat = 'Low Enagement')
then 'Elevated Risk'

When ProductsCat = 'Moderate' OR TenureCat = 'Established'
then 'Moderate Risk'

else 'Low Risk'
End as ChurnRisk
From CustomerDetails
```

### Data Analysis

####column Distribution

``` sql
Number of churn in each country

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

- Total customers
No of customers who have churned
Percentage number of customers who have churned=
Number of customers who have churned/Total number of customers *100/1

Total customers
select count(CustomerId) as Total_customers
from CustomerDetails

 Number of customers who have churned
 select count(CustomerId) as Total_customers,
sum(case when ChurnStatus = 'churned' then 1 else 0 end) as No_of_churned
from CustomerDetails

percent of churned customers
select count(CustomerId) as Total_customers,
sum(case when ChurnStatus = 'churned' then 1 else 0 end) as No_of_churned,
100* sum(case when ChurnStatus = 'Churned' then 1 else 0 end)/count(CustomerId) as percent_of_churned_customers
from CustomerDetails

ChurnRate by AgeGroup

select AgeGroup, count(CustomerId) as Totalcustomers,
sum(case when ChurnStatus = 'Churned' then 1 else 0 end) as no_of_churned,
100 * sum(case when ChurnStatus = 'Churned' then 1 else 0 end)/count(CustomerId) as percent_of_churned_customers
from CustomerDetails
Group by AgeGroup
```

### Insights
- Churn rate by country: Germany has customers with the highest risk of churning.
- The bank has more male customers than female
- The young adults and middle- aged adults have the highest number in the age group
- The customers without credit cards are more likely to churn due to low balance
-  High balance held by customers alone does not guarantee loyalty. Customers may switch provider if they perceive better value     elsewhere.
- Dissatisfaction may exist  despite high-deposits, If the quality of service or product falls below expectation even high-value      customers may choose to leave.

  ### Recommendations

   -Survey and feedback tools: Regular customer feedback through surveys and touchpoints can provide direct insight,  potential churn       causes such as service issues, fees, or better offers elsewhere.
  - Adopt predictive, data –driven approaches to customer retention, moving beyond traditional metric to analyze digital behavior,         transaction sequences, complaint logs and customer sentiment.
  - Introduce loyalty incentives to customers with high-balance
  - Deploy personalized product offers based on behavior.
   
  


    
z










