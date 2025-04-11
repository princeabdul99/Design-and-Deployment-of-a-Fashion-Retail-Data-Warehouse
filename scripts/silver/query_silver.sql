/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This script procedure performs the ET (Extract, Transform) process but 
    uses SSIS to populate the 'silver' schema tables from the 'bronze' schema.
    
	Actions Performed:
		- Inserts transformed and cleansed data from Bronze into Silver tables.
===============================================================================
*/
SELECT
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
