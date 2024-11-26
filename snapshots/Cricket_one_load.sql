
{% snapshot cricket_one_load %}
    {{
        config(
            target_schema="Silver",
            unique_key=["delivery_number","over_numer","inning_number","match_id"],
            strategy="check",
            check_cols=[
                "batter",
                "bowler",
                "non_striker",
                "runs_batter",
                "runs_extras",
                "runs_total",
                "team",
                "match_name",
                "match_city",
                "match_venue",
                "match_type",
                "team_type",
                "match_start_date",
                "player_out",
            ]
        )
    }}
    with
        cte as (
            select
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
                cast(regexp_replace(match_id, '[^0-9]', '') as int) as match_id,
                match_city,
                match_venue,
                match_type,
                team_type,
                match_start_date,
                player_out
            from cricket_dev.bronze.cricket_one_load as t
        )
    select *
    from cte order by delivery_number,over_numer,inning_number,match_id
{% endsnapshot %}