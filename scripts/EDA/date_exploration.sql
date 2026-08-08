-- first date and last date of order, how many years sales  are available
select
Min(order_date)  as first_order_date,
Max(order_date) as last_order_date,
datediff(month,min(order_Date),max(order_date)) as order_range_months
from gold.fact_sales


--find youngest and oldest customer
select
min(birthdate) as oldest_birthdate,
datediff(year,min(birthdate), getdate()) as oldest_age,
datediff(year,max(birthdate), getdate()) as youngest_age,
max(birthdate) as youngest_birthdate
from gold.dim_customers
