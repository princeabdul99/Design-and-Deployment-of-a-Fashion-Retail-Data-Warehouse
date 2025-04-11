
  --- Checking For Null or Duplicate primary key
  --- Expectation: No Result

  SELECT 
  productid,
  COUNT(*) 
  FROM silver.erp_products
  GROUP BY productid
  HAVING COUNT(*) > 1 OR productid IS NULL


  --- Check for Unwanted Spaces
  --- If the original value is not equal to the same value after trimming, it means there are spaces!
  ---  Ex: category, subcategory, description_pt, description_de, description_fr, description_es, description_en, description_zh, color, sizes
  --- Expectation: No Result

  SELECT 
  category, subcategory, description_pt, description_de, description_fr, description_es, description_en, description_zh, color, sizes
  FROM silver.erp_products
  WHERE category != TRIM(category) 
	OR subcategory != TRIM(subcategory) 
	OR description_pt != TRIM(description_pt)  
	OR description_de != TRIM(description_de) 
	OR description_fr != TRIM(description_fr) 
	OR description_es != TRIM(description_es) 
	OR description_en != TRIM(description_en) 
	OR description_zh != TRIM(description_zh) 
	OR color != TRIM(color) 
	OR sizes != TRIM(sizes);


  --- Checking Standardization & Consistency
  ---  Ex: category, subcategory, color, sizes

  SELECT DISTINCT color 
  FROM silver.erp_products;

  --- Checking for NULLs
  ---  category, subcategory, description_pt, description_de, description_fr, description_es, description_en, description_zh, color, sizes
  --- Expectation: No Result

  SELECT category, subcategory, description_pt, description_de, description_fr, description_es, description_en, description_zh, color, sizes  FROM silver.erp_products
  WHERE 
	category IS NULL 
	OR subcategory IS NULL  
	OR description_pt IS NULL 
	OR description_de IS NULL 
	OR description_fr IS NULL 
	OR description_es IS NULL 
	OR description_en IS NULL 
	OR description_zh IS NULL 
	OR color IS NULL 
	OR sizes IS NULL;

 -- Check Data Consistency: productioncost
 -->> Value must not be NULL, Zero, or Negative
 --- Expectation: No Result

  SELECT DISTINCT productioncost 
  FROM silver.erp_products
  WHERE productioncost IS NULL or productioncost <= 0


  SELECT * FROM silver.erp_products;

  SELECT * FROM bronze.erp_products;

