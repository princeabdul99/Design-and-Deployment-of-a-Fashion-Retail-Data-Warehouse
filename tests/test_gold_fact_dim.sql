

-- Foreign Key Integrity (Dimension)
 --- Expectation: No Result

SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_id = f.customer_id
WHERE c.customer_id IS NULL;

SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_stores c
ON c.store_id = f.store_id
WHERE c.store_id IS NULL;

SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_employees c
ON c.employee_id = f.employee_id
WHERE c.employee_id IS NULL;

SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_products c
ON c.product_id = f.product_id
WHERE c.product_id IS NULL;