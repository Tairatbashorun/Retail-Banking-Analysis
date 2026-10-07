Select * from CustomerInfo

Select * from AccountInfo

Select CustomerId,LastName from CustomerInfo

checking for duplicate
select CustomerId, Count(CustomerId)
From CustomerInfo
Group BY CustomerId
Having Count(CustomerId) > 1

select CustomerId, count(CustomerId)
from AccountInfo
group by CustomerId
Having count(CustomerId) > 1

check for null values in customerInfo


select
SUM(case when CustomerId is null then 1 else 0 end) as cust_null,
SUM(case when LastName is null then 1 else 0 end) as LN_null,
SUM(case when Country is null then 1 else 0 end) as ctry_null,
SUM(case when Gender is null then 1 else 0 end) as gender_null,
SUM(case when Age is null then 1 else 0 end) as age_null
From CustomerInfo

check for null value in AccountInfo

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

Preliminary EDA

No of Records

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



Column Distribution

18 -25 Young Adults, 36 - 45 Middle Aged Adults, 46 - 55 Pre Older Adult, 56 - 65 Old Adults

Alter Table CustomerInfo
Add Agegroup as
Case
When Age between 18 and 35 then 'Young Adult'
when Age between 36 and 45 then 'Middle Aged Adults'
when Age between 46 and 55 then 'Pre Older Adults'
else 'Older Adults'
end

Alter Table AccountInfo 
ADD
ChurnStatus VARCHAR(40),
AcvtivitiesStatus VARCHAR(40),
Balancecat VARCHAR(40),
CreditScorecat VARCHAR(40),
Tenurecat VARCHAR(40),
ProductsCat VARCHAR(40)



select* from AccountInfo
ALTER THE COLUMN

UPDATE AccountInfo
Set
ChurnStatus = case
when Exited = 1 then 'Churned'
when Exited = 0 then 'Not churned'
else 'Unknown'
end,

ActiveStatus = Case
when ActiveMember = 1 then 'Active'
when ActiveMember = 0 then 'Inactive'
else 'Unknown'
end,

BalanceCat = case
when Balance <= 30000 then 'Very low'
when Balance between 30001 and 50000 then 'Low'
when Balance between 50001 and 80000 then 'Mid'
else 'High'
end,

CreditScoreCat = case
when CreditScore <= 580 then 'poor'
when CreditScore between 581 and 669 then 'Fair'
when CreditScore between 670 and 739 then 'Good'
when CreditScore between 740 and 799 then 'Very Good'
when CreditScore between 800 and 850 then 'Excellent'
else 'Out of range'
end,

TenureCat = case
when Tenure <=2 then 'New'
when Tenure between 3 and 5 then 'Established'
Else 'loyal'
end,

ProductsCat = case
when Products <=1 then 'Low engagement'
when Products <= 2 then 'Moderate'
else 'High Engagement'
end

Alter Table AccountInfo
Drop Column ActivitiesStatus

select * from AccountInfo

Create view CustomerDetails as
select
a . ChurnStatus,
a. BalanceCat,
a. ActiveStatus,
a. CreditScore,
a.TenureCat,
a.ProductsCat,
c.CustomerId,
c. LastName,
c. Country,
c.Gender,
c.Age,
c.AgeGroup
From AccountInfo as a left join CustomerInfo as c
on a.CustomerId = C.CustomerId

Drop view CustomerDetails 

create view CustomerDetails as
select
a . ChurnStatus,
a. BalanceCat,
a. ActiveStatus,
a. CreditScore,
a.TenureCat,
a.ProductsCat,
c.CustomerId,
c. LastName,
c. Country,
c.Gender,
c.Age,
c.AgeGroup
From AccountInfo as a left join CustomerInfo as c
on a.CustomerId = C.CustomerId

Drop view CustomerDetails 

Create view CustomerDetails as
select
a . ChurnStatus,
a. BalanceCat,
a. ActiveStatus,
a. CreditScoreCat,
a.TenureCat,
a.ProductsCat,
c.CustomerId,
c. LastName,
c. Country,
c.Gender,
c.Age,
c.AgeGroup
From AccountInfo as a left join CustomerInfo as c
on a.CustomerId = C.CustomerId



select * from CustomerDetails



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

Deep Dive Analysis

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











-


































