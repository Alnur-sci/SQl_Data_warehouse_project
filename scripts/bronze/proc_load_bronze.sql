/*
================================================
Stored Procedure: Load Bronze Layer ( Source -> Bronze ) 
================================================
Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external CSV files. 
  It performs the following actions:
    -Truncates the bronze tables before loading data 
    - Uses the 'BULK INSERT' command to load data  from csv Files to bronze tables.
Parameters:
  None.
  this stored procedure does not accept any parameters or return any values.

Usage examples:
  

create or alter procedure Bronze.load_bronze AS

EXEC Bronze.load_bronze

BEGIN

declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime
begin try

set @batch_start_time = getdate();
print '==========================================';
print 'Loading Bronze Layer';
print '==========================================' ;


print'-------------------------------------';
print'Loading CRM Tables' ;
print'-------------------------------------';

SET @start_time = GETDATE();
print '>> Truncating Table: Bronze.crm_cust_info'; 
truncate table Bronze.crm_cust_info;


print '>>Inserting data into: Bronze.crm_cust_info';
BULK INSERT Bronze.crm_cust_info
FROM 'C:\Users\user\Desktop\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH 
(
FIRSTROW = 2 ,
FIELDTERMINATOR = ',',
TABLOCK 
);

SET @end_time = GETDATE();
print '>> Load Duration: ' + cast(datediff (second, @start_time, @end_time) AS NVARCHAR) + ' seconds '
print '>>--------'


SELECT count (*)
FROM Bronze.crm_cust_info

SET @start_time = GETDATE();
print '>> Truncating Table: Bronze.crm_prd_info';
truncate table Bronze.crm_prd_info;


print '>>Inserting data into: Bronze.crm_prd_info';
BULK INSERT Bronze.crm_prd_info
FROM 'C:\Users\user\Desktop\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH 
(
FIRSTROW = 2 ,
FIELDTERMINATOR = ',',
TABLOCK 
);
SET @end_time = GETDATE();
print '>> Load Duration: ' + cast(datediff (second, @start_time, @end_time) AS NVARCHAR) + ' seconds '
print '>>--------'

SELECT count (*)
FROM Bronze.crm_prd_info

SET @start_time = GETDATE();
print '>> Truncating Table: Bronze.crm_sales_details';
truncate table Bronze.crm_sales_details;

print '>>Inserting data into: Bronze.crm_sales_details';
BULK INSERT Bronze.crm_sales_details
FROM 'C:\Users\user\Desktop\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH 
(
FIRSTROW = 2 ,
FIELDTERMINATOR = ',',
TABLOCK 
);
SET @end_time = GETDATE();
print '>> Load Duration: ' + cast(datediff (second, @start_time, @end_time) AS NVARCHAR) + ' seconds '
print '>>--------'

SELECT count (*)
FROM Bronze.crm_sales_details

print'-------------------------------------';
print'Loading ERP Tables' ;
print'-------------------------------------';

SET @start_time = GETDATE();
print '>> Truncating Table: Bronze.erp_cust_az_12';
truncate table Bronze.erp_cust_az_12;

print '>>Inserting data into: Bronze.erp_cust_az_12';
BULK INSERT Bronze.erp_cust_az_12
FROM 'C:\Users\user\Desktop\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
WITH 
(
FIRSTROW = 2 ,
FIELDTERMINATOR = ',',
TABLOCK 
);
SET @end_time = GETDATE();
print '>> Load Duration: ' + cast(datediff (second, @start_time, @end_time) AS NVARCHAR) + ' seconds '
print '>>--------'


SELECT count (*)
FROM Bronze.erp_cust_az_12

SET @start_time = GETDATE();
print '>> Truncating Table: Bronze.erp_loc_a101';
truncate table Bronze.erp_loc_a101;


print '>>Inserting data into: Bronze.erp_loc_a101';
BULK INSERT Bronze.erp_loc_a101
FROM 'C:\Users\user\Desktop\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
WITH 
(
FIRSTROW = 2 ,
FIELDTERMINATOR = ',',
TABLOCK 
);
SET @end_time = GETDATE();
print '>> Load Duration: ' + cast(datediff (second, @start_time, @end_time) AS NVARCHAR) + ' seconds '
print '>>--------'

SELECT count (*)
FROM Bronze.erp_loc_a101

SET @start_time = GETDATE();
print '>>Truncating Table: Bronze.erp_px_cat_g1v2';
truncate table Bronze.erp_px_cat_g1v2;


print '>>Inserting data into: Bronze.erp_px_cat_g1v2';
BULK INSERT Bronze.erp_px_cat_g1v2
FROM 'C:\Users\user\Desktop\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
WITH 
(
FIRSTROW = 2 ,
FIELDTERMINATOR = ',',
TABLOCK 
);
SET @end_time = GETDATE();
print '>> Load Duration: ' + cast(datediff (second, @start_time, @end_time) AS NVARCHAR) + ' seconds '
print '>>--------'

SELECT count (*)
FROM Bronze.erp_px_cat_g1v2

set @batch_end_time = GETDATE ();
print '====================='
print'Loading Bronze layer is completed';
print '-Total load Duration: ' + cast(datediff(second,@batch_start_time, @batch_end_time) as NVARCHAR ) + 'seconds';
print '====================='
end try
begin catch
print '================================'
print 'error occured during loadings bronze layer'
print 'error message' + error_message();
print 'error message' + cast(error_number() as NVARCHAR);
print 'error message' + cast(error_state() as NVARCHAR);
print '================================'
end catch
END
