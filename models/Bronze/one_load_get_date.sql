{{ config(materialized="table", schema=generate_schema_name("Bronze", node),unique='hash_id') }}

with
    cte as (
        select
            cast(t.id as int) as id,
            batter,
            bowler,
            non_striker,
            cast(runs_batter as int) as runs_batter,
            cast(runs_extras as int) as runs_extras,
            cast(runs_total as int) as runs_total,
            cast(delivery_number as int) as delivery_number,
            cast(over_numer as int) as over_numer,
            team,
            cast(inning_number as int) as inning_number,
            match_name,
            cast(REGEXP_REPLACE(match_id, '[^0-9]', '') as int) AS match_id,
            match_city,
            match_venue,
            match_type,
            team_type,
            match_start_date,
            player_out,
            current_timestamp() as get_time_column,
            md5(
                concat(
                    coalesce(t.delivery_number, ''),'|',
                    coalesce(t.over_numer, ''),'|',
                    coalesce(t.inning_number, ''),'|',
                    coalesce(t.match_id, '')
                )
            ) as hash_id
        from CRICKET_DEV.BRONZE.CRICKET_ONE_LOAD as t
    )
select *
from cte
