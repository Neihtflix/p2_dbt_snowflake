/*
==============================
DDL for the tables
Tool: Snowflake
NB: - Ingestion phase so we are using flexible types (STRING, NUMBER) instead of INT and NVARCHAR
    - + no perf difference between nvarchar and string here
==============================
*/

USE DATABASE AIRBNB;
USE SCHEMA staging;


CREATE OR REPLACE TABLE bookings (
    booking_id STRING,
    listing_id NUMBER,
    booking_date DATE,
    nights_booked NUMBER,
    booking_amount NUMBER,
    cleaning_fee NUMBER,
    service_fee NUMBER,
    booking_status STRING,
    created_at TIMESTAMP,
    PRIMARY KEY(booking_id)
);


CREATE OR REPLACE TABLE listings (
    listing_id NUMBER,
    host_id NUMBER,
    property_type STRING,
    room_type STRING,
    city STRING,
    country STRING,
    accommodates NUMBER,
    bedrooms NUMBER,
    bathrooms NUMBER,
    price_per_night NUMBER,
    created_at TIMESTAMP,
    PRIMARY KEY(listing_id)
);

    
CREATE OR REPLACE TABLE hosts (
    host_id	NUMBER,
    host_name STRING,
    host_since DATE,
    is_superhost BOOLEAN,
    response_rate NUMBER,
    created_at TIMESTAMP,
    PRIMARY KEY(host_id)
);
