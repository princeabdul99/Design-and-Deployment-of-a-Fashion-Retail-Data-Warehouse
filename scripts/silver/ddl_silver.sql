/*
===================================================================
DDL Script: Create Silver Tables
===================================================================
Script Purpose:
  This script creates tables in the 'silver' schema, dropping
  existing tables id they already exist.
Run this script to re-define the DDL structure of 'silver' Tables  
*/

USE DatawarehouseFashionRetail;
GO

IF OBJECT_ID ('silver.crm_customers', 'U') IS NOT NULL
	DROP TABLE silver.crm_customers;
GO

CREATE TABLE silver.crm_customers (
	customerid	INT,
	name		NVARCHAR (50),
	email		NVARCHAR(50),
	telephone	NVARCHAR(50),
	city		NVARCHAR (50),
	country		NVARCHAR(50),
	gender		NVARCHAR(50),
	dateofbirth DATE,
	jobtitle	NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID ('silver.crm_transactions', 'U') IS NOT NULL
	DROP TABLE silver.crm_transactions;
GO

CREATE TABLE silver.crm_transactions (
	invoiceid		NVARCHAR(50),
	line			INT,
	customerid		INT,
	productid		INT,
	size			NVARCHAR (50),
	color			NVARCHAR(50),
	unitprice		FLOAT,
	quantity		INT,
	date			DATETIME,
	discount		FLOAT,
	linetotal		FLOAT,
	storeid			INT,
	employeeid		INT,
	currency		NVARCHAR(50),
	currencysymbol	NVARCHAR(50),
	sku				NVARCHAR(50),
	transactiontype	NVARCHAR(50),
	paymentmethod	NVARCHAR(50),
	invoicetotal	FLOAT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID ('silver.erp_discounts', 'U') IS NOT NULL
	DROP TABLE silver.erp_discounts;
GO

CREATE TABLE silver.erp_discounts (
	startdate	DATE,
	enddate		DATE,
	discount	FLOAT,
	description NVARCHAR(250),
	category	NVARCHAR(100),
	subcategory NVARCHAR(100),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
); 
GO

IF OBJECT_ID ('silver.erp_employees', 'U') IS NOT NULL
	DROP TABLE silver.erp_employees;
GO

CREATE TABLE silver.erp_employees (
	employeeid	INT,
	storeid		INT,
	name		NVARCHAR(100),
	position	NVARCHAR(100),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
); 
GO

IF OBJECT_ID ('silver.erp_stores', 'U') IS NOT NULL
	DROP TABLE silver.erp_stores;
GO

CREATE TABLE silver.erp_stores (
	storeid				INT,
	country				NVARCHAR(50),
	city				NVARCHAR(50),
	storename			NVARCHAR(100),
	numberofemployees	INT,
	zipcode				NVARCHAR(50),
	latitude			FLOAT,
	longitude			FLOAT,
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO

IF OBJECT_ID ('silver.erp_products', 'U') IS NOT NULL
	DROP TABLE silver.erp_products;
GO

CREATE TABLE silver.erp_products (
	productid			INT,
	category			NVARCHAR(100),
	subcategory			NVARCHAR(100),
	description_pt		NVARCHAR(200),
	description_de		NVARCHAR(200),
	description_fr		NVARCHAR(200),
	description_es		NVARCHAR(200),
	description_en		NVARCHAR(200),
	description_zh		NVARCHAR(200),
	color				NVARCHAR(50),
	sizes				NVARCHAR(100),
	productioncost		FLOAT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO
