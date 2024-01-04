use nyc_taxi_discovery;

select * from 
OPENROWSET (
    BULK 'vendor.csv',
    DATA_SOURCE = 'nyc_taxi_data_raw',
    FORMAT = 'CSV',
    PARSER_VERSION = '2.0',
    HEADER_ROW = TRUE,
    FIELDQUOTE = '"'
) AS cal;
