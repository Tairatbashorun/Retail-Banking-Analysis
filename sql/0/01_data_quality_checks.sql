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
