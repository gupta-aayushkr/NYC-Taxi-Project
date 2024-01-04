-- This is auto-generated code
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://synapseprojdl.dfs.core.windows.net/nyc-taxi-data/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0'
    ) AS [result];


--- abfss container call
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi-data@synapseprojdl.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR ='\n'
    ) AS [result]

-- Use WITH clause to provide explicit data types
SELECT
    *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi-data@synapseprojdl.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n'
    ) 
    WITH (
        LocationID SMALLINT,
        Borough VARCHAR(15),
        Zone VARCHAR(50),
        service_zone VARCHAR(15)
    )AS [result]


-- creating new db
create DATABASE nyc_taxi_discovery;

use nyc_taxi_discovery;

--- changing collation at database level
ALTER DATABASE nyc_taxi_discovery COLLATE Latin1_General_100_CI_AI_SC_UTF8;

-- Use WITH clause to provide explicit data types
SELECT
    *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi-data@synapseprojdl.dfs.core.windows.net/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = TRUE,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n'
    ) 
    WITH (
        LocationID SMALLINT,
        Borough VARCHAR(15),
        Zone VARCHAR(50),
        service_zone VARCHAR(15)
    )AS [result]

-- Read data from a file without header
SELECT
    *
FROM
    OPENROWSET(
        BULK 'abfss://nyc-taxi-data@synapseprojdl.dfs.core.windows.net/raw/taxi_zone_without_header.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n'
    ) 
    WITH (
        Zone VARCHAR(50) 3,
        Borough VARCHAR(15) 2
    )
AS [result]

-- external data source for nyc_taxi_data
CREATE EXTERNAL DATA SOURCE nyc_taxi_data_raw
WITH
(
    LOCATION = 'abfss://nyc-taxi-data@synapseprojdl.dfs.core.windows.net/raw/'
)


-- Using data source in the query
SELECT
    *
FROM
    OPENROWSET(
        BULK 'taxi_zone_without_header.csv',
        DATA_SOURCE = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n'
    ) 
    WITH (
        Zone VARCHAR(50) 3,
        Borough VARCHAR(15) 2
    )
AS [result]
