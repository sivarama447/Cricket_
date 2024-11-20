-- models/silver/one_load_data_transformed.sql
{{ config(materialized="table", schema=generate_schema_name("Silver", node)) }}

WITH latest_records AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY hash_id ORDER BY get_time_column DESC) AS row_num
    FROM cricket_dev.bronze.One_load_get_date
)
SELECT *
FROM latest_records
WHERE row_num = 1 order by id