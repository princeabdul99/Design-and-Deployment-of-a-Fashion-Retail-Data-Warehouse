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


  --- Checking for NULLs
  --- Ex: invoiceid, customerid, productid, storeid, employeeid, sku
  --- Expectation: No Result

  SELECT 
  sku
  FROM silver.crm_transactions
  WHERE sku IS NULL;

 -- Check Data Consistency: productioncost
 -->> Value must not be NULL, Zero, or Negative
 --- Ex: line, unitprice, quantity, discount, linetotal
 --- Expectation: No Result

  SELECT DISTINCT linetotal, discount 
  FROM silver.crm_transactions
  WHERE linetotal IS NULL or linetotal <= 0 
	OR discount IS NULL or discount <= 0;



 --- Checking Standardization & Consistency
 -->> Value must not be NULL
 --- Ex: size, color, currency, currencysymbol, transactiontype, paymentmethod
 --- Expectation: No Duplicate

  SELECT DISTINCT transactiontype 
  FROM silver.crm_transactions


 -- Check for Invalid Dates
-- Expectation: No Invalid Dates
-->> Ex: date

SELECT *
FROM silver.crm_transactions 
WHERE TRY_CAST(date AS DATE) > GETDATE()
   OR TRY_CAST(date AS DATE) < '1900-01-01'
   OR TRY_CAST(date AS DATE) > '2050-01-01'
   OR TRY_CAST(date AS DATE) > GETDATE();

-- Identify Out-of-Range Dates
-- Expectation: date between 1924-01-01 and Today
SELECT DISTINCT 
    date 
FROM silver.crm_transactions
WHERE date < '1924-01-01' 
   OR date > GETDATE();


-- Check total number of row records
-- Expectation: match the total row record on bronze table
SELECT COUNT(*) FROM silver.crm_transactions ;


SELECT TOP (100) * FROM silver.crm_transactions where productid = 1795;
