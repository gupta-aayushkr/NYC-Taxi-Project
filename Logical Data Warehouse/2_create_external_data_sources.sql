USE nyc_taxi_ldw;

-- DROP EXTERNAL DATA SOURCE nyc_taxi_src;

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'nyc_taxi_src')
    CREATE EXTERNAL DATA SOURCE nyc_taxi_src
    WITH
    (    LOCATION         = 'https://synapseprojdl.dfs.core.windows.net/nyc-taxi-data'
    );