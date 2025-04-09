/*
===================================================================
DDL Script: Create Bronze Tables
===================================================================
Script Purpose:
  This script creates tables in the 'bronze' schema, dropping
  existing tables id they already exist.
Run this script to re-define the DDL structure of 'bronze' Tables  
*/

USE DatawarehouseFashionRetail;
GO

IF OBJECT_ID ('bronze.crm_customers', 'U') IS NOT NULL
	DROP TABLE bronze.crm_customers;
GO

CREATE TABLE bronze.crm_customers (
	customerid	INT,
	name		    NVARCHAR (50),
	email		    NVARCHAR(50),
	telephone	  NVARCHAR(50),
	city		    NVARCHAR (50),
	country		  NVARCHAR(50),
	gender		  NVARCHAR(50),
	dateofbirth NVARCHAR(50),
	jobtitle	  NVARCHAR(50)
);
GO

IF OBJECT_ID ('bronze.crm_transactions', 'U') IS NOT NULL
	DROP TABLE bronze.crm_transactions;
GO

CREATE TABLE bronze.crm_transactions (
	invoiceid		    NVARCHAR(50),
	line			      INT,
	customerid		  INT,
	productid		    INT,
	size			      NVARCHAR (50),
	color			      NVARCHAR(50),
	unitprice		    FLOAT,
	quantity		    INT,
	date			      DATETIME,
	discount		    FLOAT,
	linetotal		    FLOAT,
	storeid			    INT,
	employeeid		  INT,
	currency		    NVARCHAR(50),
	currencysymbol	NVARCHAR(50),
	sku				      NVARCHAR(50),
	transactiontype	NVARCHAR(50),
	paymentmethod	  NVARCHAR(50),
	invoicetotal	  FLOAT
);
GO

IF OBJECT_ID ('bronze.erp_discounts', 'U') IS NOT NULL
	DROP TABLE bronze.erp_discounts;
GO

CREATE TABLE bronze.erp_discounts (
	startdate	  DATE,
	enddate		  DATE,
	discount	  FLOAT,
	description NVARCHAR(250),
	category	  NVARCHAR(100),
	subcategory NVARCHAR(100),
); 
GO

IF OBJECT_ID ('bronze.erp_employees', 'U') IS NOT NULL
	DROP TABLE bronze.erp_employees;
GO

CREATE TABLE bronze.erp_employees (
	employeeid	INT,
	storeid		  INT,
	name		    NVARCHAR(100),
	position	  NVARCHAR(100)
); 
GO

IF OBJECT_ID ('bronze.erp_stores', 'U') IS NOT NULL
	DROP TABLE bronze.erp_stores;
GO

CREATE TABLE bronze.erp_stores (
	storeid				    INT,
	country				    NVARCHAR(50),
	city				      NVARCHAR(50),
	storename			    NVARCHAR(100),
	numberofemployees	INT,
	zipcode				    NVARCHAR(50),
	latitude			    FLOAT,
	longitude			    FLOAT
);
GO

IF OBJECT_ID ('bronze.erp_products', 'U') IS NOT NULL
	DROP TABLE bronze.erp_products;
GO

CREATE TABLE bronze.erp_products (
	productid			    INT,
	category			    NVARCHAR(100),
	subcategory			  NVARCHAR(100),
	description_pt		NVARCHAR(200),
	description_de		NVARCHAR(200),
	description_fr		NVARCHAR(200),
	description_es		NVARCHAR(200),
	description_en		NVARCHAR(200),
	description_zh		NVARCHAR(200),
	color				      NVARCHAR(50),
	sizes				      NVARCHAR(100),
	productioncost		NVARCHAR(50),
);
GO
