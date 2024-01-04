USE nyc_taxi_ldw;

 --- tranforming vendor in bronze layer from csv to parquet and saving to silver layer
IF OBJECT_ID('silver.vendor') IS NOT NULL
    DROP EXTERNAL TABLE silver.vendor

CREATE EXTERNAL TABLE silver.vendor
    WITH
    (
        DATA_SOURCE = nyc_taxi_src,
        LOCATION = 'silver/vendor',
        FILE_FORMAT = parquet_file_format
    )
AS
SELECT *
  FROM bronze.vendor;


 SELECT * FROM silver.vendor;


 

