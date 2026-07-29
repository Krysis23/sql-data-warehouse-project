 INSERT INTO silver.crm_cust_info(
 cst_id,
 cst_key,
 cst_firstname,
 cst_lastname,
 cst_marital_status,
 cst_gndr,
 cst_create_date
 )
 
 select
 cst_id,
 cst_key,
 TRIM(cst_firstname) as cst_firstname,
 TRIM(cst_lastname) as cst_lastname,
CASE WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
		WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
		ELSE 'n/a'
		END cst_marital_status,
 CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
		WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
		ELSE 'n/a'
		END cst_gndr,
 cst_create_date
from (
select
*,
ROW_NUMBER() OVER (partition by cst_id order by cst_create_date desc) as flag_last
from bronze.crm_cust_info
)t where flag_last = 1

--check for unwanted spaces
--expectation : no results

--select cst_firstname
--from bronze.crm_cust_info
--where cst_firstname != TRIM(cst_firstname)


--Data Synchronization and Consistency
select distinct cst_gndr
from bronze.crm_cust_info

select * from silver.crm_cust_info;