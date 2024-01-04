USE nyc_taxi_discovery;

/* Identify the percentage of cash and credit card trips by borough
Example Data As below
----------------------------------------------------------------------------------------------
borough	    total_trips	cash_trips	card_trips	cash_trips_percentage	card_trips_percentage
----------------------------------------------------------------------------------------------
Bronx	    2019	    751	        1268	    37.20	                62.80
Brooklyn	6435	    2192	    4243	    34.06	                65.94
----------------------------------------------------------------------------------------------
*/
WITH v_payment_type AS
(
SELECT CAST(JSON_VALUE(jsonDoc, '$.payment_type') AS SMALLINT) payment_type,
        CAST(JSON_VALUE(jsonDoc, '$.payment_type_desc') AS VARCHAR(15)) payment_type_desc
  FROM OPENROWSET(
      BULK 'payment_type.json',
      DATA_SOURCE = 'nyc_taxi_data_raw',
      FORMAT = 'CSV',
      PARSER_VERSION = '1.0', 
      FIELDTERMINATOR = '0x0b',
      FIELDQUOTE = '0x0b',
      ROWTERMINATOR = '0x0a'
  )
  WITH
  (
      jsonDoc NVARCHAR(MAX)
  ) AS payment_type
),
v_taxi_zone AS
(
SELECT
 *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi-data@synapseprojdl.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR ='\n'
    ) AS [result]
),
v_trip_data AS
(
SELECT 
 *
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/**',
        FORMAT = 'PARQUET',
        DATA_SOURCE = 'nyc_taxi_data_raw'
  ) AS [result]
)
select v_taxi_zone.Borough, 
sum(case when PULocationID IS NOT NULL THEN 1 else NULL end) as total_trips,
sum(case when v_payment_type.payment_type_desc = 'Cash' then 1 else null end) as cash_trips,
sum(case when v_payment_type.payment_type_desc = 'Credit Card' then 1 else null end) as card_trips,
       CAST((SUM(CASE WHEN v_payment_type.payment_type_desc = 'Cash' THEN 1 ELSE 0 END)/ CAST(COUNT(1) AS DECIMAL)) * 100 AS DECIMAL(5, 2)) AS cash_trips_percentage,
       CAST((SUM(CASE WHEN v_payment_type.payment_type_desc = 'Credit card' THEN 1 ELSE 0 END)/ CAST(COUNT(1) AS DECIMAL)) * 100 AS DECIMAL(5, 2)) AS card_trips_percentage,
ROUND((sum(case when v_payment_type.payment_type_desc = 'Cash' then 1 else 0 end))/(sum(case when PULocationID IS NOT NULL THEN 1 else 0 end)),2) as cash_trips_percentage,
ROUND((sum(case when v_payment_type.payment_type_desc = 'Credit Card' then 1 else 0 end))/(sum(case when PULocationID IS NOT NULL THEN 1 else 0 end)),2) as card_trips_percentage
from v_trip_data
left join v_taxi_zone on v_taxi_zone.LocationID = v_trip_data.PULocationID
left join v_payment_type on v_payment_type.payment_type = v_trip_data.payment_type
WHERE v_payment_type.payment_type_desc IN ('Cash', 'Credit card')
GROUP by v_taxi_zone.Borough
ORDER BY v_taxi_zone.Borough;
