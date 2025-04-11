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
  storeid,
  COUNT(*) 
  FROM silver.erp_stores
  GROUP BY storeid
  HAVING COUNT(*) > 1 OR storeid IS NULL

  --- Check for Unwanted Spaces
  --- If the original value is not equal to the same value after trimming, it means there are spaces!
  ---  Ex: country, city, storename, zipcode
  --- Expectation: No Result

  SELECT 
  zipcode, storename, city, country
  FROM silver.erp_stores
  WHERE zipcode != TRIM(zipcode) OR storename != TRIM(storename) OR city != TRIM(city)  OR country != TRIM(country);

  --- Checking Standardization & Consistency
  ---  Ex: country, city, storename, zipcode

  SELECT DISTINCT storename 
  FROM silver.erp_stores;

  --- Checking for NULLs
  ---  Ex: latitude, longitude, numberofemployees
  --- Expectation: No Result

  SELECT numberofemployees, latitude, longitude  FROM silver.erp_stores
  WHERE numberofemployees IS NULL OR latitude IS NULL  OR longitude IS NULL;

  SELECT 
  storeid,
  country,
  city,
  storename,
  numberofemployees,
  zipcode,
  latitude,
  longitude
  FROM silver.erp_stores;


  SELECT * FROM silver.erp_stores;

  SELECT * FROM bronze.erp_stores;

