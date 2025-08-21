{{ dbt_utils.date_spine(
    datepart="day",
    start_date="'2019-01-01'",
    end_date="'2020-01-01'"
   )
}}

{{ dbt_utils.generate_series(upper_bound=50) }}

{{ dbt_utils.pretty_time() }}
{{ dbt_utils.pretty_time(format='%Y-%m-%d %H:%M:%S') }}

{{ dbt_utils.log_info("my pretty message") }}
