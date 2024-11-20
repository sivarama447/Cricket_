{{ config(
    materialized="table", schema=generate_schema_name("Gold", node)) }}


WITH source_data AS (
    SELECT 
        CAST(ID AS INT) AS ID, 
        batter, 
        bowler 
    FROM cricket.bronze.one_load
)
SELECT *
FROM source_data
