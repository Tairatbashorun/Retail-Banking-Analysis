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

