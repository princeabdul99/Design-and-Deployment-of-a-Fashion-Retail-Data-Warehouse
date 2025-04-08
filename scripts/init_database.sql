/*
============================================================================================
Create Database and Schemas
============================================================================================
Script Purpose:
  This script create a new database named 'DatawarehouseFashionRetail' after checking if it
  already exists. If the database exists, it is dropped and recreated. Additionally, the
  script sets up three schemas within the database: 'bronze', 'silver', 'gold'.

WARNING:
  Running this script will drop the entire 'DatawarehouseFashionRetail' database if it exists.
  All data in the database will be permanently deleted. Proceed with caution and ensure you
  have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'DatawarehouseFashionRetail' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DatawarehouseFashionRetail')
BEGIN
  ALTER DATABASE DatawarehouseFashionRetail SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DatawarehouseFashionRetail;
END;
GO
  
-- Create the 'DatawarehouseFashionRetail' Database 
CREATE DATABASE DatawarehouseFashionRetail;
GO

-- CREATE SCHEMAS
USE DatawarehouseFashionRetail;
GO

CREATE SCHEMA bronze;
GO 

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO


