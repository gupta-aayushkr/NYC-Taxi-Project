USE nyc_taxi_discovery;

-- Number of trips made as duration of hour
SELECT 
(DATEDIFF(MINUTE, lpep_pickup_datetime, lpep_dropoff_datetime) / 60) as from_hour,
(DATEDIFF(MINUTE, lpep_pickup_datetime, lpep_dropoff_datetime) / 60) + 1 as to_hour,
COUNT(1) AS number_of_trips
  FROM OPENROWSET(
                    BULK 'trip_data_green_parquet/**',
                    FORMAT = 'PARQUET',
                    DATA_SOURCE = 'nyc_taxi_data_raw'
) AS trip_data
GROUP by (DATEDIFF(MINUTE, lpep_pickup_datetime, lpep_dropoff_datetime) / 60),
(DATEDIFF(MINUTE, lpep_pickup_datetime, lpep_dropoff_datetime) / 60) + 1
ORDER BY (DATEDIFF(MINUTE, lpep_pickup_datetime, lpep_dropoff_datetime) / 60),
(DATEDIFF(MINUTE, lpep_pickup_datetime, lpep_dropoff_datetime) / 60) + 1