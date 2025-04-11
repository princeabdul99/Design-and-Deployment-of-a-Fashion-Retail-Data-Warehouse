-- Check for Invalid Dates (Start Date > End Date)
-- Expectation: No Results

SELECT 
 *
FROM bronze.erp_discounts
WHERE startdate > enddate



-- Check for Invalid Dates
-- Expectation: No Invalid Dates
-->> Ex: startdate, enddate

SELECT *
FROM silver.erp_discounts
WHERE TRY_CAST(startdate AS DATE) > GETDATE()
   OR TRY_CAST(startdate AS DATE) < '1900-01-01'
   OR TRY_CAST(startdate AS DATE) > '2050-01-01'
   OR TRY_CAST(startdate AS DATE) > TRY_CAST(enddate AS DATE);


 -- Check Data Consistency: productioncost
 -->> Value must not be NULL, Zero, or Negative
 --- Expectation: No Result

  SELECT DISTINCT discount 
  FROM silver.erp_discounts
  WHERE discount IS NULL or discount <= 0



  --- Check for Unwanted Spaces
  --- If the original value is not equal to the same value after trimming, it means there are spaces!
  ---  Ex: description, category, subcategory
  --- Expectation: No Result

  SELECT 
  description, category, subcategory
  FROM silver.erp_discounts
  WHERE description != TRIM(description) 
	OR category != TRIM(category) 
	OR subcategory != TRIM(subcategory);



  --- Checking for NULLs
  --- Ex: description, category, subcategory
  --- Expectation: No Result

  SELECT 
  description, category, subcategory
  FROM silver.erp_discounts
  WHERE description IS NULL  
	OR category IS NULL  
	OR subcategory IS NULL ; 



 -- Check Data Consistency: category, subcategory
 -->> Value must not be NULL

  SELECT DISTINCT subcategory 
  FROM silver.erp_discounts



  SELECT * FROM silver.erp_discounts;