
{% set aircrafts_query %}
select aircraft_code
from {{ ref('stg_flight__aircrafts')}}
{% endset%}

{% set aircrafts_query_result = run_query(aircrafts_query) %}
{% if execute %}
    {% set aircrafts = aircrafts_query_result.columns[0].values() %}
{% else%}
    {% set aircrafts = ["CN1","321","SU9"] %}
{% endif %}

select 
    {% for aircraft in aircrafts -%}
    sum(case when aircraft_code = '{{ aircraft }}' then 1 else 0 end) as count_{{ aircraft }} {%- if not loop.last %},{% endif %}
    {% endfor %}
from {{ ref('stg_flight__flights') }}