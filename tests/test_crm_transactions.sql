USE DatawarehouseFashionRetail;


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



SELECT TOP (100)
	 t.invoiceid,
t.line,
t.customerid,
t.productid,
CASE WHEN size IS NULL THEN 'n/a'
	ELSE size
END AS size, 
CASE WHEN color IS NULL THEN 'n/a' 
	ELSE color
END AS color,
t.unitprice,
t.quantity,
t.date,
t.discount,
CASE WHEN linetotal IS NULL OR linetotal <= 0 OR linetotal != ABS(unitprice) * quantity * (1-discount) -- LineTotal = Unit Price x Quantity x (1-Discount)
	THEN ABS(unitprice) * quantity * (1-discount)
	ELSE  linetotal
END AS linetotal,
t.storeid,
t.employeeid,
t.currency,
CASE WHEN currency = 'EUR' THEN '€'
	 WHEN currency = 'GBP' THEN '₤'
	 WHEN currency = 'CNY' THEN '¥'
	 WHEN currency = 'USD' THEN '$'
	ELSE 'n/a'
END AS currencysymbol,      
t.sku,

CASE 
	WHEN RIGHT(sku, 2) = '--' THEN LEFT(sku, LEN(sku) - 2)
	WHEN RIGHT(sku, 1) = '-' THEN LEFT(sku, LEN(sku) - 1)
    ELSE sku
END AS cleaned_sku,

t.transactiontype,
t.paymentmethod,
    agg.InvoiceTotal
FROM 
    bronze.crm_transactions t
LEFT JOIN (
    SELECT 
        invoiceid,
        SUM(
            CASE 
                WHEN transactiontype = 'Sale' THEN ABS(unitprice) * quantity * (1 - discount)
                WHEN transactiontype = 'Return' THEN -1 * ABS(unitprice) * quantity * (1 - discount)
                ELSE 0
            END
        ) AS InvoiceTotal
    FROM bronze.crm_transactions
    GROUP BY invoiceid
) agg
ON t.invoiceid = agg.invoiceid


SELECT TOP (100) * FROM silver.crm_transactions where productid = 1795;