/*
============================================================
Stored Procedure: Load the source layer from S3 Bucket (S3 -> Snowflake)
============================================================
Script Purpose:
    This stored procedure loads data into the 'staging' schema from csv files in S3 Bucket. 

Parameters:
    None.This stored procedure does not accept any parameters or return any values.

Usage Example:
    -
============================================================
*/
USE DATABASE AIRBNB;

CREATE FILE FORMAT IF NOT EXISTS csv_format
  TYPE = 'CSV' 
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;

--SHOW FILE FORMATS;

CREATE OR REPLACE STAGE snowstage
FILE_FORMAT = csv_format
URL='s3://{url}/';


--SHOW STAGES;

COPY INTO STAGING.BOOKINGS
FROM @snowstage
FILES=('bookings.csv')
CREDENTIALS=(aws_key_id = '{aws_key}', aws_secret_key = '{aws_key}');

COPY INTO STAGING.HOSTS
FROM @snowstage
FILES=('hosts.csv')
CREDENTIALS=(aws_key_id = '{aws_key}', aws_secret_key = '{aws_key}');

COPY INTO STAGING.LISTINGS
FROM @snowstage
FILES=('listings.csv')
CREDENTIALS=(aws_key_id = '{aws_key}', aws_secret_key = '{aws_key}');
