/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs quality checks to validate the integrity, consistency, 
    and accuracy of the Gold Layer. These checks ensure:
    - Uniqueness of surrogate keys in dimension tables.
    - Referential integrity between fact and dimension tables.
    - Validation of relationships in the data model for analytical purposes.

Usage Notes:
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- ====================================================================
-- Checking 'gold.fact_sales'
-- ====================================================================
-- Check the data model connectivity between fact and dimensions
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



-- ====================================================================
-- Checking 'gold.dim_customers'
-- ====================================================================
-- Check for Uniqueness of Customer Id in gold.dim_customers
-- Expectation: No results 
SELECT 
    customer_id,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.dim_products'
-- ====================================================================
-- Check for Uniqueness of Product Id in gold.dim_products
-- Expectation: No results 
SELECT 
    product_id,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.dim_stores'
-- ====================================================================
-- Check for Uniqueness of Store Id in gold.dim_stores
-- Expectation: No results 
SELECT 
    store_id,
    COUNT(*) AS duplicate_count
FROM gold.dim_stores
GROUP BY store_id
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.dim_employees'
-- ====================================================================
-- Check for Uniqueness of Employee Id in gold.dim_employees
-- Expectation: No results 
SELECT 
    employee_id,
    COUNT(*) AS duplicate_count
FROM gold.dim_employees
GROUP BY employee_id
HAVING COUNT(*) > 1;
















