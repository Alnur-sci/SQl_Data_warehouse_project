/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'Data_Warehouse_project' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'Data_Warehouse_project' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'DataWarehouse_project' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse_project')
BEGIN
    ALTER DATABASE DataWarehouse_project SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse_project;
END;
GO

-- Create the 'DataWarehouse_project' database
CREATE DATABASE DataWarehouse_project;
GO

USE Data_Warehouse_project;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
