{{ config(materialized='table') }}

with source_data as (

select id,batter,bowler,non_striker,runs_batter,runs_extras from cricket.bronze.ONE_LOAD


)
select *
from source_data