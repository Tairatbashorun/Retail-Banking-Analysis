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
AcvtiveStatus VARCHAR(40),
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

create view CustomerDetails as
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



