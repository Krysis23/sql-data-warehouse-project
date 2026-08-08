--find how many items sold
select sum(quantity) as  total_quanity from gold.fact_sales

--find the average  selling price
select avg(price) as  avg_price from gold.fact_sales

--find the total number of orders:
select count(order_number) as total_orders from gold.fact_sales
select count(distinct order_number) as  total_orders from gold.fact_sales

--find total number of products
select count(product_key) as total_orders from gold.dim_products
select count(distinct product_name) as total_products from gold.dim_products

--generate report  show all the key metrics  of the business

 select 'Total Sales' as measure_name, sum(sales_amount) as measure_value from gold.fact_sales
 union all
 select 'Total Quantity', sum(quantity) from gold.fact_sales
 union all
 select 'Average Price' , avg(price) from gold.fact_sales
 union all
 select 'Total Nr. of Orders', count(distinct order_number) from gold.fact_sales
 union all
 select 'Total Nr. of Products', count(product_name) from  gold.dim_products
 union all
 select 'Total Nr.  Customers', count(customer_key)	from gold.dim_customers



