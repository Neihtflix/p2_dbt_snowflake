# p2-dbt-snowflake

Airbnb Data Transformation - Modern Data Stack architecture using AWS S3, DBT and Snowflake

This project is an end-to-end data engineering pipeline project that transforms raw Airbnb data into a production-ready Gold Layer. It leverages the Medallion Architecture and a custom Metadata-Driven Join Engine to create scalable, high-performance analytical models.

## 🏗 Architecture

The project is fed with data from an AWS S3 Bucket. Data will be handled in Staging before being divided into three logical layers:

    Bronze: Raw data ingestion from S3 into Snowflake using COPY INTO scripts.

    Silver: Data cleaning, deduplication, and type-casting (Incremental models).

    Gold: Analytical layer featuring a Metadata-Driven Join Engine using Jinja2 templates to dynamically build Star Schemas and OBTs.

## 🛠️ Technical Highlights

1. Metadata-Driven Join Engine

    Unlike traditional static SQL, this project uses a Dynamic SQL Generator. By defining table relationships in dbt_project.yml, the obt.sql model automatically generates complex joins. This allows the warehouse to scale without writing a single new line of SQL code.

2. Scalable Ingestion

    Utilizes Snowflake External Stages and COPY INTO commands to pull data directly from cloud storage, ensuring the pipeline can handle massive datasets.

3. Data Integrity & Testing

    Schema Tests: Automated unique and not_null constraints on primary keys.

    Relationship Tests: Ensures referential integrity between Fact and Dimension tables.


## Getting Started

1. Prerequisites

    A Snowflake account.
    
    dbt-core installed locally (pip install dbt-snowflake).
    
    Raw data files uploaded to an S3 bucket.

2. Snowflake Setup

Before running dbt, execute the initialization scripts located in the scripts/ folder:
    
    scripts/snowflake_setup.sql: Creates databases, warehouses, and schemas.
    
    scripts/ddl_load_bronze.sql: Sets up the S3 Stage and loads raw CSVs into the Bronze layer.

3. Security Configuration

    Move profiles.yml to your local ~/.dbt/ (Mac/Linux) or C:\Users\Name\.dbt\ (Windows) directory.

    The profiles.yml is explicitly ignored by .gitignore.


## 📂 Project Structure

P2_DBT_SNOWFLAKE/
├── aws_dbt_snowflake_project/    # Main dbt project folder
│   ├── analyses/                 # Ad-hoc SQL queries
│   ├── macros/                   # Reusable Jinja macros (like your join engine)
│   ├── models/                   # The core transformation logic
│   │   ├── bronze/               # Raw staging models (simple SELECTs)
│   │   ├── silver/               # Intermediate cleaning & business logic
│   │   └── gold/                 # Final Marts (Facts, Dimensions, and OBTs)
│   ├── seeds/                    # Static CSV data (e.g., country codes)
│   ├── tests/                    # Data quality tests
│   ├── dbt_project.yml           # Project configuration
│   └── packages.yml              # dbt package dependencies (e.g., dbt_utils)
├── scripts/                      # Infrastructure and setup
│   ├── snowflake_setup.sql       # Database/Warehouse creation
│   └── ddl_load_bronze.sql       # AWS to Snowflake ingestion
├── .gitignore                    # To hide target/, logs/, and profiles.yml
└── README.md                     # Your project's front door