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
100.0* sum(case when ChurnStatus = 'Churned' then 1 else 0 end)/count(CustomerId) as percent_of_churned_customers
from CustomerDetails


ChurnRate by AgeGroup

select AgeGroup, count(CustomerId) as Totalcustomers,
sum(case when ChurnStatus = 'Churned' then 1 else 0 end) as no_of_churned,
100.0* sum(case when ChurnStatus = 'Churned' then 1 else 0 end)/count(CustomerId) as percent_of_churned_customers
from CustomerDetails
Group by AgeGroup

