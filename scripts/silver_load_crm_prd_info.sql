INSERT INTO silver.crm_prd_info
(
    prd_id,
    cat_id,
    prd_key,
    prd_nn,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt,
    dwh_create_date
)
SELECT
    prd_id,
    REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
    SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,
    prd_nn,
    ISNULL(prd_cost,0) AS prd_cost,
    CASE
        WHEN UPPER(TRIM(prd_line))='M' THEN 'Mountain'
        WHEN UPPER(TRIM(prd_line))='R' THEN 'Road'
        WHEN UPPER(TRIM(prd_line))='S' THEN 'Other Sales'
        WHEN UPPER(TRIM(prd_line))='T' THEN 'Touring'
        ELSE 'N/A'
    END AS prd_line,
    CAST(prd_start_dt AS DATE),
    ISNULL(
        DATEADD(
            DAY,-1,
            LEAD(CAST(prd_start_dt AS DATE))
            OVER(
                PARTITION BY SUBSTRING(prd_key,7,LEN(prd_key))
                ORDER BY CAST(prd_start_dt AS DATE)
            )
        ),
        '9999-12-31'
    ) AS prd_end_dt,
    GETDATE()
FROM bronze.crm_prd_info;