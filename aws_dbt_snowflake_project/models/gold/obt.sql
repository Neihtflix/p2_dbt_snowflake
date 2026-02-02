/*
============================================================
One Big Table
Model: Gold Layer - Dynamic Star Schema 
Logic: Metadata-driven join engine using Jinja loops
============================================================
*/

{% set configs = var('gold_obt') %}

{# MOVED TO dbt_project.yml AS VARIABLE gold_join_config 

{% set configs= [
    {
        "table": "AIRBNB.SILVER.SILVER_BOOKINGS",
        "columns": "*",
        "alias": "silver_bookings"
    },
    {
        "table": "AIRBNB.SILVER.SILVER_LISTINGS",
        "columns": "silver_listings.HOST_ID, silver_listings.PROPERTY_TYPE, silver_listings.ROOM_TYPE, silver_listings.CITY, silver_listings.COUNTRY, silver_listings.ACCOMMODATES, silver_listings.BEDROOMS, silver_listings.BATHROOMS, silver_listings.PRICE_PER_NIGHT, silver_listings.PRICE_TAG, silver_listings.CREATED_AT AS LISTING_CREATED_AT",
        "alias": "silver_listings",
        "join_condition": "silver_bookings.LISTING_ID = silver_listings.LISTING_ID"
    },
    {
        "table": "AIRBNB.SILVER.SILVER_HOSTS",
        "columns": "silver_hosts.HOST_NAME, silver_hosts.HOST_SINCE, silver_hosts.IS_SUPERHOST, silver_hosts.RESPONSE_RATE, silver_hosts.RESPONSE_RATE_QUALITY, silver_hosts.CREATED_AT AS HOST_CREATED_AT",
        "alias": "silver_hosts",
        "join_condition": "silver_listings.HOST_ID = silver_hosts.HOST_ID"
    },
    
] %} #}

SELECT
    {% for config in configs %}
        {{ config['columns'] }}{% if not loop.last %},{% endif %}
    {% endfor %}
FROM
    {% for config in configs %}
    {% if loop.first %}
        {{ ref(config['table']) }} AS {{ config['alias'] }}
    {% else %}
        LEFT JOIN {{ ref(config['table']) }} AS {{ config['alias'] }}
        ON {{ config['join_condition'] }}
    {% endif %}
    {% endfor %}