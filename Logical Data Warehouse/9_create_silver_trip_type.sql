USE nyc_taxi_ldw;

--- tranforming trip_type in bronze layer from csv to parquet and saving to silver layer
IF OBJECT_ID('silver.trip_type') IS NOT NULL
    DROP EXTERNAL TABLE silver.trip_type

CREATE EXTERNAL TABLE silver.trip_type
    WITH
    (
        DATA_SOURCE = nyc_taxi_src,
        LOCATION = 'silver/trip_type',
        FILE_FORMAT = parquet_file_format
    )
AS
SELECT *
  FROM bronze.trip_type;


 SELECT * FROM silver.trip_type;


 

