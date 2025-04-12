/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
	DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS
SELECT
	pd.productid		AS product_id,
	pd.category			AS category,
	pd.subcategory		AS subcategory,
	pd.description_en	AS description,
	pd.color			AS color,
	pd.sizes			AS sizes

FROM silver.erp_products pd;
GO

-- =============================================================================
-- Create Dimension: gold.dim_stores
-- =============================================================================
IF OBJECT_ID('gold.dim_stores', 'V') IS NOT NULL
	DROP VIEW gold.dim_stores;
GO

CREATE VIEW gold.dim_stores AS
SELECT 
	st.storeid				AS store_id,
	st.storename			AS store_name,
	st.country				AS country,
	st.city					AS city,
	st.zipcode				AS zipcode,
	st.latitude				AS latitude,
	st.longitude			AS longitude,
	st.numberofemployees	AS number_of_employees

FROM silver.erp_stores st;
GO

-- =============================================================================
-- Create Dimension: gold.dim_employees
-- =============================================================================
IF OBJECT_ID('gold.dim_employees', 'V') IS NOT NULL
	DROP VIEW gold.dim_employees;
GO

CREATE VIEW gold.dim_employees AS
SELECT 
	em.employeeid	AS employee_id,
	em.storeid		AS store_id,
	em.name			AS fullname,
	em.position		AS position	

FROM silver.erp_employees em;
GO

-- =============================================================================
-- Create Dimension: gold.dim_discounts
-- =============================================================================
IF OBJECT_ID('gold.dim_discounts', 'V') IS NOT NULL
	DROP VIEW gold.dim_discounts;
GO

CREATE VIEW gold.dim_discounts AS
SELECT 
	ROW_NUMBER() OVER(ORDER BY dt.startdate) AS discount_key,
	dt.startdate		AS start_date,
	dt.enddate			AS end_date,
	dt.discount			AS discount,
	dt.description		AS description,

	CASE 
		WHEN pr.category != 'n/a' THEN pr.category -- ERP_PRODUCT is the primary source of category
		ELSE COALESCE(dt.category, 'n/a')  -- Fallback to ERP_DISCOUNT data
	END AS category,
	CASE 
		WHEN pr.subcategory != 'n/a' THEN pr.subcategory -- ERP_PRODUCT is the primary source of category
		ELSE COALESCE(dt.subcategory, 'n/a')  -- Fallback to ERP_DISCOUNT data
	END AS subcategory

FROM silver.erp_discounts dt
LEFT JOIN silver.erp_products pr
	ON dt.category = pr.category AND dt.subcategory = pr.subcategory;
GO


-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
	DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS
SELECT 
	ct.customerid		AS customer_id,
	ct.name				AS fullname,
	ct.city				AS city,
	ct.country			AS country,
	ct.gender			AS gender,
	ct.dateofbirth		AS birth_date,
	ct.jobtitle			AS profession

FROM silver.crm_customers ct;
GO


-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
	DROP VIEW gold.fact_sales;
GO

CREATE VIEW gold.fact_sales AS
SELECT 
	
	tn.invoiceid		AS invoice_id,
	tn.sku				AS sku,
	ct.customer_id		AS customer_id,
	ss.store_id			AS store_id,
	em.employee_id		AS employee_id,
	tn.date				AS transaction_date,
	pt.product_id		AS product_id,          
	tn.size,
	tn.color,
	tn.line,
	tn.unitprice		AS unit_price,
	tn.quantity,
	tn.discount,
	tn.linetotal		AS amount_total,
	tn.invoicetotal		AS invoice_total,
	tn.transactiontype	AS transaction_type,
	tn.currency	,
	tn.currencysymbol	AS currency_symbol,
	tn.paymentmethod	AS payment_method

FROM silver.crm_transactions tn
LEFT JOIN gold.dim_customers ct
	ON tn.customerid = ct.customer_id
LEFT JOIN gold.dim_products pt
	ON tn.productid = pt.product_id
LEFT JOIN gold.dim_stores ss
	ON tn.storeid = ss.store_id
LEFT JOIN gold.dim_employees em
	ON tn.employeeid = em.employee_id;
GO
