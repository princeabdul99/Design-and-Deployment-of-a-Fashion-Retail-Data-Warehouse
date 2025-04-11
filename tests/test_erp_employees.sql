  --- Checking For Null or Duplicate primary key
  --- Expectation: No Result

  SELECT 
  employeeid,
  COUNT(*) 
  FROM silver.erp_employees
  GROUP BY employeeid
  HAVING COUNT(*) > 1 OR employeeid IS NULL

  
  --- Check for Unwanted Spaces
  --- If the original value is not equal to the same value after trimming, it means there are spaces!
  ---  Ex: name, position
  --- Expectation: No Result

  SELECT 
  name, position
  FROM silver.erp_employees
  WHERE name != TRIM(name) 
	OR position != TRIM(position);



  --- Checking for NULLs
  ---  storeid, name, position
  --- Expectation: No Result

  SELECT storeid, name, position FROM silver.erp_employees
  WHERE 
	storeid IS NULL 
	OR name IS NULL  
	OR position IS NULL;


 -- Check Data Consistency: storeid
 -->> Value must not be NULL, Zero, or Negative
 --- Expectation: No Result

  SELECT DISTINCT storeid 
  FROM silver.erp_employees
  WHERE storeid IS NULL or storeid <= 0


  SELECT * FROM silver.erp_employees;

  SELECT * FROM bronze.erp_employees;