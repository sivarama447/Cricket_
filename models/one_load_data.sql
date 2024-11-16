{{ config(materialized='table') }}

with source_data as (

select * from cricket.bronze.ONE_LOAD;

)

select *
from source_data