{% for relation in dbt_utils.get_relations_by_prefix(target.schema, 'stg_flight') %}
    {% do log(relation, True) %}
{% endfor %}

{{ 
    config(
        materialized = 'materialized_view',
    )
}}
select aircraft_code, seat_no, fare_conditions
from {{ source('demo_src', 'seats')}}