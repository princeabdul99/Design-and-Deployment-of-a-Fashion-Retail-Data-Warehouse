/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/    

  --- Checking For Null or Duplicate primary key
  --- Expectation: No Result

  SELECT 
  customerid,
  COUNT(*) 
  FROM silver.crm_customers
  GROUP BY customerid
  HAVING COUNT(*) > 1 OR customerid IS NULL


  --- Check for Unwanted Spaces
  --- If the original value is not equal to the same value after trimming, it means there are spaces!
  ---  Ex: name, email, telephone, city, country, gender, jobtitle
  --- Expectation: No Result

  SELECT 
  name, email, telephone, city, country, gender, jobtitle
  FROM silver.crm_customers
  WHERE name != TRIM(name) 
	OR email != TRIM(email)
	OR telephone != TRIM(telephone)
	OR city != TRIM(city)
	OR country != TRIM(country)
	OR gender != TRIM(gender)
	OR jobtitle != TRIM(jobtitle);

  --- Checking for NULLs
  --- Ex: name, email, telephone, city, country, gender, jobtitle
  --- Expectation: No Result
  SELECT 
  name, email, telephone, city, country, gender, jobtitle, dateofbirth
  FROM silver.crm_customers
  WHERE name IS NULL 
	OR email IS NULL 
	OR telephone IS NULL 
	OR city IS NULL 
	OR country IS NULL 
	OR gender IS NULL 
	OR jobtitle IS NULL 
	OR dateofbirth IS NULL;


 --- Checking Standardization & Consistency
 -->> Value must not be NULL
 --- Expectation: No Duplicate

  SELECT DISTINCT gender 
  FROM silver.crm_customers


 --- Identify Out-of-Range Dates
 --- Expectation: Birthdates between 1924-01-01 and Today
SELECT DISTINCT 
    dateofbirth 
FROM silver.crm_customers
WHERE dateofbirth < '1924-01-01' 
   OR dateofbirth > GETDATE();

SELECT TOP (100) * FROM silver.crm_customers;

SELECT TOP (100) * FROM bronze.crm_customers;
